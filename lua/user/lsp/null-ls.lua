local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
	debug = false,
	sources = {
		diagnostics.eslint.with({
			condition = function(utils)
				return utils.root_has_file({
					".eslintrc.js",
					".eslintrc.cjs",
					".eslintrc.yaml",
					".eslintrc.yml",
					".eslintrc.json",
				})
			end,
		}),
		formatting.prettier,
		--[[ formatting.rustywind, ]]
		--[[ formatting.black.with({ extra_args = { "--fast" } }), ]]
		formatting.stylua,
		--[[ formatting.black, ]]
	},
})
