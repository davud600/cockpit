return {
	"mg979/vim-visual-multi",
	branch = "master",
	init = function()
		vim.g.VM_default_mappings = 0
		vim.g.VM_maps = {
			["Find Under"] = "<Leader>d",
			["Find Subword Under"] = "<Leader>d",
			["Select All"] = "<Leader>D",
			["Add Cursor Down"] = "<Leader>j",
			["Add Cursor Up"] = "<Leader>k",
		}
	end,
}
