local compose_path = vim.fn.expand("$DOTFILE/etc/plantuml/compose.yaml")
local tmp_dir = "/tmp/plantuml-viewer/"
local port = 8765

local preview_bufnr = nil

-- NOTE: dangerouslySetInnerHTML では <script> は実行されないけど <img onerror> は実行される
-- 画像拡大
local image_zoom_script =
	[=[<img src='_' onerror="if(!window._imgClick){window._imgClick=true;document.addEventListener('click',function(e){var t=e.target;if(t.tagName==='IMG'){t.classList.toggle('enlarged');e.preventDefault();e.stopPropagation()}else{document.querySelectorAll('img.enlarged').forEach(function(i){i.classList.remove('enlarged')})}})}" style="display:none;">]=]
-- GitHub-stle Alerts
local alert_script =
	[=[<img src='_' onerror="if(!window._ghAlert){window._ghAlert=true;var L={NOTE:'Note',TIP:'Tip',IMPORTANT:'Important',WARNING:'Warning',CAUTION:'Caution'};function _pa(){document.querySelectorAll('blockquote:not([data-alert])').forEach(function(b){var p=b.querySelector('p');if(!p)return;var m=p.textContent.match(/^\s*\[!(NOTE|TIP|IMPORTANT|WARNING|CAUTION)\]/);if(!m)return;var tp=m[1].toLowerCase();b.setAttribute('data-alert',tp);b.className='markdown-alert markdown-alert-'+tp;var d=document.createElement('p');d.className='markdown-alert-title markdown-alert-title-'+tp;d.textContent=L[m[1]];p.innerHTML=p.innerHTML.replace(/\[!(NOTE|TIP|IMPORTANT|WARNING|CAUTION)\]\s*/,'');b.insertBefore(d,b.firstChild);if(!p.textContent.trim()&&!p.innerHTML.trim())p.remove()})}_pa();new MutationObserver(_pa).observe(document.body||document.documentElement,{childList:true,subtree:true})}" style="display:none;">]=]
-- detilsの開閉状態を保持
local details_script =
	[=[<img src='_' onerror="if(!window._ds){window._ds={};window._dr=false;document.addEventListener('toggle',function(e){if(window._dr)return;if(e.target.tagName==='DETAILS'){var a=document.querySelectorAll('details');for(var i=0;i<a.length;i++){if(a[i]===e.target){window._ds[i]=e.target.open;break}}}},true);new MutationObserver(function(){window._dr=true;document.querySelectorAll('details').forEach(function(d,i){if(window._ds[i]!==undefined)d.open=window._ds[i]});window._dr=false}).observe(document.body||document.documentElement,{childList:true,subtree:true})}" style="display:none;">]=]

local scripts = { image_zoom_script, alert_script, details_script }
local function remove_preview_script(bufnr)
	local n = #scripts
	local first = vim.api.nvim_buf_get_lines(bufnr, 0, n + 1, false)
	local remove_count = 0
	for i, script in ipairs(scripts) do
		if first[i] == script then
			remove_count = i
		else
			break
		end
	end
	if remove_count > 0 and first[remove_count + 1] == "" then
		remove_count = remove_count + 1
	end
	if remove_count > 0 then
		vim.api.nvim_buf_set_lines(bufnr, 0, remove_count, false, {})
	end
end

local function cleanup_preview()
	if not preview_bufnr then
		return
	end

	local bufnr = preview_bufnr
	preview_bufnr = nil

	pcall(vim.api.nvim_del_augroup_by_name, "MarkdownPreview")

	if vim.api.nvim_buf_is_valid(bufnr) then
		remove_preview_script(bufnr)
		vim.bo[bufnr].modified = false
	end
end

local function start_plantuml_server()
	vim.system({ "docker", "compose", "-f", compose_path, "up", "-d" }, { text = true }, function(obj)
		if obj.code ~= 0 then
			vim.notify(tostring(obj.code), "error", { render = "default", timeout = 10000 })
		end
	end)
end

local function stop_plantuml_server()
	vim.system({ "docker", "compose", "-f", compose_path, "down" })
end

