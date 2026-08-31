local compose_path = vim.fn.expand("$DOTFILES_DIR/etc/plantuml/compose.yaml")
local tmp_dir = "/tmp/plantuml-viewer/"
local port = 8765
local file_port = 8766

local preview_bufnr = nil

-- NOTE: dangerouslySetInnerHTML では <script> は実行されないけど <img onerror> は実行される
-- 画像拡大
local image_zoom_script =
	[=[<img src='_' onerror="if(!window._imgZoom){var _K='_mdImgZoom';var _ld=function(){try{return JSON.parse(sessionStorage.getItem(_K))||{}}catch(_){return{}}};window._imgZoom=_ld();var _sv=function(){try{sessionStorage.setItem(_K,JSON.stringify(window._imgZoom))}catch(_){}};var _ikey=function(t){var u=t.getAttribute('data-uml-key');if(u)return u;var s=t.getAttribute('src')||'';var a=document.getElementsByTagName('img');var n=0;for(var i=0;i<a.length;i++){if(a[i]===t)break;if((a[i].getAttribute('src')||'')===s)n++}return s+'#'+n};var _noAnim=function(t,fn){var p=t.style.transition;t.style.transition='none';fn();void t.offsetWidth;t.style.transition=p};var _iap=function(t,w){t.classList.add('enlarged');if(w){t.style.width=w;return w}var nw=t.naturalWidth;if(!nw){t.addEventListener('load',function(){var r;_noAnim(t,function(){r=_iap(t)});if(r){window._imgZoom[_ikey(t)]=r;_sv()}},{once:true});return null}var cw=(t.closest('.markdown-body')||document.body).clientWidth;var r=nw>cw?nw+'px':'100%';t.style.width=r;return r};var _ires=function(){var a=document.getElementsByTagName('img');for(var i=0;i<a.length;i++){var t=a[i];if(t.getAttribute('src')==='_')continue;var v=window._imgZoom[_ikey(t)];if(v){if(!t.classList.contains('enlarged'))_noAnim(t,function(){_iap(t,(typeof v==='string'&&!t.hasAttribute('data-uml-key'))?v:null)})}else if(t.classList.contains('enlarged'))_noAnim(t,function(){t.classList.remove('enlarged');t.style.width=''})}};document.addEventListener('click',function(e){var t=e.target;if(t.tagName!=='IMG')return;var k=_ikey(t);if(t.classList.contains('enlarged')){delete window._imgZoom[k];t.classList.remove('enlarged');t.style.width=''}else{window._imgZoom[k]=_iap(t)||true}_sv();e.preventDefault();e.stopPropagation()});_ires();new MutationObserver(_ires).observe(document.body||document.documentElement,{childList:true,subtree:true,attributes:true,attributeFilter:['src']})}" style="display:none;">]=]
-- GitHub-style Alerts
local alert_script =
	[=[<img src='_' onerror="if(!window._ghAlert){window._ghAlert=true;var L={NOTE:'Note',TIP:'Tip',IMPORTANT:'Important',WARNING:'Warning',CAUTION:'Caution'};function _pa(){document.querySelectorAll('blockquote:not([data-alert])').forEach(function(b){var p=b.querySelector('p');if(!p)return;var m=p.textContent.match(/^\s*\[!(NOTE|TIP|IMPORTANT|WARNING|CAUTION)\]/);if(!m)return;var tp=m[1].toLowerCase();b.setAttribute('data-alert',tp);b.className='markdown-alert markdown-alert-'+tp;var d=document.createElement('p');d.className='markdown-alert-title markdown-alert-title-'+tp;d.textContent=L[m[1]];p.innerHTML=p.innerHTML.replace(/\[!(NOTE|TIP|IMPORTANT|WARNING|CAUTION)\]\s*/,'');b.insertBefore(d,b.firstChild);if(!p.textContent.trim()&&!p.innerHTML.trim())p.remove()})}_pa();new MutationObserver(_pa).observe(document.body||document.documentElement,{childList:true,subtree:true})}" style="display:none;">]=]
