local function open_todays_log()
	local date = os.date("%Y-%m-%d")
	local filepath = "/home/davud/logs/" .. date .. ".txt"

	local file = io.open(filepath, "r")
	if not file then
		file = io.open(filepath, "w")
		if file then
			file:write(date .. "\n\nDONE:\n\nIN-PROGRESS:\n\nBLOCKERS:\n\nNOTES:\n\n")
			file:close()
		else
			print("Failed to create log file at: " .. filepath)
			return
		end
	else
		file:close()
	end

	vim.cmd("edit " .. filepath)
end

vim.g.mapleader = " "
-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>l", open_todays_log, { noremap = true, silent = true })
vim.keymap.set("n", "<C-b>", vim.cmd.Ex)
vim.api.nvim_set_keymap("i", "jk", "<Esc>", { noremap = true, silent = true })
vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })

-- errors
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostics in float" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<leader>zig", "<cmd>LspRestart<cr>")

vim.keymap.set("n", "<leader>vwm", function()
	require("vim-with-me").StartVimWithMe()
end)
vim.keymap.set("n", "<leader>svwm", function()
	require("vim-with-me").StopVimWithMe()
end)

vim.keymap.set("i", "<C-BS>", "<C-o>db")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", '"_d')

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<C-f>", "<cmd>Telescope live_grep<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- format on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.py", "*.js", "*.jsx", "*.ts", "*.tsx" },
	callback = function()
		vim.lsp.buf.format({ async = true })
	end,
})

vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz")

vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>ee", "oif err != nil {<CR>}<Esc>Oreturn err<Esc>")

vim.keymap.set("n", "<leader>ea", 'oassert.NoError(err, "")<Esc>F";a')

vim.keymap.set("n", "<leader>ef", 'oif err != nil {<CR>}<Esc>Olog.Fatalf("error: %s\\n", err.Error())<Esc>jj')

vim.keymap.set("n", "<leader>el", 'oif err != nil {<CR>}<Esc>O.logger.Error("error", "error", err)<Esc>F.;i')

vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.dotfiles/nvim/.config/nvim/lua/davud/packer.lua<CR>")
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>")

vim.keymap.set("n", "<leader><leader>", function()
	vim.cmd("so")
end)

vim.keymap.set(
	"v",
	"<C-_>",
	"<ESC><CMD>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
	{ noremap = true, silent = true }
)

vim.keymap.set("v", "<Tab>", ">gv", { noremap = true, silent = true }) -- Move right (indent)
vim.keymap.set("v", "<S-Tab>", "<gv", { noremap = true, silent = true }) -- Move left (outdent)

-- swap :sp with :vsplit
vim.cmd("cabbrev <expr> sp (getcmdtype() == ':' && getcmdline() ==# 'sp') ? 'vsplit' : 'sp'")
vim.cmd("cabbrev <expr> split (getcmdtype() == ':' && getcmdline() ==# 'split') ? 'vsplit' : 'split'")

-- swap :vsp with :split
vim.cmd("cabbrev <expr> vsp (getcmdtype() == ':' && getcmdline() ==# 'vsp') ? 'split' : 'vsp'")
vim.cmd("cabbrev <expr> vsplit (getcmdtype() == ':' && getcmdline() ==# 'vsplit') ? 'split' : 'vsplit'")

local netrw_history = {}

local function save_netrw_state()
	local path = vim.fn.expand("%:p")
	local cursor = vim.api.nvim_win_get_cursor(0)
	table.insert(netrw_history, { path = path, cursor = cursor })
end

local function go_back_in_netrw()
	local last = table.remove(netrw_history)
	if last then
		vim.cmd("edit " .. vim.fn.fnameescape(last.path))
		vim.api.nvim_win_set_cursor(0, last.cursor)
	else
		print("No previous directory in netrw history.")
	end
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = "netrw",
	callback = function()
		vim.keymap.set("n", "<CR>", function()
			save_netrw_state()
			vim.api.nvim_feedkeys(
				vim.api.nvim_replace_termcodes("<Plug>NetrwLocalBrowseCheck", true, false, true),
				"n",
				false
			)
		end, { buffer = true })

		-- Back in history
		vim.keymap.set("n", "<C-l>", go_back_in_netrw, { buffer = true })

		-- Optional: go up one dir (no history)
		vim.keymap.set("n", "<C-h>", function()
			local path = vim.fn.getcwd() -- this gets the current netrw directory properly
			local cursor = vim.api.nvim_win_get_cursor(0)
			table.insert(netrw_history, { path = path, cursor = cursor })

			local parent = vim.fn.fnamemodify(path, ":h")
			vim.cmd("edit " .. vim.fn.fnameescape(parent))
		end, { buffer = true })
	end,
})
