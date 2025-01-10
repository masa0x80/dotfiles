return {
	"HakonHarnes/img-clip.nvim",
	event = "VeryLazy",
	opts = {
		default = {
			relative_to_current_file = true,
			drag_and_drop = {
				enabled = true,
				insert_mode = true,
			},
		},
		filetypes = {
			markdown = {
				url_encode_path = false,
				template = function(context)
					local path = string.gsub(context.file_path, "/ ", "%%20")
					return "![" .. context.cursor .. "](" .. path .. ")"
				end,
			},
		},
	},
	keys = {
		{ "<Leader>p", "<Cmd>PasteImage<CR>", desc = "Paste image from system clipboard" },
	},
}
