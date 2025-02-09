-- Enable syntax highlighting early
vim.cmd("syntax enable")
vim.cmd("filetype plugin indent on")
vim.cmd("syntax enable")
vim.cmd("filetype plugin indent on")  -- Enable filetype detection


-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins
require("lazy").setup("plugins")

-- Load configurations
require("config.options")
require("config.keymaps")
require("config.autocmds")
