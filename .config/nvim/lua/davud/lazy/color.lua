function CustomPaint()
	vim.api.nvim_set_hl(0, "Visual", { bg = "#303030" })

	-- background black globally
	vim.cmd([[
	  hi Normal guibg=#000000
	  hi NormalNC guibg=#000000
	  hi SignColumn guibg=#000000
	  hi LineNr guibg=#000000
	]])

	-- telescope specific windows
	vim.cmd([[
	  hi TelescopeSelection guibg=#303030
	  hi TelescopeNormal guibg=#000000
	  hi TelescopeBorder guibg=#000000
	  hi TelescopePromptNormal guibg=#000000
	  hi TelescopePromptBorder guibg=#000000
	  hi TelescopeResultsNormal guibg=#000000
	  hi TelescopeResultsBorder guibg=#000000
	  hi TelescopePreviewNormal guibg=#000000
	  hi TelescopePreviewBorder guibg=#000000
	]])
end

return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = false,
		priority = 1000,
		config = function()
			require("rose-pine").setup({
				disable_background = false,
				styles = {
					italic = false,
					bold = false,
				},
				highlight_groups = {
					CursorLine = { bg = "#121212" },
				},
			})

			vim.cmd.colorscheme("rose-pine")
			CustomPaint()
		end,
	},
	-- {
	-- 	"folke/tokyonight.nvim",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		---@diagnostic disable-next-line: missing-fields
	-- 		require("tokyonight").setup({
	-- 			styles = {
	-- 				comments = { italic = false },
	-- 				keywords = { italic = false },
	-- 				functions = { italic = false },
	-- 				variables = { italic = false },
	-- 				italic = false,
	-- 			},
	-- 		})
	--
	-- 		vim.cmd.colorscheme("tokyonight-night")
	-- 		CustomPaint()
	-- 	end,
	-- },
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},
}