-- detailsの開閉状態を保持
local details_script =
	[=[<img src='_' onerror="if(!window._ds){window._ds={};window._dr=false;document.addEventListener('toggle',function(e){if(window._dr)return;if(e.target.tagName==='DETAILS'){var a=document.querySelectorAll('details');for(var i=0;i<a.length;i++){if(a[i]===e.target){window._ds[i]=e.target.open;break}}}},true);new MutationObserver(function(){window._dr=true;document.querySelectorAll('details').forEach(function(d,i){if(window._ds[i]!==undefined)d.open=window._ds[i]});window._dr=false}).observe(document.body||document.documentElement,{childList:true,subtree:true})}" style="display:none;">]=]
-- markdown-preview.nvimはplantumlを圧縮してURLに埋め込む際にバグがあり画像が壊れる場合があるので、
-- nvim側でSVG化して画像を挿入することにしプラグイン生成のimgタグは非表示にする。
local hide_uml_img_style = ('<style>img[src*="127.0.0.1:%d/svg/"]{display:none}</style>'):format(port)

local scripts = { hide_uml_img_style, image_zoom_script, alert_script, details_script }
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

-- data-uml-keyは拡大状態保存キー（図を編集するとURLのハッシュ値が変わるので、出現順をキーに使う）
local uml_img_template =
	[=[<img src="_" data-uml="%s" data-uml-key="uml-%d" onerror="this.onerror=null;this.src='http://127.0.0.1:%d/%s'">]=]

local function uml_img_tag(name, index)
	return uml_img_template:format(name, index, file_port, name)
end

local uml_img_pattern = '^<img src="_" data%-uml="uml%-%x+%.svg"'
local uml_error_line = "<p data-uml-error>PlantUML のレンダリングに失敗しました</p>"
local uml_error_pattern = "^<p data%-uml%-error>"

-- プレビュー用に挿入したSVG画像を消す
local function remove_uml_images(bufnr)
	if not vim.api.nvim_buf_is_valid(bufnr) then
		return
	end

	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
	for i = #lines, 1, -1 do
		if lines[i]:match(uml_img_pattern) or lines[i]:match(uml_error_pattern) then
			-- 挿入時につけた直後の空行も消す
			local last = lines[i + 1] == "" and i + 1 or i
			vim.api.nvim_buf_set_lines(bufnr, i - 1, last, false, {})
		end
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
		remove_uml_images(bufnr)
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

local function start_file_server()
	-- すでに起動してたらそれを使う
	local check = vim.system({ "curl", "-s", "-o", "/dev/null", "-m", "1", ("http://127.0.0.1:%d/"):format(file_port) })
		:wait()
	if check.code == 0 then
		return
	end

	-- 応答が無い場合はハングしている可能性があるので、ポートを掴んでいるプロセスを掃除してから起動し直す
	vim.system({ "pkill", "-f", "python -m http.server " .. file_port }):wait()
	vim.system({ "python", "-m", "http.server", tostring(file_port), "--directory", tmp_dir })
end

-- @startgantt や @startmindmap のように図の種類が書かれている場合はそのまま送信
local function wrap_uml(body)
	if ("\n" .. body):match("\n%s*@start") then
		return body
	end
	return "@startuml\n" .. body .. "\n@enduml"
end

-- バッファー内のplantumlブロックを列挙
local function find_plantuml_blocks(bufnr)
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
	local blocks = {}
	local i = 1
	while i <= #lines do
		local fence, info = lines[i]:match("^(```+)(.*)$")
		if fence and info:lower():find("plantuml", 1, true) then
			local j = i + 1
			while j <= #lines and not lines[j]:match("^" .. fence .. "%s*$") do
				j = j + 1
			end
			-- 閉じてないブロックとからのブロックは無視
			if j <= #lines and j > i + 1 then
				table.insert(blocks, {
					lnum = i,
					source = wrap_uml(table.concat(vim.list_slice(lines, i + 1, j - 1), "\n")),
				})
			end
			i = j + 1
		else
			i = i + 1
		end
	end
	return blocks
end

