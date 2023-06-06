return {
  -- Setup nvim-dap plugin configurations
  {
    {
      "s1n7ax/nvim-terminal",
      lazy = false,
      config = function()
        vim.o.hidden = true
        require("nvim-terminal").setup()
      end,
    },
    {
      "ggandor/leap.nvim",
      config = function()
        local leap = require("leap")
      end,
    },
    {
      "tiagovla/scope.nvim",
      lazy = false,
    },
    {
      "kkoomen/vim-doge",
      build = function()
        vim.fn["doge#install"]()
      end,
      lazy = false,
    },
    {
      "nvim-treesitter/nvim-treesitter",
      opts = {
        ensure_installed = {
          "bash",
          "help",
          "lua",
          "python",
          "vim",
          "c",
        },
      },
    },
    {
      "mfussenegger/nvim-dap",
      lazy = false,
      config = function(_, opts)
        local dap = require("dap")
        dap.adapters.cppdbg = {
          id = "cppdbg",
          type = "executable",
          command = "/home/lucas/.local/share/nvim/mason/bin/OpenDebugAD7",
        }
        dap.configurations.cpp = {
          {
            name = "Launch file",
            type = "cppdbg",
            request = "launch",
            program = function()
              return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end,
            cwd = "${workspaceFolder}",
            stopAtEntry = true,
          },
          {
            name = "Attach to gdbserver :1234",
            type = "cppdbg",
            request = "launch",
            MIMode = "gdb",
            miDebuggerServerAddress = "localhost:1234",
            miDebuggerPath = "/usr/bin/gdb",
            cwd = "${workspaceFolder}",
            program = function()
              return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end,
          },
        }
      end,
    },
    { "theHamsta/nvim-dap-virtual-text", lazy = false },
    {
      "rcarriga/nvim-dap-ui",
      lazy = false,
      config = function(_, opts)
        local dapui = require("dapui")
        dapui.setup()
      end,
    },
    { "nvim-telescope/telescope-dap.nvim", lazy = false },
    {
      "nvim-telescope/telescope.nvim",
      config = function(_, opts)
        local telescope = require("telescope")
        telescope.setup(opts)
        telescope.load_extension("dap")
      end,
    },
    {
      "rcarriga/cmp-dap",
      lazy = false,
      config = function(_, opts)
        local cmp = require("cmp")
        cmp.setup({
          enabled = function()
            return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt" or require("cmp_dap").is_dap_buffer()
          end,
        })
        cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
          sources = {
            { name = "dap" },
          },
        })
      end,
    },
  },
}
