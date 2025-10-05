--  See `:help vim.keymap.set()`

vim.keymap.set("v", "<Tab>", ">gv", { noremap = true, silent = true }) -- Move right (indent)
vim.keymap.set("v", "<S-Tab>", "<gv", { noremap = true, silent = true }) -- Move left (outdent)

-- open file explorer
vim.keymap.set("n", "<C-b>", vim.cmd.Ex)

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostics in float" })

-- Shift + j or k to move lines of code in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
-- vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Better search UX
vim.opt.incsearch = true
vim.opt.hlsearch = true

-- Esc in command-line: if we're doing / or ?, treat Esc like Enter
vim.keymap.set("c", "<Esc>", function()
	local t = vim.fn.getcmdtype()
	if t == "/" or t == "?" then
		return "<CR>" -- accept the match instead of cancel
	end
	return "<Esc>"
end, { expr = true })

-- Esc in normal mode: first Esc clears highlight; otherwise just Esc
vim.keymap.set("n", "<Esc>", function()
	if vim.v.hlsearch == 1 then
		vim.cmd("nohlsearch")
		return ""
	end
	return "<Esc>"
end, { expr = true, silent = true })
