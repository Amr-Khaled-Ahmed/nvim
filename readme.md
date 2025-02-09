# Neovim Configuration Overview

Welcome to the comprehensive guide for your Neovim setup. This document details the structure, purpose, and customization of your configuration files, helping you understand and maintain your setup with ease.

---

## Table of Contents

1. [Introduction](#introduction)
2. [Directory Structure](#directory-structure)
3. [Configuration Files](#configuration-files)
   - [init.lua](#initlua)
   - [lua/config/](#luaconfig)
   - [lua/plugins/](#luaplugins)
4. [Plugins and Their Roles](#plugins-and-their-roles)
5. [Keybindings](#keybindings)
6. [Conclusion](#conclusion)

---

## Introduction

This Neovim configuration is designed to be **modular** and **extensible**. It leverages **Lazy.nvim** for plugin management and organizes settings into dedicated modules for clarity. The setup focuses on:

- **Core Neovim settings:** Options, autocommands, and keymaps.
- **Plugin integrations:** LSP, Treesitter, Telescope, Git, and more.
- **UI enhancements:** Improved command-line interface, file explorer, and status line.

---

## Directory Structure

Your configuration is organized as follows:

```
~/.config/nvim/
├── init.lua                    # Entry point
├── lua/
│   ├── config/                 # Core configuration settings
│   │   ├── autocmds.lua        # Auto commands (e.g., remove trailing spaces)
│   │   ├── keymaps.lua         # Custom keybindings (using which-key)
│   │   ├── options.lua         # Neovim options (line numbers, splits, clipboard)
│   ├── plugins/                # Plugin configurations
│   │   ├── core.lua            # Core plugins and utilities
│   │   ├── lsp.lua             # Language Server Protocol (LSP) settings
│   │   ├── ui.lua              # UI enhancements (statusline, file explorer, etc.)
│   │   ├── git.lua             # Git integration using Gitsigns
│   │   ├── tools.lua           # Tools (Treesitter, formatters, etc.)
│   │   ├── telescope.lua       # Telescope configuration for fuzzy finding
│   │   ├── dap.lua             # debugger for c, cpp, py(not work now)
│   ├── utils.lua               # Utility functions
│   ├── plugins.lua             # Main plugin loader (Lazy.nvim setup)
```

---

## Configuration Files

### init.lua

The `init.lua` file bootstraps Lazy.nvim and loads all the necessary configurations. It serves as the entry point for Neovim.

```lua
-- init.lua

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- Use the latest stable release
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
```

### lua/config/

#### options.lua

Sets fundamental options such as line numbers, clipboard, and split behaviors.

```lua
-- lua/config/options.lua
vim.opt.number = true             -- Enable absolute line numbers
vim.opt.relativenumber = true     -- Enable relative line numbers for easier navigation
vim.opt.clipboard = "unnamedplus" -- Integrate system clipboard
vim.opt.splitright = true         -- Vertical splits open to the right
vim.opt.splitbelow = true         -- Horizontal splits open below
```

#### keymaps.lua

Defines custom keybindings using the `which-key` plugin for an improved user experience.

```lua
-- lua/config/keymaps.lua
local wk = require("which-key")

wk.register({
  e = { "<cmd>NvimTreeToggle<CR>", "Toggle File Explorer" },
  s = { "<cmd>w<CR>", "Save File" },
  q = { "<cmd>q<CR>", "Quit Neovim" },
  f = { "<cmd>Telescope find_files<CR>", "Find Files" },
}, { prefix = "<leader>" })
```

### lua/plugins/

Each file in this directory is responsible for configuring a specific group of plugins.

#### git.lua

Integrates Git using `gitsigns.nvim` to display inline diff indicators and provide hunk actions.

```lua
-- lua/plugins/git.lua
return {
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "+", hl = "GitSignsAdd" },
          change = { text = "~", hl = "GitSignsChange" },
          delete = { text = "_", hl = "GitSignsDelete" },
        },
      })
    end,
  },
}
```

---

## Plugins and Their Roles

### Core Plugins
- **Lazy.nvim**: Manages plugins and loads them on demand.
- **Plenary.nvim**: A Lua utility library used by many plugins.

### LSP & Completion
- **nvim-lspconfig**: Simplifies configuration of language servers.
- **Mason.nvim**: Manages installation of LSPs, linters, and formatters.
- **nvim-cmp**: Provides a fast and extensible autocompletion engine.

### UI Enhancements
- **Noice.nvim**: Enhances the command-line UI (configured to appear at the top).
- **Nvim-tree.lua**: A file explorer for navigating your project.
- **Lualine.nvim**: A customizable status line for improved UI.

### Git Integration
- **Gitsigns.nvim**: Displays inline Git diff indicators and provides hunk actions.

### Tools
- **nvim-treesitter**: Improves syntax highlighting, indentation, and overall code understanding.
- **null-ls.nvim**: Integrates external formatters and linters directly into Neovim.
- **Telescope.nvim**: Offers a fuzzy finder for quick navigation.

---

## Keybindings

Key mappings are defined in `lua/config/keymaps.lua` using the `which-key` plugin to create an intuitive, menu-driven approach:

- **File Management:**  
  - `<leader>e` toggles the file explorer.  
  - `<leader>s` saves the current file.

- **Git Actions:**  
  - Custom mappings in `git.lua` allow you to stage, preview, and navigate Git hunks.

- **Fuzzy Finding:**  
  - `<leader>f` launches Telescope for file search.

---

## Conclusion

This Neovim configuration is designed for **efficiency**, **clarity**, and **extensibility**. With a modular structure that separates core settings, plugin configurations, and custom keybindings, you have a powerful environment for development.

Happy coding and customization in Neovim! 🚀

