-- keymap.lua

-- Set leader key to <Space>
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Ensure line numbers are visible
vim.opt.number = true
vim.opt.relativenumber = true

-- Ensure which-key loads safely
local wk_status, wk = pcall(require, "which-key")
if not wk_status then
  vim.notify("Which-key not found!", vim.log.levels.ERROR)
  return
end

-- Register general key mappings
wk.register({
  -- File management
  e = { "<cmd>NvimTreeToggle<CR>", "File Explorer" },
  s = { "<cmd>w<CR>", "Save File" },
  q = { "<cmd>q<CR>", "Quit Neovim" },
  r = { "<cmd>source $MYVIMRC<CR>", "Reload Config" },
  f = { "<cmd>Telescope find_files<CR>", "Search Files" },
}, { prefix = "<leader>" })

-- ** Theme Control (Change themes and save last theme) **
local last_theme = "gruvbox" -- Set your default theme here
vim.cmd("colorscheme " .. last_theme)

wk.register({
  t = { name = "Themes" },  -- Group for theme commands
}, { prefix = "<leader>" })

wk.register({
  c = { function()
    vim.cmd("Telescope colorscheme")
  end, "Choose Theme" },
  d = { function()
    last_theme = vim.fn.input("Enter Theme Name: ", last_theme, "file")
    vim.cmd("colorscheme " .. last_theme)
  end, "Set Custom Theme" },
  r = { function()
    vim.cmd("colorscheme " .. last_theme)
  end, "Restore Last Theme" },
}, { prefix = "<leader>t" })

-- ** Split Management & Navigation **
wk.register({
  s = { name = "Splits" },  -- Group for splits
}, { prefix = "<leader>" })

wk.register({
  v = { "<cmd>vsplit<CR>", "Vertical Split" },
  h = { "<cmd>split<CR>", "Horizontal Split" },
  n = { "<cmd>vsplit | term pwsh.exe<CR>", "Vertical Split with PowerShell" },
  p = { "<cmd>split | term pwsh.exe<CR>", "Horizontal Split with PowerShell" },
}, { prefix = "<leader>s" })

-- Split navigation (Ctrl + Arrow)
vim.keymap.set("n", "<C-S-Left>", "<cmd>vertical resize -2<CR>", { silent = true })
vim.keymap.set("n", "<C-S-Right>", "<cmd>vertical resize +2<CR>", { silent = true })
vim.keymap.set("n", "<C-S-Up>", "<cmd>resize +2<CR>", { silent = true })
vim.keymap.set("n", "<C-S-Down>", "<cmd>resize -2<CR>", { silent = true })

-- ** Tab Management & Navigation **
wk.register({
  t = { name = "Tabs" },  -- Group for tabs
}, { prefix = "<leader>" })

wk.register({
  n = { "<cmd>tabnew<CR>", "New Tab" },
  c = { "<cmd>tabclose<CR>", "Close Tab" },
  p = { "<cmd>tabprevious<CR>", "Previous Tab" },
  n = { "<cmd>tabnext<CR>", "Next Tab" },
}, { prefix = "<leader>t" })

-- ** Buffer Management & Navigation **
wk.register({
  b = { name = "Buffers" },  -- Group for buffers
}, { prefix = "<leader>" })

wk.register({
  n = { "<cmd>enew<CR>", "New Buffer" },
  d = { "<cmd>bdelete<CR>", "Delete Buffer" },
  p = { "<cmd>bprevious<CR>", "Previous Buffer" },
  n = { "<cmd>bnext<CR>", "Next Buffer" },
  l = { "<cmd>buffers<CR>", "List Buffers" },
}, { prefix = "<leader>b" })

-- ** Git commands (Grouped under <leader>g) **
wk.register({
  g = { name = "Git" },  -- Group for git commands
}, { prefix = "<leader>" })

-- Git command mappings (assuming Git is installed on your machine)
vim.keymap.set("n", "<leader>gp", ":!git push<CR>", { silent = true })  -- Git Push (external command)
vim.keymap.set("n", "<leader>gc", ":!git commit<CR>", { silent = true })  -- Git Commit (external command)
vim.keymap.set("n", "<leader>gs", ":!git status<CR>", { silent = true })  -- Git Status (external command)
vim.keymap.set("n", "<leader>gl", ":!git log<CR>", { silent = true })  -- Git Log (external command)
vim.keymap.set("n", "<leader>gf", ":!git fetch<CR>", { silent = true })  -- Git Fetch (external command)

vim.keymap.set("n", "<leader>glg", ":FloatermNew lazygit<CR>", { silent = true })  -- Open LazyGit in floating terminal

-- ** Terminal Management (Grouped under <leader>t) **
wk.register({
  t = { name = "Terminal" },  -- Group for terminal commands
}, { prefix = "<leader>" })

-- Terminal keybindings (PowerShell 7 specific)
vim.keymap.set("n", "<leader>tv", ":vsplit | term pwsh<CR>", { silent = true })  -- Open PowerShell 7 (Vertical Split)
vim.keymap.set("n", "<leader>th", ":split | term pwsh<CR>", { silent = true })  -- Open PowerShell 7 (Horizontal Split - bottom)

vim.keymap.set("n", "<leader>tf", ":FloatermNew pwsh<CR>", { silent = true })  -- Open PowerShell 7 (Floating terminal)

-- Clipboard keybindings (outside leader)
vim.keymap.set("n", "<C-c>", '"+y', { silent = true })  -- Copy to Clipboard
vim.keymap.set("n", "<C-x>", '"+d', { silent = true })  -- Cut to Clipboard
vim.keymap.set("n", "<C-v>", '"+p', { silent = true })  -- Paste from Clipboard

-- Fallback: Force reload of leader keymaps for any new context (git repo, etc.)
vim.cmd([[
  augroup FixLeader
    autocmd!
    autocmd BufEnter * lua require("which-key").setup()
  augroup END
]])

-- Force apply line numbers (fixes missing numbers in some files)
vim.cmd([[
  augroup FixNumbers
    autocmd!
    autocmd BufEnter * set number relativenumber
  augroup END
]])

