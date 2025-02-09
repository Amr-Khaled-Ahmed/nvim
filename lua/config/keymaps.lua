local wk = require("which-key")

-- Top-level groups with enhanced icons
wk.register({
  ["<leader>"] = {
    b = { name = "📂 Buffers" },
    f = { name = "🔍 Find" },
    g = { name = "🔥 Git" },
    s = { name = "📑 Splits" },
    t = { name = "📌 Tabs" },
    T = { name = "🎨 Themes" },
    x = { name = "🖥️ Terminal" },
    l = { name = "🔧 LSP" },
    d = { name = "🐛 Debug" },
    p = { name = "📦 Packages" },
    w = { name = "📝 Workspace" },
    m = { name = "📍 Marks" },
    z = { name = "🔧 Tools" },
  },
})

-- Toggle line numbers mode (absolute <-> relative)
local function toggle_line_numbers()
  if vim.wo.relativenumber then
    vim.wo.relativenumber = false
  else
    vim.wo.relativenumber = true
  end
end
vim.keymap.set("n", "<leader>n", toggle_line_numbers, { desc = "🔢 Toggle Line Numbers" })

-- File Management
wk.register({
  s = { "<cmd>w<CR>", "💾 Save File" },
  q = { "<cmd>q<CR>", "🚪 Quit Neovim" },
  r = { "<cmd>source $MYVIMRC<CR>", "🔄 Reload Config" },
  f = { "<cmd>Telescope find_files<CR>", "🔍 Search Files" },
}, { prefix = "<leader>" })


wk.register({
  e = {
    name = "Explorer",  -- Group name
    e = { ":Neotree filesystem toggle<CR>", "Toggle Filesystem" },
    g = { ":Neotree git_status toggle<CR>", "Toggle Git Status" },
    b = { ":Neotree buffers toggle<CR>", "Toggle Buffers" },
    s = { ":Neotree document_symbols toggle<CR>", "Toggle LSP Symbols" },
    d = { ":Neotree diagnostics toggle<CR>", "Toggle Diagnostics" },
  },
}, { prefix = "<leader>", mode = "n" })

-- Themes
wk.register({
  T = { name = "🎨 Themes" },
}, { prefix = "<leader>" })

wk.register({
  c = { "<cmd>Telescope colorscheme<CR>", "🎭 Choose Theme" },
  d = { function()
    last_theme = vim.fn.input("Enter Theme Name: ", "gruvbox", "file")
    vim.cmd("colorscheme " .. last_theme)
  end, "🎪 Set Custom Theme" },
  r = { function()
    vim.cmd("colorscheme " .. last_theme)
  end, "♻️ Restore Last Theme" },
}, { prefix = "<leader>T" })

-- Tabs
wk.register({
  t = { name = "📌 Tabs" },
}, { prefix = "<leader>" })

wk.register({
  t = { "<cmd>tabnew<CR>", "➕ New Tab" },
  c = { "<cmd>tabclose<CR>", "❌ Close Tab" },
  p = { "<cmd>tabprevious<CR>", "⬅️ Previous Tab" },
  n = { "<cmd>tabnext<CR>", "➡️ Next Tab" },
}, { prefix = "<leader>t" })

-- Terminal
wk.register({
  x = { name = "🖥️ Terminal" },
}, { prefix = "<leader>" })

wk.register({
  v = { "<cmd>vsplit | term pwsh<CR>", "↕️ Vertical Split Terminal" },
  h = { "<cmd>split | term pwsh<CR>", "↔️ Horizontal Split Terminal" },
  f = { "<cmd>FloatermNew pwsh<CR>", "🪟 Floating Terminal" },
}, { prefix = "<leader>x" })

-- Splits
wk.register({
  s = { name = "📑 Splits" },
}, { prefix = "<leader>" })

wk.register({
  v = { "<cmd>vsplit<CR>", "↕️ Vertical Split" },
  h = { "<cmd>split<CR>", "↔️ Horizontal Split" },
  c = { "<cmd>close<CR>", "❌ Close Split" },
  o = { "<cmd>only<CR>", "👁️ Focus Split" },
}, { prefix = "<leader>s" })

-- Buffer Management
wk.register({
  b = { name = "📂 Buffers" },
}, { prefix = "<leader>" })

wk.register({
  n = { "<cmd>enew<CR>", "📄 New Buffer" },
  d = { "<cmd>bdelete<CR>", "🗑️ Delete Buffer" },
  p = { "<cmd>bprevious<CR>", "⬅️ Previous Buffer" },
  l = { "<cmd>buffers<CR>", "📋 List Buffers" },
  f = { "<cmd>bfirst<CR>", "⏮️ First Buffer" },
  L = { "<cmd>blast<CR>", "⏭️ Last Buffer" },
}, { prefix = "<leader>b" })

-- Git
wk.register({
  g = { name = "🔥 Git" },
}, { prefix = "<leader>" })

