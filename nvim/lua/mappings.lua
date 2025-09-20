-- ~/.config/nvim/lua/mappings.lua

require "nvchad.mappings"

local map = vim.keymap.set

-- General mappings
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

--vscode like
map("n", "<C-z>", "u", { desc = "Undo" })
map("i", "<C-z>", "<C-o>u", { desc = "Undo in insert mode" })
map("n", "<C-y>", "<C-r>", { desc = "Redo" })
map("i", "<C-y>", "<C-o><C-r>", { desc = "Redo in insert mode" })
-- Word deletion like VSCode
map("i", "<C-Del>", "<C-o>de", { desc = "Delete word forward" })
map("i", "<C-BS>", "<C-w>", { desc = "Delete word backward" })
map("n", "<C-Del>", "de", { desc = "Delete word forward" })
map("n", "<C-BS>", "db", { desc = "Delete word backward" })

-- Line operations like VSCode
map("n", "<C-l>", "dd", { desc = "Delete current line" })
map("i", "<C-l>", "<C-o>dd", { desc = "Delete current line in insert mode" })

-- Move lines up/down like VSCode (Alt+Up/Down)
map("n", "<A-Up>", ":m .-2<CR>==", { desc = "Move line up" })
map("n", "<A-Down>", ":m .+1<CR>==", { desc = "Move line down" })
map("i", "<A-Up>", "<Esc>:m .-2<CR>==gi", { desc = "Move line up in insert mode" })
map("i", "<A-Down>", "<Esc>:m .+1<CR>==gi", { desc = "Move line down in insert mode" })
map("v", "<A-Up>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
map("v", "<A-Down>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })

-- Page scrolling like VSCode (Ctrl+Up/Down)
map("n", "<C-Up>", "<C-u>zz", { desc = "Scroll half page up and center" })
map("n", "<C-Down>", "<C-d>zz", { desc = "Scroll half page down and center" })
map("i", "<C-Up>", "<C-o><C-u><C-o>zz", { desc = "Scroll half page up in insert mode" })
map("i", "<C-Down>", "<C-o><C-d><C-o>zz", { desc = "Scroll half page down in insert mode" })

-- VSCode-like duplicate line (Shift+Alt+Up/Down)
map("n", "<S-A-Up>", "yyP", { desc = "Duplicate line up" })
map("n", "<S-A-Down>", "yyp", { desc = "Duplicate line down" })
map("i", "<S-A-Up>", "<C-o>yyP", { desc = "Duplicate line up in insert mode" })
map("i", "<S-A-Down>", "<C-o>yyp", { desc = "Duplicate line down in insert mode" })
map("v", "<S-A-Up>", "y`>pgv", { desc = "Duplicate selection up" })
map("v", "<S-A-Down>", "y`<Pgv", { desc = "Duplicate selection down" })

-- Select all like VSCode
map("n", "<C-a>", "ggVG", { desc = "Select all" })
map("i", "<C-a>", "<C-o>ggVG", { desc = "Select all in insert mode" })

-- Save like VSCode
map("n", "<C-s>", "<cmd>w<CR>", { desc = "Save file" })
map("i", "<C-s>", "<C-o><cmd>w<CR>", { desc = "Save file in insert mode" })

-- Find like VSCode
map("n", "<C-f>", "/", { desc = "Find" })
map("i", "<C-f>", "<C-o>/", { desc = "Find in insert mode" })

-- Replace like VSCode (Ctrl+H)
map("n", "<C-h>", ":%s/", { desc = "Replace" })
map("v", "<C-h>", ":s/", { desc = "Replace in selection" })

-- Go to line like VSCode (Ctrl+G)
map("n", "<C-g>", ":", { desc = "Go to line" })
map("i", "<C-g>", "<C-o>:", { desc = "Go to line in insert mode" })

-- Comment toggle like VSCode (Ctrl+/)
map("n", "<C-/>", "gcc", { desc = "Toggle comment", remap = true })
map("v", "<C-/>", "gc", { desc = "Toggle comment", remap = true })
map("i", "<C-/>", "<C-o>gcc", { desc = "Toggle comment in insert mode", remap = true })

-- Multi-cursor like functionality (Ctrl+D)
map("n", "<C-d>", "*``cgn", { desc = "Change next occurrence" })
map("x", "<C-d>", '"sy:let @/=@s<CR>``cgn', { desc = "Change next occurrence of selection" })

-- Navigate between splits like VSCode
map("n", "<C-k>", "<C-w>k", { desc = "Move to split above" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to split below" })
map("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })

-- Tab navigation like VSCode
map("n", "<C-Tab>", "<cmd>BufferNext<CR>", { desc = "Next buffer" })
map("n", "<C-S-Tab>", "<cmd>BufferPrevious<CR>", { desc = "Previous buffer" })
map("n", "<C-w>", "<cmd>bd<CR>", { desc = "Close buffer" })

-- Quick file operations
map("n", "<C-n>", "<cmd>enew<CR>", { desc = "New file" })
map("n", "<C-o>", "<cmd>Telescope find_files<CR>", { desc = "Open file" })

-- Indentation like VSCode
map("v", "<Tab>", ">gv", { desc = "Indent selection" })
map("v", "<S-Tab>", "<gv", { desc = "Unindent selection" })
map("n", "<Tab>", ">>", { desc = "Indent line" })
map("n", "<S-Tab>", "<<", { desc = "Unindent line" })

-- Go specific mappings
map("n", "<leader>gsj", "<cmd>GoAddTag json<CR>", { desc = "Add json struct tags" })
map("n", "<leader>gsy", "<cmd>GoAddTag yaml<CR>", { desc = "Add yaml struct tags" })
map("n", "<leader>gst", "<cmd>GoAddTag toml<CR>", { desc = "Add toml struct tags" })
map("n", "<leader>gsq", "<cmd>GoRmTag<CR>", { desc = "Remove all struct tags" })

map("n", "<leader>gie", "<cmd>GoIfErr<CR>", { desc = "Add if err" })
map("n", "<leader>gfs", "<cmd>GoFillStruct<CR>", { desc = "Autofill struct" })

-- Test mappings
map("n", "<leader>gtf", "<cmd>GoTestFunc<CR>", { desc = "Run test for current func" })
map("n", "<leader>gtc", "<cmd>GoCoverage<CR>", { desc = "Test coverage" })
map("n", "<leader>gtt", "<cmd>GoTest<CR>", { desc = "Run tests" })
map("n", "<leader>gta", "<cmd>GoAlt<CR>", { desc = "Alternate between test and code" })

-- Build and run
map("n", "<leader>grr", "<cmd>GoRun<CR>", { desc = "Run go file" })
map("n", "<leader>gbb", "<cmd>GoBuild<CR>", { desc = "Build go file" })

-- DAP mappings
map("n", "<leader>db", "<cmd>DapToggleBreakpoint<CR>", { desc = "Add breakpoint at line" })
map("n", "<leader>dr", "<cmd>DapContinue<CR>", { desc = "Run or continue debugger" })
map("n", "<F5>", "<cmd>DapContinue<CR>", { desc = "Continue" })
map("n", "<F10>", "<cmd>DapStepOver<CR>", { desc = "Step over" })
map("n", "<F11>", "<cmd>DapStepInto<CR>", { desc = "Step into" })
map("n", "<F12>", "<cmd>DapStepOut<CR>", { desc = "Step out" })

-- Neotest mappings
map("n", "<leader>tt", function()
    require("neotest").run.run()
end, { desc = "Run nearest test" })
map("n", "<leader>tf", function()
    require("neotest").run.run(vim.fn.expand "%")
end, { desc = "Run file tests" })
map("n", "<leader>td", function()
    require("neotest").run.run { strategy = "dap" }
end, { desc = "Debug nearest test" })
map("n", "<leader>ts", function()
    require("neotest").summary.toggle()
end, { desc = "Toggle test summary" })
map("n", "<leader>to", function()
    require("neotest").output_panel.toggle()
end, { desc = "Toggle test output panel" })

-- Gitsigns mappings
map("n", "]c", function()
    require("gitsigns").next_hunk()
end, { desc = "Next git hunk" })
map("n", "[c", function()
    require("gitsigns").prev_hunk()
end, { desc = "Previous git hunk" })
map("n", "<leader>hs", function()
    require("gitsigns").stage_hunk()
end, { desc = "Stage git hunk" })
map("n", "<leader>hr", function()
    require("gitsigns").reset_hunk()
end, { desc = "Reset git hunk" })
map("n", "<leader>hp", function()
    require("gitsigns").preview_hunk()
end, { desc = "Preview git hunk" })
map("n", "<leader>hb", function()
    require("gitsigns").blame_line { full = true }
end, { desc = "Git blame line" })
