local status_ok, tsj = pcall(require, "treesj")
if not status_ok then
	return
end

local langs = {
	"javascript",
	"vue",
	"typescript",
	"lua",
	"css",
	"scss",
	"svelte",
	"jsx",
	"tsx",
	"go",
	"python",
	"rust",
}

tsj.setup({
	-- Use default keymaps
	-- (<space>m - toggle, <space>j - join, <space>s - split)
	use_default_keymaps = true,
	-- Node with syntax error will not be formatted
	check_syntax_error = true,
	-- If line after join will be longer than max value,
	-- node will not be formatted
	max_join_length = 120,
	-- hold|start|end:
	-- hold - cursor follows the node/place on which it was called
	-- start - cursor jumps to the first symbol of the node being formatted
	-- end - cursor jumps to the last symbol of the node being formatted
	cursor_behavior = "hold",
	-- Notify about possible problems or not
	notify = true,
	langs = langs,
	-- Use `dot` for repeat action
	dot_repeat = true,
})
