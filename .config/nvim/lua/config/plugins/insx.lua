require("insx.preset.standard").setup()
for _, close in ipairs({ '"', "'", "``" }) do
	require("insx").add(
		"<C-]>",
		require("insx.recipe.fast_wrap")({
			close = close,
		})
	)
end
