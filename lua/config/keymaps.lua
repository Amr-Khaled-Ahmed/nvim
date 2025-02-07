-- config/keymaps.lua

local wk = require("which-key")

-- Toggle line numbers mode (absolute <-> relative)
local function toggle_line_numbers()
  if vim.wo.relativenumber then
    vim.wo.relativenumber = false
  else
    vim.wo.relativenumber = true
  end
end
vim.keymap.set("n", "<leader>n", toggle_line_numbers, { desc = "Toggle Line Numbers Mode" })

-- ** File Management **
wk.register({
  e = { "<cmd>NvimTreeToggle<CR>", "File Explorer" },
  s = { "<cmd>w<CR>", "Save File" },
  q = { "<cmd>q<CR>", "Quit Neovim" },
  r = { "<cmd>source $MYVIMRC<CR>", "Reload Config" },
  f = { "<cmd>Telescope find_files<CR>", "Search Files" },
}, { prefix = "<leader>" })

-- ** Themes **
wk.register({
  T = { name = "Themes" },
}, { prefix = "<leader>" })

wk.register({
  c = { "<cmd>Telescope colorscheme<CR>", "Choose Theme" },
  d = { function()
    last_theme = vim.fn.input("Enter Theme Name: ", "gruvbox", "file")
    vim.cmd("colorscheme " .. last_theme)
  end, "Set Custom Theme" },
  r = { function()
    vim.cmd("colorscheme " .. last_theme)
  end, "Restore Last Theme" },
}, { prefix = "<leader>T" })

-- ** Tabs **
wk.register({
  t = { name = "Tabs" },
}, { prefix = "<leader>" })

wk.register({
  t = { "<cmd>tabnew<CR>", "New Tab" },
  c = { "<cmd>tabclose<CR>", "Close Tab" },
  p = { "<cmd>tabprevious<CR>", "Previous Tab" },
  n = { "<cmd>tabnext<CR>", "Next Tab" },
}, { prefix = "<leader>t" })

-- ** Terminal **
wk.register({
  x = { name = "Terminal" },
}, { prefix = "<leader>" })

wk.register({
  v = { "<cmd>vsplit | term pwsh<CR>", "Vertical Split Terminal" },
  h = { "<cmd>split | term pwsh<CR>", "Horizontal Split Terminal" },
  f = { "<cmd>FloatermNew pwsh<CR>", "Floating Terminal" },
}, { prefix = "<leader>x" })

-- ** Splits **
wk.register({
  s = { name = "Splits" },
}, { prefix = "<leader>" })

wk.register({
  v = { "<cmd>vsplit<CR>", "Vertical Split" },
  h = { "<cmd>split<CR>", "Horizontal Split" },
}, { prefix = "<leader>s" })

-- ** Buffer Management **
wk.register({
  b = { name = "Buffers" },
}, { prefix = "<leader>" })

wk.register({
  n = { "<cmd>enew<CR>", "New Buffer" },
  d = { "<cmd>bdelete<CR>", "Delete Buffer" },
  p = { "<cmd>bprevious<CR>", "Previous Buffer" },
  l = { "<cmd>buffers<CR>", "List Buffers" },
}, { prefix = "<leader>b" })

-- ** Git **
wk.register({
  g = { name = "Git" },
}, { prefix = "<leader>" })

wk.register({
  g = { "<cmd>FloatermNew lazygit<CR>", "Floating LazyGit" },
}, { prefix = "<leader>g" })

-- ** Clipboard **
vim.keymap.set("n", "<C-c>", '"+y', { silent = true })
vim.keymap.set("n", "<C-x>", '"+d', { silent = true })
vim.keymap.set("n", "<C-v>", '"+p', { silent = true })