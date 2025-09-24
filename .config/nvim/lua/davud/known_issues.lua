local function open_known_issues()
	local dir = vim.fn.expand("~") .. "/logs"
	if vim.fn.isdirectory(dir) == 0 then
		vim.fn.mkdir(dir, "p")
	end

	local path = dir .. "/known_issues.txt"
	if not vim.loop.fs_stat(path) then
		vim.cmd.edit(vim.fn.fnameescape(path))
		vim.cmd.write()
	else
		vim.cmd.edit(vim.fn.fnameescape(path))
	end
end

vim.keymap.set("n", "<leader>i", open_known_issues, {
	desc = "Open ~/logs/known_issues.txt (create if missing)",
	noremap = true,
	silent = true,
})
