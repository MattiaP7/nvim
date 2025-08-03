return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    opts = function()
      local cmp = require "cmp"
      local conf = require "nvchad.configs.cmp"

      local mymappings = {
        ["<Up>"] = cmp.mapping.select_prev_item(),
        ["<Down>"] = cmp.mapping.select_next_item(),
      }
      conf.mapping = vim.tbl_deep_extend("force", conf.mapping, mymappings)
      return conf
    end,
  },

  {
    "barrett-ruth/import-cost.nvim",
    build = "npm.cmd install --legacy-peer-deps",
    ft = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
    config = function()
      require("import-cost").setup {
        format = {
          enabled = true,
          text = " ≈ %s",
          highlight = "Comment",
        },
      }
    end,
  },

  -- suggerimenti intelligenti
  --{ import = "nvchad.blink.lazyspec" },

  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      require "configs.mason"
    end,
    event = "VeryLazy",
  },

  {
    "danymat/neogen",
    config = true,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      auto_install = true,
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "c",
        "cpp",
        "javascript",
        "typescript",
        "tsx",
        "python",
      },
    },
  },
}
