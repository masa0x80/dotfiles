require("insx.preset.standard").setup()

local insx = require("insx")
for _, close in ipairs({ '"', "'", "`" }) do
	insx.add(
		"<C-]>",
		insx.with(
			require("insx.recipe.fast_wrap")({
				close = close,
			}),
			{
				insx.with.undopoint(false),
			}
		)
	)
end
