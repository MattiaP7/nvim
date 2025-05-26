require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local mak = vim.api.nvim_set_keymap

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
mak("n", "<C-a>", "ggVG", { noremap = true, silent = true })
mak("v", "<C-c>", '"+y', { noremap = true, silent = true })
mak("v", "<C-v>", '"+p', { noremap = true, silent = true })

-- Spostare la riga in su con Alt+Freccia su
mak("n", "<A-Up>", ":m-2<CR>==", { noremap = true, silent = true })
mak("v", "<A-Up>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- Spostare la riga in giù con Alt+Freccia giù
mak("n", "<A-Down>", ":m+1<CR>==", { noremap = true, silent = true })
mak("v", "<A-Down>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })

map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

map("n", "<leader>ca", vim.lsp.buf.code_action, { noremap = true, silent = true })

map("n", "<leader>cg", function()
  require("neogen").generate()
end, { desc = "Generate docs with neogen" })
