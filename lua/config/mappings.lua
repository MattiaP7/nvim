local map = vim.keymap.set
local mak = vim.api.nvim_set_keymap

-- nvim tree
map("n", "<C-n>", ":NvimTreeToggle<CR>", { desc = " file explorer" })

-- Keymaps per Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "󰱼 Trova file" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "󰊄 Grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "󰈙 Buffer" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "󰋖 Help" })
map("n", "<leader>ds", "<cmd>Telescope diagnostics<CR>", { desc = " Diagnostica" })
map("n", "<leader>th", "<cmd>Telescope themes<CR>", { noremap = true, silent = true, desc = " Theme switcher" })

-- Mappature generali
map("n", "<leader>o", ":update<CR>:source %<CR>", { desc = " Ricarica config" })
map("n", "<leader>w", ":w<CR>", { desc = " Salva file" })
map("n", "<leader>q", ":q<CR>", { desc = " Chiudi buffer" })
map("n", "<leader>Q", ":qa!<CR>", { desc = " Esci forzato" })

-- Salvataggio con Ctrl+S
map({ "n", "i", "v" }, "<C-s>", "<cmd>w<cr>", { desc = " Salva file" })
mak("n", "<C-a>", "ggVG", { noremap = true, silent = true })
mak("v", "<C-c>", '"+y', { noremap = true, silent = true })
mak("v", "<C-v>", '"+p', { noremap = true, silent = true })

-- Spostare la riga in su con Alt+Freccia su
mak("n", "<A-Up>", ":m-2<CR>==", { noremap = true, silent = true })
mak("v", "<A-Up>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- Spostare la riga in giù con Alt+Freccia giù
mak("n", "<A-Down>", ":m+1<CR>==", { noremap = true, silent = true })
mak("v", "<A-Down>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
-- Commenti
map("n", "<leader>/", "gcc", { desc = " Toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = " Toggle comment", remap = true })

--LSP
-- formatter di neovim
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   callback = function()
--     vim.lsp.buf.format({ async = false })
--   end,
-- })
-- map('n', '<leader>lf', function()
--   vim.lsp.buf.format({ async = true })
-- end, { desc = "Format document" })

map("n", "gd", vim.lsp.buf.definition, { desc = "󰌹 Vai alla definizione" })
map("n", "gD", vim.lsp.buf.implementation, { desc = "󰌹 Vai alla implementazione" })
map("n", "K", vim.lsp.buf.hover, { desc = "󰘥 Hover docs" })
map("n", "<leader>ggr", vim.lsp.buf.workspace_symbol, { desc = "󰍉 Cerca simbolo workspace" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "󰆼 Code action" })
map("i", "<C-h>", vim.lsp.buf.signature_help, { desc = "󰘧 Signature help" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "󰑕 Rinomina parola" })

-- toggleterm
map("n", "<leader>h", "<cmd>ToggleTerm direction=float <CR>", { desc = "Toggle Float Terminal" })

-- neogen
map("n", "<leader>nf", ":lua require('neogen').generate()<CR>", { noremap = true, silent = true })
