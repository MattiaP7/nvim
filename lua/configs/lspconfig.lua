require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- Lista dei server LSP da abilitare
local servers = {
  "ts_ls",
  "html",
  "cssls",
  "tailwindcss",
  "lua_ls",
  "emmet_ls",
  "clangd",
  "pylsp",
  "pyright",
  "zls",
}

vim.lsp.enable(servers)

-- Configurazione specifica per Python LSP (pylsp)
lspconfig.pylsp.setup {
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          ignore = { "W391", "E303", "W293", "E501" },
          maxLineLength = 88,
        },
      },
    },
  },
}
