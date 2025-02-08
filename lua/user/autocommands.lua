vim.cmd([[
  augroup _general_settings
    autocmd!
    autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR>
    autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 200})
    autocmd BufWinEnter * :set formatoptions-=cro
    autocmd FileType qf set nobuflisted
  augroup end

  augroup _git
    autocmd!
    autocmd FileType gitcommit setlocal wrap
    autocmd FileType gitcommit setlocal spell
  augroup end

  augroup _markdown
    autocmd!
    autocmd FileType markdown setlocal wrap
    autocmd FileType markdown setlocal spell
  augroup end

  augroup _auto_resize
    autocmd!
    autocmd VimResized * tabdo wincmd =
  augroup end

  augroup _alpha
    autocmd!
    autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
  augroup end

  " augroup _lsp
  "   autocmd!
  "   autocmd BufWritePre * lua vim.lsp.buf.format()
  " augroup end
]])

local function disable_copilot_for_go()
	local disabled_filetypes = { "go", "lua" }

	for i, val in ipairs(disabled_filetypes) do
		if vim.bo.filetype == val then
			print("Disabling Copilot for " .. val)
			vim.cmd("Copilot disable")
		end
	end
end

vim.api.nvim_create_autocmd("FileType", {
	callback = disable_copilot_for_go,
})
