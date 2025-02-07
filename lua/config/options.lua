-- config/options.lua

-- Set leader key to <Space>
vim.g.mapleader = " "

-- Enable line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse support
vim.opt.mouse = "a"

-- Enable syntax highlighting
vim.cmd('syntax on')

-- Set tab settings
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Enable status line
vim.opt.laststatus = 2

-- Enable command line box
vim.opt.cmdheight = 1

-- Enable true color support
vim.opt.termguicolors = true

-- Set PowerShell 7 as the default shell
vim.opt.shell = "pwsh"
vim.o.shell = "pwsh.exe"
vim.o.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command"
vim.o.shellquote = ""
vim.o.shellxquote = ""

-- Clipboard settings
vim.g.clipboard = {
  name = "win32yank",
  copy = {
    ["+"] = "win32yank.exe -i --crlf",
    ["*"] = "win32yank.exe -i --crlf",
  },
  paste = {
    ["+"] = "win32yank.exe -o --lf",
    ["*"] = "win32yank.exe -o --lf",
  },
  cache_enabled = 0,
}