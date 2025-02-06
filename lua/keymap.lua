-- keymap.lua

-- Set leader key to <Space>
vim.g.mapleader = " "

-- Ensure line numbers are enabled
vim.opt.number = true
vim.opt.relativenumber = true

-- Load which-key safely
local status, wk = pcall(require, "which-key")
if not status then
  vim.notify("Which-key not found!", vim.log.levels.ERROR)
  return
end

-- Register key mappings
wk.register({
  -- File management
  e = { "<cmd>NvimTreeToggle<CR>", "File Explorer" },
  s = { "<cmd>w<CR>", "Save File" },
  q = { "<cmd>q<CR>", "Quit Neovim" },
  r = { "<cmd>source $MYVIMRC<CR>", "Reload Config" },
  f = { "<cmd>Telescope find_files<CR>", "Search Files" },
}, { prefix = "<leader>" })

-- PowerShell 7 terminal keybindings
wk.register({
  tv = { ":vsplit | term pwsh<CR>", "Open PowerShell 7 (Vertical Split)" },
  th = { ":botright split | resize 12 | term pwsh<CR>", "Open PowerShell 7 (Bottom Split)" },
  tf = { ":FloatermNew --height=0.9 --width=0.9 pwsh<CR>", "Open PowerShell 7 (Large Floating Terminal)" },
}, { prefix = "<leader>t" })

-- Clipboard keybindings (system clipboard)
vim.keymap.set("n", "<C-c>", '"+y', { silent = true })  -- Copy
vim.keymap.set("n", "<C-x>", '"+d', { silent = true })  -- Cut
vim.keymap.set("n", "<C-v>", '"+p', { silent = true })  -- Paste

-- Split Resizing with Shift + Ctrl + Arrow Keys
vim.keymap.set("n", "<C-S-Left>", "<cmd>vertical resize -2<CR>", { silent = true })  -- Shrink vertically
vim.keymap.set("n", "<C-S-Right>", "<cmd>vertical resize +2<CR>", { silent = true }) -- Expand vertically
vim.keymap.set("n", "<C-S-Up>", "<cmd>resize +2<CR>", { silent = true })    -- Expand horizontally
vim.keymap.set("n", "<C-S-Down>", "<cmd>resize -2<CR>", { silent = true })  -- Shrink horizontally

-- Ensure which-key is loaded in every buffer
vim.cmd([[autocmd BufEnter * lua require("which-key").setup()]])