wk.register({
  g = { "<cmd>FloatermNew lazygit<CR>", "🪟 LazyGit" },
  j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "⬇️ Next Hunk" },
  k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "⬆️ Prev Hunk" },
  s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "➕ Stage Hunk" },
  r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "↩️ Reset Hunk" },
  S = { "<cmd>lua require 'gitsigns'.stage_buffer()<cr>", "📝 Stage Buffer" },
  u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "↪️ Undo Stage" },
  p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "👁️ Preview Hunk" },
  b = { "<cmd>lua require 'gitsigns'.blame_line{ full = true }<cr>", "👤 Blame Line" },
  B = { "<cmd>lua require 'gitsigns'.toggle_current_line_blame()<cr>", "🔄 Toggle Blame" },
  d = { "<cmd>lua require 'gitsigns'.diffthis()<cr>", "📊 Diff This" },
  D = { "<cmd>lua require 'gitsigns'.diffthis('~')<cr>", "🔍 Diff Index" },
  O = { "<cmd>lua require 'gitsigns'.diffthis('origin/HEAD')<cr>", "🌍 Diff Origin" },
  X = { "<cmd>lua require 'gitsigns'.toggle_deleted()<cr>", "❌ Toggle Deleted" },

  -- 🆕 Added Commands
  R = { "<cmd>lua require 'gitsigns'.refresh()<cr>", "🔄 Refresh GitSigns" },
  W = { "<cmd>Telescope git_worktrees<CR>", "🌲 Git Worktrees" },
  C = { "<cmd>lua require 'gitsigns'.setqflist('all')<cr>", "📜 All Changes (Quickfix)" },
}, { prefix = "<leader>g" })

-- 🆕 Telescope Git Enhancements
wk.register({
  C = { "<cmd>Telescope git_commits<CR>", "📜 Git Commits" },
  B = { "<cmd>Telescope git_branches<CR>", "🌿 Git Branches" },
  S = { "<cmd>Telescope git_status<CR>", "📊 Git Status" },
  T = { "<cmd>Telescope git_stash<CR>", "📦 Git Stash" },
  W = { "<cmd>Telescope git_worktrees<CR>", "🌲 Git Worktrees" }, -- 🆕 New Feature
}, { prefix = "<leader>g" })

-- Telescope
wk.register({
  f = { name = "🔍 Find" },
}, { prefix = "<leader>" })

wk.register({
  f = { "<cmd>Telescope find_files<CR>", "📄 Find Files" },
  g = { "<cmd>Telescope live_grep<CR>", "🔎 Live Grep" },
  b = { "<cmd>Telescope buffers<CR>", "📂 Buffers" },
  h = { "<cmd>Telescope help_tags<CR>", "❓ Help Tags" },
  c = { "<cmd>Telescope commands<CR>", "⌨️ Commands" },
  n = { "<cmd>lua require('telescope').extensions.notify.notify({})<CR>", "📯 Notify History" },
  r = { "<cmd>Telescope oldfiles<CR>", "🕒 Recent Files" },
  R = { "<cmd>Telescope resume<CR>", "↩️ Resume Search" },
  sw = { "<cmd>Telescope grep_string<CR>", "🔤 Search Word" },
  m = { "<cmd>Telescope marks<CR>", "📍 Marks" },
}, { prefix = "<leader>f" })

-- LSP Commands
wk.register({
  l = { name = "🔧 LSP" },
}, { prefix = "<leader>" })

wk.register({
  d = { "<cmd>Telescope lsp_definitions<CR>", "📍 Go to Definition" },
  r = { "<cmd>Telescope lsp_references<CR>", "🔍 Find References" },
  i = { "<cmd>Telescope lsp_implementations<CR>", "⚡ Implementations" },
  s = { "<cmd>Telescope lsp_document_symbols<CR>", "📑 Document Symbols" },
  w = { "<cmd>Telescope lsp_workspace_symbols<CR>", "🌍 Workspace Symbols" },
  a = { vim.lsp.buf.code_action, "💡 Code Action" },
  f = { vim.lsp.buf.format, "✨ Format Document" },
  R = { vim.lsp.buf.rename, "✏️ Rename Symbol" },
  e = { "<cmd>Telescope diagnostics<CR>", "⚠️ Show Diagnostics" },
  h = { vim.lsp.buf.hover, "ℹ️ Hover Info" },
}, { prefix = "<leader>l" })

-- Debugging
wk.register({
  d = { name = "🐛 Debug" },
}, { prefix = "<leader>" })

wk.register({
  b = { "<cmd>lua require'dap'.toggle_breakpoint()<CR>", "🔴 Toggle Breakpoint" },
  c = { "<cmd>lua require'dap'.continue()<CR>", "▶️ Continue" },
  s = { "<cmd>lua require'dap'.step_over()<CR>", "⤵️ Step Over" },
  i = { "<cmd>lua require'dap'.step_into()<CR>", "⤵️ Step Into" },
  o = { "<cmd>lua require'dap'.step_out()<CR>", "⤴️ Step Out" },
  r = { "<cmd>lua require'dap'.repl.open()<CR>", "💻 Open REPL" },
  u = { "<cmd>lua require'dapui'.toggle()<CR>", "🖥️ Toggle UI" },
}, { prefix = "<leader>d" })

