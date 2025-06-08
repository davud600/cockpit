function ColorMyPencils(color)
	color = color or "rose-pine"
	vim.cmd.colorscheme(color)

	-- vim.api.nvim_set_hl(0, "Normal", { bg = "#32a852" })
	-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#32a852" })
	-- vim.api.nvim_set_hl(0, "@type.ts", { fg = "#e0aaff" }) -- Interface name (purple)
	-- vim.api.nvim_set_hl(0, "@property.ts", { fg = "#c4a7e7" }) -- Keys in objects
	-- vim.api.nvim_set_hl(0, "@variable.ts", { fg = "#b30b1b" }) -- Variables and values
	--
	-- vim.api.nvim_set_hl(0, "Normal", { bg = "#141414" })
	-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#141414" })

	-- vim.api.nvim_set_hl(0, "@type.ts", { fg = "#e0aaff" })
	-- vim.api.nvim_set_hl(0, "@variable", { fg = "#b30b1b" })  -- Variables and values
	-- vim.api.nvim_set_hl(0, "@variable.ts", { fg = "#b30b1b" })

	-- vim.api.nvim_set_hl(0, "@type", { fg = "#e0aaff" })  -- Interface name (purple)
	vim.api.nvim_set_hl(0, "Directory", { fg = "#1793d1" }) -- purple-ish, tweak as you like
	vim.api.nvim_set_hl(0, "@property", { fg = "#c4a7e7" }) -- Keys in objects
	vim.api.nvim_set_hl(0, "@property.ts", { fg = "#c4a7e7" })
	vim.api.nvim_set_hl(0, "Visual", { bg = "#3d3d3d" })
	local TelescopeColor = {
		TelescopeSelection = { bg = "#212121" },
		TelescopePromptNormal = { bg = "#212121" },
		TelescopeResultsNormal = { bg = "#000000" },
		TelescopePreviewNormal = { bg = "#000000" },
		TelescopePromptBorder = { bg = "#000000", fg = "#212121" },
		TelescopeResultsBorder = { bg = "#000000", fg = "#212121" },
		TelescopePreviewBorder = { bg = "#000000", fg = "#212121" },
	}
	for hl, col in pairs(TelescopeColor) do
		vim.api.nvim_set_hl(0, hl, col)
	end
end

return {

	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				disable_background = false,
				styles = {
					italic = false,
					bold = false,
				},
				highlight_groups = {
					Normal = { bg = "#000000" },
					NormalNC = { bg = "#000000" },
					CursorLine = { bg = "#121212" },
				},
			})

			ColorMyPencils()
		end,
	},
}