local function write_svg()
	local filepath = vim.fn.expand("%:p")
	local filename = vim.fn.expand("%:t")
	local outfile = tmp_dir .. "out.svg"
	vim.system({
		"curl",
		"-s",
		"-H",
		"Content-Type: application/text; charset=UTF-8",
		"--data-binary",
		"@" .. filepath,
		("http://localhost:%d/svg/"):format(port),
	}, { text = true }, function(obj)
		if obj.code ~= 0 then
			return
		end
		local f = io.open(outfile, "w")
		if not f then
			return
		end
		f:write(obj.stdout)
		f:close()
		vim.uv.fs_copyfile(outfile, tmp_dir .. filename .. ".svg")
	end)
end

vim.api.nvim_create_user_command("StartPlantUmlServer", start_plantuml_server, {})
vim.api.nvim_create_user_command("StopPlantUmlServer", stop_plantuml_server, {})

vim.api.nvim_create_user_command("MarkdownPreviewWrapper", function()
	start_plantuml_server()

	cleanup_preview()

	-- プレビュー用の加工
	local bufnr = vim.fn.bufnr()
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
	for i, script in ipairs(scripts) do
		table.insert(lines, i, script)
	end
	table.insert(lines, #scripts + 1, "")
	vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
	vim.bo[bufnr].modified = false

	vim.cmd("MarkdownPreview")

	preview_bufnr = bufnr
	local group_id = vim.api.nvim_create_augroup("MarkdownPreview", { clear = true })

	local pre_callback = function()
		if not preview_bufnr then
			return
		end

		remove_preview_script(bufnr)
	end

	local is_age = vim.fn.expand("%:e") == "age"
	-- ageファイルの場合は保存前後でバッファーの内容を退避・復元するので、暗号化前のAgeEncryptPreだけでフックする
	if is_age then
		vim.api.nvim_create_autocmd({ "User" }, {
			group = group_id,
			pattern = "AgeEncryptPre",
			callback = function()
				if args.data.bufnr ~= bufnr then
					return
				end

				pre_callback()
			end,
		})
	else
		-- BufWritePreでスクリプトを消す
		vim.api.nvim_create_autocmd({ "BufWritePre" }, {
			group = group_id,
			buffer = bufnr,
			callback = pre_callback,
		})
		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			group = group_id,
			buffer = bufnr,
			callback = function()
				if not preview_bufnr then
					return
				end

				local cur = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
				for i, script in ipairs(scripts) do
					table.insert(cur, i, script)
				end
				table.insert(cur, #scripts + 1, "")
				vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, cur)
				vim.bo[bufnr].modified = false
			end,
		})
	end

	vim.api.nvim_create_autocmd({ "BufDelete", "BufWipeout" }, {
		group = group_id,
		buffer = bufnr,
		callback = function()
			cleanup_preview()
		end,
	})
	vim.api.nvim_create_autocmd({ "VimLeave" }, {
		group = group_id,
		callback = function()
			cleanup_preview()
		end,
	})
end, {})

vim.api.nvim_create_user_command("PlantUMLPreview", function()
	start_plantuml_server()
	local filename = vim.fn.expand("%:t")
	vim.fn.mkdir(tmp_dir, "p")
	write_svg()
	vim.uv.fs_copyfile(vim.fn.expand("$DOTFILE/etc/plantuml/viewer.html"), tmp_dir .. "viewer.html")
	-- 前回起動したプロセスが残っていたらkill
	local port2 = 8766
	vim.system({ "pkill", "-f", "python -m http.server " .. port2 }):wait()
	vim.system({ "python", "-m", "http.server", port2, "--directory", tmp_dir })
	vim.system({
		"open",
		"-n",
		"-a",
		vim.fn.expand("$TARGET_BROWSER"),
		"--args",
		("http://localhost:%d/viewer.html?filename=%s"):format(port2, filename),
	})
	local group = vim.api.nvim_create_augroup("PlantUMLPreview:" .. filename, { clear = true })
	vim.api.nvim_create_autocmd({ "BufWritePost" }, {
		group = group,
		buffer = vim.fn.bufnr(),
		callback = write_svg,
	})
end, {})

require("utils").create_autocmd({ "FileType" }, {
	pattern = "markdown",
	callback = function(args)
		require("editorconfig").config(args.buf)
	end,
})
