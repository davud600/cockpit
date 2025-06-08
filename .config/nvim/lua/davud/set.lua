vim.opt.guicursor = ""
vim.opt.cursorline = false

vim.opt.nu = true
vim.opt.relativenumber = true

-- vim.opt.tabstop = 4
-- vim.opt.softtabstop = 4
-- vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

-- Function to detect Prettier config
local function get_prettier_tab_width()
	local prettier_config_files = { ".prettierrc", ".prettierrc.json", ".prettierrc.js", "package.json" }
	local cwd = vim.fn.getcwd()

	for _, file in ipairs(prettier_config_files) do
		local path = cwd .. "/" .. file
		if vim.fn.filereadable(path) == 1 then
			local config_content = vim.fn.readfile(path)
			local config_string = table.concat(config_content, "\n")

			local tab_width = config_string:match('"tabWidth"%s*:%s*(%d+)')
			if tab_width then
				return tonumber(tab_width)
			end
		end
	end
	return nil
end

-- Function to update indentation dynamically
local function update_indentation()
	local tab_width = get_prettier_tab_width()

	if tab_width then
		vim.opt.tabstop = tab_width
		vim.opt.shiftwidth = tab_width
		vim.opt.softtabstop = tab_width
	else
		-- Use LSP settings as a fallback
		local clients = vim.lsp.get_active_clients()
		for _, client in ipairs(clients) do
			if client.server_capabilities.documentFormattingProvider then
				local settings = client.config.settings
				if settings and settings.tabSize then
					vim.opt.tabstop = settings.tabSize
					vim.opt.shiftwidth = settings.tabSize
					vim.opt.softtabstop = settings.tabSize
					return
				end
			end
		end

		-- Default (4 spaces for general code)
		vim.opt.tabstop = 4
		vim.opt.shiftwidth = 4
		vim.opt.softtabstop = 4
	end
end

-- Run on BufEnter and FileType change
vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
	callback = update_indentation,
})

vim.g.netrw_list_hide = [[\(^\|\s\s\)\zs\.\%(?!\.\./)\S\+/$]]
vim.g.netrw_hide = 1
