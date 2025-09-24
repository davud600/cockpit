local function open_or_create_today_log()
	local dir = vim.fn.expand("~") .. "/logs"

	if vim.fn.isdirectory(dir) == 0 then
		vim.fn.mkdir(dir, "p")
	end

	local today = os.date("%Y-%m-%d")
	local path = dir .. "/" .. today .. ".txt"

	if vim.loop.fs_stat(path) then
		vim.cmd.edit(vim.fn.fnameescape(path))
		return
	end

	vim.cmd.edit(vim.fn.fnameescape(path))

	local lines = {
		today,
		"",
		"DONE:",
		"",
		"IN-PROGRESS:",
		"",
		"BLOCKERS:",
		"",
		"NOTES:",
		"",
	}
	vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
	vim.cmd.write()
end

vim.keymap.set(
	"n",
	"<leader>l",
	open_or_create_today_log,
	{ desc = "Open today's log in ~/logs (create with template if missing)" }
)
