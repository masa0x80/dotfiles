return {
	{
		"leafo/magick",
	},
	{
		"3rd/image.nvim",
		event = "VeryLazy",
		opts = {
			integrations = {
				markdown = {
					only_render_image_at_cursor = true,
				},
			},
		},
	},
}
