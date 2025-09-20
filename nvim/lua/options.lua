require "nvchad.options"
-- ~/.config/nvim/lua/options.lua
-- VSCode-like behavior configurations

local opt = vim.opt

-- VSCode-like cursor behavior
opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50"

-- Better scrolling like VSCode
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.smoothscroll = true

-- VSCode-like mouse behavior
opt.mouse = "a"
opt.mousefocus = true

-- Line numbers like VSCode
opt.number = true
opt.relativenumber = false -- VSCode doesn't use relative numbers by default

-- Search behavior like VSCode
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Indentation like VSCode
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
opt.smartindent = true
opt.autoindent = true

-- File handling like VSCode
opt.autoread = true
opt.backup = false
opt.writebackup = false
opt.swapfile = false

-- Completion behavior like VSCode
opt.completeopt = "menu,menuone,noselect"
opt.pumheight = 10
opt.pumwidth = 15

-- Visual improvements like VSCode
opt.cursorline = true
opt.signcolumn = "yes"
opt.colorcolumn = "80,120"
opt.wrap = false

-- Split behavior like VSCode
opt.splitbelow = true
opt.splitright = true

-- Clipboard like VSCode (system clipboard)
opt.clipboard = "unnamedplus"

-- Undo behavior like VSCode
opt.undofile = true
opt.undolevels = 10000

-- Timeout settings for better responsiveness
opt.updatetime = 200
opt.timeout = true
opt.timeoutlen = 300

-- Terminal colors
opt.termguicolors = true

-- Global statusline like VSCode
opt.laststatus = 3

-- VSCode-like folding
opt.foldmethod = "indent"
opt.foldlevel = 99
opt.foldenable = false -- Start with all folds open

-- Auto commands for VSCode-like behavior
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Auto-save like VSCode (optional)
augroup("AutoSave", { clear = true })
autocmd({"TextChanged", "TextChangedI"}, {
  group = "AutoSave",
  pattern = "*",
  callback = function()
    -- Auto-save after 2 seconds of no changes (like VSCode)
    vim.defer_fn(function()
      if vim.bo.modified and vim.bo.buftype == "" and vim.fn.expand("%") ~= "" then
        vim.cmd("silent! write")
      end
    end, 2000)
  end,
})

-- Highlight on yank (VSCode-like feedback)
augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
  group = "YankHighlight",
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
  end,
})

-- Auto-format on save like VSCode
augroup("FormatOnSave", { clear = true })
autocmd("BufWritePre", {
  group = "FormatOnSave",
  pattern = "*",
  callback = function()
    -- Format with conform.nvim if available
    local conform = require("conform")
    if conform then
      conform.format({ async = false, lsp_fallback = true })
    end
  end,
})

-- Restore cursor position like VSCode
augroup("RestoreCursor", { clear = true })
autocmd("BufReadPost", {
  group = "RestoreCursor",
  pattern = "*",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Close some windows with Escape like VSCode
augroup("EscapeClose", { clear = true })
autocmd("FileType", {
  group = "EscapeClose",
  pattern = { "help", "lspinfo", "man", "qf", "query" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "<Esc>", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- Resize splits automatically like VSCode
augroup("ResizeSplits", { clear = true })
autocmd("VimResized", {
  group = "ResizeSplits",
  pattern = "*",
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})
