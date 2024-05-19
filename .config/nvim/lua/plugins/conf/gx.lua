---@diagnostic disable-next-line: missing-fields
require("gx").setup({
	handlers = {
		plugin = true,
		github = true,
		brewfile = true,
		package_json = true,
		search = true,
		go = true,
		jira = {
			name = "jira",
			handle = function(mode, line, _)
				local ticket = require("gx.helper").find(line, mode, "(%u[%u%d]+-%d+)")
				local url_base = vim.env.JIRA_BASE_URL
				if url_base ~= nil and ticket and #ticket < 20 then
					return url_base .. ticket
				end
			end,
		},
		rust = {
			name = "rust",
			filetype = { "toml" },
			filename = "Cargo.toml",
			handle = function(mode, line, _)
				local crate = require("gx.helper").find(line, mode, "(%w+)%s-=%s")

				if crate then
					return "https://crates.io/crates/" .. crate
				end
			end,
		},
		markdown_link = {
			name = "markdown_link",
			filetype = { "markdown" },
			handle = function(mode, line, _)
				local url =
					require("gx.helper").find(line, mode, "%[[%w%W]+%]%((https?://[a-zA-Z%d_/%%%-%.~@\\+#=?&:]+)%)")

				if url then
					return url
				end
			end,
		},
	},
})
