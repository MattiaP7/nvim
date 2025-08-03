-- File: lua/plugins/configs/mason.lua
local mason = require "mason"
local mason_lspconfig = require "mason-lspconfig"
local mason_tool_installer = require "mason-tool-installer"

-- icone personalizzate per Mason UI
mason.setup {
  ui = {
    icons = {
      package_pending = " ",
      package_installed = " ",
      package_uninstalled = " ",
    },
  },
}

-- LSP server da installare
mason_lspconfig.setup {
  ensure_installed = {
    "ts_ls", -- js/ts
    "html", -- HTML
    "cssls", -- CSS
    "tailwindcss", -- Tailwind
    "lua_ls", -- Lua
    "emmet_ls", -- Emmet
    "clangd", -- C/C++
    "pylsp", -- Python LSP
    -- "pyright",-- Python alternative
    "zls", -- Zig
  },
}

-- Tools (formatter, linter, etc.)
mason_tool_installer.setup {
  ensure_installed = {
    "prettier",
    "stylua",
    "isort",
    "black",
    "pyflakes",
    "pylint",
    "eslint_d",
    "clang-format",
  },
}

-- Primo avvio: apri UI di Mason
local function is_mason_initialized()
  return vim.fn.filereadable(vim.fn.stdpath "data" .. "/mason_initialized") == 1
end

local function mark_mason_initialized()
  local file = io.open(vim.fn.stdpath "data" .. "/mason_initialized", "w")
  if file then
    file:close()
  end
end

vim.defer_fn(function()
  if not is_mason_initialized() then
    require("mason.ui").open()
    mark_mason_initialized()
  end
end, 100)
