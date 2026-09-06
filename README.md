# Neovim Configuration

Personal Neovim setup with LSP, formatting, and development tools.

## Prerequisites

* [Neovim 0.12.5+](https://github.com/neovim/neovim/releases/tag/v0.12.5)
* [Nerd Font](https://www.nerdfonts.com/) for terminal icons
* [Tree-sitter-cli](https://github.com/tree-sitter/tree-sitter/blob/master/crates/cli/README.md) is required by nvim-treesitter plugin to install parsers.
* [fd](https://github.com/sharkdp/fd) for file finding (Telescope integration, optional)
* [ripgrep](https://github.com/BurntSushi/ripgrep) for live grep (optional but recommended)
* [git](https://git-scm.com/) for lazy.nvim and version control
* Language-specific tools:
  - **Lua**: Stylua
  - **C/C++**: clang-format, clangd
  - **Python**: black, pylsp
  - **PHP**: intelephense, pretty-php
  - **JavaScript/TypeScript**: Prettier, prettierd, vtsls
  - **HTML/CSS**: html, cssls, emmet-language-server
  - **Tailwind CSS**: tailwindcss LSP
  - **CMake**: neocmake

## Installation

### Linux/macOS

```bash
git clone https://github.com/MattiaP7/nvim.git ~/.config/nvim
cd ~/.config/nvim
nvim
```

After Neovim opens, lazy.nvim will automatically bootstrap. Run:
```
:Mason
```
to install LSP servers and tools listed above.

### Windows (PowerShell)

```powershell
git clone https://github.com/MattiaP7/nvim.git $ENV:USERPROFILE\AppData\Local\nvim
cd $ENV:USERPROFILE\AppData\Local\nvim
nvim
```

### Windows (Command Prompt)

```cmd
git clone https://github.com/MattiaP7/nvim.git %USERPROFILE%\AppData\Local\nvim
cd %USERPROFILE%\AppData\Local\nvim
nvim
```

After Neovim opens, run `:Mason` to install dependencies.

## Key Bindings

* `<C-n>` - Toggle file explorer (nvim-tree)
* `<leader>fg` - Live grep (Telescope)
* `<leader>fb` - Find buffers (Telescope)
* `<leader>fh` - Find help tags (Telescope)
* `<leader>ds` - Diagnostics (Telescope)
* `<leader>th` - Theme switcher
* `<leader>o` - Reload config
* `<leader>w` - Save file
* `<leader>q` - Close buffer
* `<leader>Q` - Force quit
* `<C-s>` - Save file (normal, insert, visual modes)
* `<A-Up>` / `<A-Down>` - Move lines up/down
* `<leader>/` - Toggle line comment
* `gd` - Go to definition
* `gD` - Go to implementation
* `K` - Hover documentation
* `<leader>ca` - Code action
* `<leader>rn` - Rename symbol
* `<leader>h` - Toggle floating terminal
* `<C-\>` - Open/close terminal (from toggleterm)

## Configuration Structure

* `init.lua` - Main entry point
* `config/options.lua` - Editor settings
* `config/mappings.lua` - Key bindings
* `current-theme.lua` - Active color scheme
* `plugins/` - Plugin specifications

## Updating

```vim
:Lazy sync
```

## Uninstalling

### Linux/macOS

```bash
rm -rf ~/.config/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.local/share/nvim
```

### Windows (PowerShell)

```powershell
rm -Force -Recurse $ENV:USERPROFILE\AppData\Local\nvim
rm -Force -Recurse $ENV:USERPROFILE\AppData\Local\nvim-data
```

### Windows (Command Prompt)

```cmd
rd /s %USERPROFILE%\AppData\Local\nvim
rd /s %USERPROFILE%\AppData\Local\nvim-data
```

## Features

* LSP support for multiple languages via nvim-lspconfig
* Completion via nvim-cmp with snippet support
* Fuzzy finding with Telescope
* Code formatting via conform.nvim
* Git integration with gitsigns
* Terminal support with toggleterm
* Theme switching (TokyoNight, Catppuccin, Onedark, and more)
* Markdown and code block syntax highlighting
