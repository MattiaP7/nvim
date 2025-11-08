-- Configurazione shell specifica per sistema operativo
if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
	-- Verifica se PowerShell 7+ è disponibile
	local pwsh_path = vim.fn.executable("pwsh") == 1 and "pwsh" or nil

	if pwsh_path then
		vim.opt.shell = "pwsh"
		vim.opt.shellcmdflag =
		"-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues['Out-File:Encoding']='utf8';"
		vim.opt.shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
		vim.opt.shellpipe = '2>&1 | %%{ "$_" } | Tee-Object %s; exit $LastExitCode'
		vim.opt.shellquote = ""
		vim.opt.shellxquote = ""
	end
	-- Se pwsh non è disponibile, Neovim userà la shell predefinita di Windows
end
-- Per Linux/macOS, Neovim userà automaticamente la shell dell'utente ($SHELL)

require("config/options")
require("config/mappings")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out,                            "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		{ import = "plugins" },
	}
})

require("current-theme")
-- require("terminal")
