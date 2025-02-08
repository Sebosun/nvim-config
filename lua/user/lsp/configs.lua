local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end

local lspconfig = require("lspconfig")

local servers = { "jsonls", "lua_ls", "pyright", "astro", "tailwindcss", "prismals", "rls", "gopls", "svelte", "eslint" }

lsp_installer.setup({
	ensure_installed = servers,
})

for _, server in pairs(servers) do
	local opts = {
		on_attach = require("user.lsp.handlers").on_attach,
		capabilities = require("user.lsp.handlers").capabilities,
	}
	local has_custom_opts, server_custom_opts = pcall(require, "user.lsp.settings." .. server)
	if has_custom_opts then
		opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
	end
	lspconfig[server].setup(opts)
end

--[[ local vue_language_server_path = vim.fn.system("pnpm root -g") .. "/@vue/language-server" ]]
local vue_language_server_path = "/home/sebastian/.local/share/pnpm/global/5/node_modules/@vue/language-server"
local typescript_path = vim.fn.system("npm root -g")
typescript_path = typescript_path:gsub("\n[^\n]*$", "") .. "/typescript/lib"

lspconfig.volar.setup({
	filetypes = { "vue", "javascript", "typescript", "javascriptreact", "typescriptreact" },
	init_options = {
		vue = {
			hybridMode = false,
		},
		typescript = {
			tsdk = typescript_path,
		},
	},
})

require("lspconfig").lua_ls.setup({
	on_init = function(client)
		if client.workspace_folders then
			local path = client.workspace_folders[1].name
			if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
				return
			end
		end

		client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
			runtime = {
				-- Tell the language server which version of Lua you're using
				-- (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			-- Make the server aware of Neovim runtime files
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
					-- Depending on the usage, you might want to add additional paths here.
					-- "${3rd}/luv/library"
					-- "${3rd}/busted/library",
				},
				-- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
				-- library = vim.api.nvim_get_runtime_file("", true)
			},
		})
	end,
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using
				-- (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = {
					"vim",
					"require",
					"love",
				},
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}
local language_servers = vim.lsp.get_clients() -- or list servers manually like {'gopls', 'clangd'}
for _, ls in ipairs(language_servers) do
	lspconfig[ls].setup({
		capabilities = capabilities,
		-- you can add other fields for setting up lsp server in this table
	})
end

local customizations = {
	{ rule = "style/*", severity = "off", fixable = true },
	{ rule = "format/*", severity = "off", fixable = true },
	{ rule = "*-indent", severity = "off", fixable = true },
	{ rule = "*-spacing", severity = "off", fixable = true },
	{ rule = "*-spaces", severity = "off", fixable = true },
	{ rule = "*-order", severity = "off", fixable = true },
	{ rule = "*-dangle", severity = "off", fixable = true },
	{ rule = "*-newline", severity = "off", fixable = true },
	{ rule = "*quotes", severity = "off", fixable = true },
	{ rule = "*semi", severity = "off", fixable = true },
}

-- Enable eslint for all supported languages
lspconfig.eslint.setup({
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
		"vue",
		"html",
		"markdown",
		"json",
		"jsonc",
		"yaml",
		"toml",
		"xml",
		"gql",
		"graphql",
		"astro",
		"svelte",
		"css",
		"less",
		"scss",
		"pcss",
		"postcss",
	},
	settings = {
		-- Silent the stylistic rules in you IDE, but still auto fix them
		rulesCustomizations = customizations,
	},
    on_attach = function(client, bufnr)
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        command = "EslintFixAll",
      })
    end,
})