-- SVG画像をtmp_dirに置く
local function render_uml(source, callback, attempt)
	attempt = attempt or 1
	local name = ("uml-%s.svg"):format(vim.fn.sha256(source):sub(1, 16))
	local path = tmp_dir .. name
	if vim.uv.fs_stat(path) then
		callback(name)
		return
	end

	vim.system({
		"curl",
		"-s",
		"-f",
		"-H",
		"Content-Type: application/text; charset=UTF-8",
		"--data-binary",
		"@-",
		("http://127.0.0.1:%d/svg/"):format(port),
	}, { text = true, stdin = source }, function(obj)
		if obj.code ~= 0 or obj.stdout == "" then
			-- コンテナ起動を待つ
			if attempt < 15 then
				vim.defer_fn(function()
					render_uml(source, callback, attempt + 1)
				end, 1000)
			else
				callback(nil)
			end
			return
		end

		local f = io.open(path, "w")
		if not f then
			callback(nil)
			return
		end
		f:write(obj.stdout)
		f:close()
		callback(name)
	end)
end

local function refresh_uml_images(bufnr)
	if vim.bo.filetype == "markdown" then
		remove_uml_images(bufnr)

		local blocks = find_plantuml_blocks(bufnr)
		if #blocks == 0 then
			return
		end

		vim.fn.mkdir(tmp_dir, "p")
		start_file_server()

		local results = {}
		local remaining = #blocks
		for index, block in ipairs(blocks) do
			render_uml(block.source, function(name)
				if name then
					table.insert(results, { lnum = block.lnum, line = uml_img_tag(name, index) })
				else
					table.insert(results, { lnum = block.lnum, line = uml_error_line })
				end

				remaining = remaining - 1
				if remaining > 0 then
					return
				end

				vim.schedule(function()
					if not preview_bufnr or not vim.api.nvim_buf_is_valid(bufnr) then
						return
					end

					table.sort(results, function(a, b)
						return a.lnum > b.lnum
					end)
					-- HTMLブロックは空行までが範囲なので、空行を挟む必要がある
					for _, result in ipairs(results) do
						vim.api.nvim_buf_set_lines(bufnr, result.lnum - 1, result.lnum - 1, false, { result.line, "" })
					end
					vim.bo[bufnr].modified = false
				end)
			end)
		end
	end
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
	if vim.bo.filetype == "markdown" then
		local header = {}
		for _, script in ipairs(scripts) do
			table.insert(header, script)
		end
		table.insert(header, "")
		vim.api.nvim_buf_set_lines(bufnr, 0, 0, false, header)
		vim.bo[bufnr].modified = false
	end

	vim.cmd("MarkdownPreview")

	preview_bufnr = bufnr
	refresh_uml_images(bufnr)

	local group_id = vim.api.nvim_create_augroup("MarkdownPreview", { clear = true })

	local function pre_callback()
		if not preview_bufnr then
			return
		end

		remove_preview_script(bufnr)
		remove_uml_images(bufnr)
	end

	local function post_callback()
		if not preview_bufnr then
			return
		end

		if vim.bo.filetype == "markdown" then
			local header = {}
			for _, script in ipairs(scripts) do
				table.insert(header, script)
			end
			table.insert(header, "")
			vim.api.nvim_buf_set_lines(bufnr, 0, 0, false, header)
			vim.bo[bufnr].modified = false
		end

		refresh_uml_images(bufnr)
	end

	local is_age = vim.fn.expand("%:e") == "age"
	-- ageファイルの場合は保存前後でバッファーの内容を退避・復元するので、暗号化前のAgeEncryptPreだけでフックする
	if is_age then
		vim.api.nvim_create_autocmd({ "User" }, {
			group = group_id,
			pattern = "AgeEncryptPre",
			callback = function(args)
				if args.data.bufnr ~= bufnr then
					return
				end

				pre_callback()
			end,
		})
		vim.api.nvim_create_autocmd({ "User" }, {
			group = group_id,
			pattern = "AgeEncryptPost",
			callback = function()
				post_callback()
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
			callback = post_callback,
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
	vim.uv.fs_copyfile(vim.fn.expand("$DOTFILES_DIR/etc/plantuml/viewer.html"), tmp_dir .. "viewer.html")
	-- 前回起動したプロセスが残っていたらkill
	vim.system({ "pkill", "-f", "python -m http.server " .. file_port }):wait()
	vim.system({ "python", "-m", "http.server", file_port, "--directory", tmp_dir })
	vim.system({
		"open",
		"-n",
		"-a",
		vim.fn.expand("$TARGET_BROWSER"),
		"--args",
		("http://localhost:%d/viewer.html?filename=%s"):format(file_port, filename),
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
