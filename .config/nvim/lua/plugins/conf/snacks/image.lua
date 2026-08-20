-- snacks.image のオプション

-- このサイズを超えるPNGは縮小する
local MAX_PIXELS = 640
local MAX_BYTES = 512 * 1024

-- PNGのIHDRから画像サイズを取得
local function png_size(path)
	local fd = io.open(path, "rb")
	if not fd then
		return nil
	end
	local header = fd:read(24)
	fd:close()
	if not header or #header < 24 or header:sub(2, 4) ~= "PNG" then
		return nil
	end
	local b = { header:byte(17, 24) }
	return b[1] * 0x1000000 + b[2] * 0x10000 + b[3] * 0x100 + b[4],
		b[5] * 0x1000000 + b[6] * 0x10000 + b[7] * 0x100 + b[8]
end

-- SnacksはPNG画像はそのまま渡すので縮小する
-- NOTE: herdrは1フレームのGraphicsペイロードが大きすぎると画像を破棄する
local function resolve(file, src)
	if src:find("^%w%w+://") or not src:lower():match("%.png$") then
		return nil
	end

	local candidates = {}
	if src:match("^[~/]") then
		candidates[1] = vim.fn.expand(src)
	else
		for _, root in ipairs({ vim.fs.dirname(file), vim.uv.cwd() or "." }) do
			table.insert(candidates, root .. "/" .. src)
		end
	end

	local path
	for _, candidate in ipairs(candidates) do
		if vim.fn.filereadable(candidate) == 1 then
			path = vim.uv.fs_realpath(candidate) or vim.fs.normalize(candidate)
			break
		end
	end

	-- 見つからなければSnacksに任せる
	local stat = path and vim.uv.fs_stat(path)
	if not stat then
		return nil
	end

	local width, height = png_size(path)
	local oversized = stat.size > MAX_BYTES or (width ~= nil and (width > MAX_PIXELS or height > MAX_PIXELS))
	if not oversized then
		return nil
	end

	local cache = Snacks.image.config.cache
	vim.fn.mkdir(cache, "p")
	-- mtimeと縮小サイズをハッシュに含める
	local hash = vim.fn.sha256(("%s:%d:%d"):format(path, stat.mtime.sec, MAX_PIXELS)):sub(1, 8)
	local link = ("%s/%s-oversized.png32"):format(cache, hash)
	if not vim.uv.fs_lstat(link) then
		vim.uv.fs_symlink(path, link)
	end
	return link
end

return {
	enabled = true,
	resolve = resolve,
	convert = {
		magick = { default = { "{src}[0]", "-scale", ("%dx%d>"):format(MAX_PIXELS, MAX_PIXELS) } },
	},
}
