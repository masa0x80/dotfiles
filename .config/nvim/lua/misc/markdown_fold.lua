-- コードフェンスの中身もfoldできるようにする
local M = {}

local injections_parsed = {}

-- コードフェンスの中身をその言語のfoldルール（Luaならfunction、Pythonならdefで）で畳めるように
--
-- vim.treesitter.foldexpr() はinjectionを自分でパースせず、描画時にhighlighterがパースし終えた範囲しか見ない。
-- foldレベルは最初の評価時にバッファ単位でキャッスされるので、後からinjectionをパースしても反映されないので、
-- 最初の評価より先にバッファ全体をパースしておく。
local function parse_injections(bufnr)
	if injections_parsed[bufnr] then
		return
	end
	injections_parsed[bufnr] = true

	local parser = vim.treesitter.get_parser(bufnr, nil, { error = false })
	if parser then
		-- rage = true でバッファ全体を injection ごとパースする
		parser:parse(true)
	end
end

-- PlantUMLにはtreesitter paarseがない
local function fold_delta(line)
	local s = vim.trim(line)

	-- コメント内のmarkerを見る
	if s:match("^'") then
		return s:find("{{{", 1, true) and 1 or 0, s:find("}}}", 1, true) and 1 or 0
	end

	local directive = s:match("^!%s*(%a+)")

	-- !unquoted と !final は procedureやfunctionの修飾子なので読み飛ばす
	if directive == "unquoted" or directive == "final" then
		directive = s:match("^!%s*%a+%s+(%a+)")
	end

	if directive then
		if directive == "if" or directive == "procedure" or directive == "function" then
			return 1, 0
		end
		if directive == "endif" or directive == "endprocedure" or directive == "endfunction" then
			return 0, 1
		end

		-- !globalや!returnなどブロックを作らないもの
		return 0, 0
	end

	if s:match("^@start") then
		return 1, 0
	end
	if s:match("^@end") then
		return 0, 1
	end
	if s:match("^<style>") then
		return 1, 0
	end
	if s:match("^</style>") then
		return 0, 1
	end

	-- class Hoge { … } や skinparam { … }
	if s:match("{$") then
		return 1, 0
	end
	if s == "}" then
		return 0, 1
	end

	return 0, 0
end

-- PlantUMLフェンス内の各行に対してフェンス自身のfoldレベルからの相対的な深さを求める。
-- treesitterが返すレベルに後から追加する。
local function scan_plantuml(bufnr)
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
	local depths, opens = {}, {}
	local i = 1

	while i < #lines do
		local fence, info = lines[i]:match("^(```+)(.*)$")

		if fence and info:lower():find("plantuml", 1, true) then
			local depth = 0
			local j = i + 1

			while j <= #lines and not lines[j]:match("^" .. fence .. "%s*$") do
				local o, c = fold_delta(lines[j])

				if o > c then
					depth = depth + o - c
					depths[j], opens[j] = depth, true
				else
					-- 閉じる行は畳まれる側に含まれる
					depths[j] = depth
					depth = math.max(depth - (c - o), 0)
				end

				j = j + 1
			end

			i = j + 1
		else
			i = i + 1
		end
	end

	return depths, opens
end

local cache = {}

local function plantuml_depths(bufnr)
	local tick = vim.api.nvim_buf_get_changedtick(bufnr)
	local cached = cache[bufnr]

	if not cached or cached.tick ~= tick then
		local depths, opens = scan_plantuml(bufnr)
		cached = { tick = tick, depths = depths, opens = opens }
		cache[bufnr] = cached
	end

	return cached
end

M.foldexpr = function()
	local bufnr = vim.api.nvim_get_current_buf()
	local lnum = vim.v.lnum

	parse_injections(bufnr)

	local level = vim.treesitter.foldexpr(lnum)
	local cached = plantuml_depths(bufnr)
	local depth = cached.depths[lnum]

	if not depth or depth == 0 then
		return level
	end

	-- treesitterが返したフェンスのレベルにPlantUML側の深さを積む
	local base = tonumber(level:match("%d+")) or 0

	return (cached.opens[lnum] and ">" or "") .. (base + depth)
end

M.reset = function(bufnr)
	injections_parsed[bufnr] = nil
	cache[bufnr] = nil
end

return M
