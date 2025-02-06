-- config.lua

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