-- Workspace
wk.register({
  w = { name = "📝 Workspace" },
}, { prefix = "<leader>" })

wk.register({
  s = { "<cmd>wa<CR>", "💾 Save All" },
  r = { "<cmd>SessionLoad<CR>", "📂 Restore Session" },
  S = { "<cmd>SessionSave<CR>", "💾 Save Session" },
}, { prefix = "<leader>w" })

-- Tools
wk.register({
  z = { name = "🔧 Tools" },
}, { prefix = "<leader>" })

wk.register({
  z = { "<cmd>ZenMode<CR>", "🧘 Zen Mode" },
  t = { "<cmd>TodoTelescope<CR>", "📝 Todo List" },
  m = { "<cmd>MarkdownPreview<CR>", "📚 Markdown Preview" },
}, { prefix = "<leader>z" })

-- Quick Terminal Toggle
vim.keymap.set("n", "<Tab>", function()
  local term_win = nil
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].buftype == "terminal" then
      term_win = win
      break
    end
  end

  if term_win then
    vim.api.nvim_win_close(term_win, true)
  else
    vim.cmd("belowright split | resize 10 | term pwsh")
  end
end, { desc = "🖥️ Toggle Terminal" })

-- Clipboard Operations
vim.keymap.set("n", "<C-c>", '"+y', { silent = true, desc = "📋 Copy to Clipboard" })
vim.keymap.set("n", "<C-x>", '"+d', { silent = true, desc = "✂️ Cut to Clipboard" })
vim.keymap.set("n", "<C-v>", '"+p', { silent = true, desc = "📋 Paste from Clipboard" })

-- debug start
vim.keymap.set("n", "<F5>", function() require("dap").continue() end, { desc = "Start/Continue Debugging" })


-- Resize Splits with Ctrl + Shift + Arrow Keys (or h/l)
vim.keymap.set("n", "<C-S-Up>",    ":resize +2<CR>", { desc = "Increase Height" })
vim.keymap.set("n", "<C-S-Down>",  ":resize -2<CR>", { desc = "Decrease Height" })
vim.keymap.set("n", "<C-S-Left>",  ":vertical resize -2<CR>", { desc = "Decrease Width (May Not Work)" })
vim.keymap.set("n", "<C-S-Right>", ":vertical resize +2<CR>", { desc = "Increase Width (May Not Work)" })

-- Alternative: Use h/l for guaranteed horizontal resizing
vim.keymap.set("n", "<C-S-h>", ":vertical resize -2<CR>", { desc = "Decrease Width" })
vim.keymap.set("n", "<C-S-l>", ":vertical resize +2<CR>", { desc = "Increase Width" })

-- Move between splits with <Ctrl> + Arrow Keys
vim.keymap.set("n", "<C-Up>",    "<C-w><Up>", { desc = "Move to Up Split" })
vim.keymap.set("n", "<C-Down>",  "<C-w><Down>", { desc = "Move to Down Split" })
vim.keymap.set("n", "<C-Left>",  "<C-w><Left>", { desc = "Move to Left Split" })
vim.keymap.set("n", "<C-Right>", "<C-w><Right>", { desc = "Move to Right Split" })

-- Move lines up and down with Alt + j/k
vim.keymap.set("n", "<A-Up>",   ":m .-2<CR>==", { desc = "Move Line Up" })
vim.keymap.set("n", "<A-Down>", ":m .+1<CR>==", { desc = "Move Line Down" })

-- Move visual selection up and down with Alt + j/k
vim.keymap.set("x", "<A-Up>",   ":m '<-2<CR>gv=gv", { desc = "Move Selection Up" })
vim.keymap.set("x", "<A-Down>", ":m '>+1<CR>gv=gv", { desc = "Move Selection Down" })

-- Indent multiple lines with Alt + >/<
vim.keymap.set("x", "<A-Right>", ">gv", { desc = "Indent Selection" })
vim.keymap.set("x", "<A-Left>",  "<gv", { desc = "Unindent Selection" })


vim.keymap.set("n", "<C-e>", ":Neotree filesystem toggle<CR>", { desc = "Toggle Neo-tree Filesystem" })
vim.keymap.set("n", "<C-g>", ":Neotree git_status toggle<CR>", { desc = "Toggle Neo-tree Git Status" })
vim.keymap.set("n", "<C-b>", ":Neotree buffers toggle<CR>", { desc = "Toggle Neo-tree Buffers" })

-- Dashboard
wk.register({
  A = { "<cmd>Dashboard<CR>", "🏠 Dashboard" },
}, { prefix = "<leader>" })