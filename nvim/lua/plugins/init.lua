-- ~/.config/nvim/lua/plugins/init.lua

return {
  -- Override conform.nvim formatting
  {
    "stevearc/conform.nvim",
    event = 'BufWritePre',
    opts = require "configs.conform",
  },

  -- Override Mason LSP installer
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- lua stuff
        "lua-language-server",
        "stylua",
        
        -- go stuff
        "gopls",
        "gofumpt", 
        "goimports",
        "golines",
        "golangci-lint",
        "delve",
        "gotests",
        "gomodifytags",
        "impl",
        
        -- web dev
        "css-lsp",
        "html-lsp", 
        "typescript-language-server",
        "prettier",
        
        -- shell
        "shfmt",
        "shellcheck",
        
        -- docker
        "dockerfile-language-server",
        
        -- yaml/json
        "yaml-language-server",
        "json-lsp",
        
        -- markdown
        "marksman",
      },
    },
  },

  -- Override Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim", "lua", "vimdoc",
        "html", "css", "javascript", "typescript", "tsx",
        "c", "markdown", "markdown_inline",
        "go", "gomod", "gowork", "gosum",
        "json", "yaml", "toml", "bash", "dockerfile", "sql", "proto",
      },
    },
  },

  -- For Neovim 0.11, we still need lspconfig for some configurations
  -- but we'll mainly use vim.lsp.config in our config file
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- Go development plugin
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig", 
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup({
        goimports = 'gopls',
        gofmt = 'gofumpt',
        max_line_len = 120,
        tag_transform = false,
        test_dir = '',
        comment_placeholder = '   ',
        lsp_cfg = false, -- Don't let go.nvim configure LSP, we do it ourselves
        lsp_gofumpt = true,
        lsp_on_attach = false,
        dap_debug = true,
        -- Use vim.lsp.config instead of lspconfig
        lsp_client = 'vim.lsp',
      })
    end,
    event = {"CmdlineEnter"},
    ft = {"go", 'gomod'},
    build = ':lua require("go.install").update_all_sync()'
  },

  -- Additional Go tools
  {
    "olexsmir/gopher.nvim", 
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("gopher").setup()
    end,
    ft = "go",
  },

  -- Debug Adapter Protocol
  {
    "mfussenegger/nvim-dap",
    config = function()
      require "configs.dap"
    end
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio"
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end
  },

  {
    "leoluz/nvim-dap-go",
    dependencies = {"mfussenegger/nvim-dap"},
    config = function()
      require("dap-go").setup()
    end,
    ft = "go"
  },

  -- Testing framework
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter", 
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-go",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-go")({
            experimental = {
              test_table = true,
            },
            args = { "-count=1", "-timeout=60s" }
          })
        }
      })
    end,
    ft = "go",
  },

  -- Git integration 
  {
    "lewis6991/gitsigns.nvim",
    opts = function()
      return require("nvchad.configs.gitsigns")
    end,
    config = function(_, opts)
      opts.current_line_blame = true
      opts.current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol',
        delay = 300,
      }
      require("gitsigns").setup(opts)
    end,
  },

  -- Better escape
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },
}
