-- init.lua

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins
require("lazy").setup("plugins")
require("nvim-tree").setup()

-- Load configurations
require("config")
require("keymap")
require("board")

-- Set PowerShell 7 as the default shell
vim.opt.shell = "pwsh"
vim.o.shell = "pwsh.exe"
vim.o.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command"
vim.o.shellquote = ""
vim.o.shellxquote = ""

-- add the clipboard 
vim.opt.clipboard = "unnamedplus"

