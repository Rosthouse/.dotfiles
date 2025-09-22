return {
  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = {
      "mason-org/mason.nvim",
      "jay-babu/mason-nvim-dap.nvim",
      "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
      local dap = require("dap")
      require("nvim-dap-virtual-text").setup({})
      -- Setup Mason integration
      local pickers = require("telescope.pickers")

      require("mason-nvim-dap").setup({
        handlers = {
          function(config)
            require("mason-nvim-dap").default_setup(config)
          end,
        },
      })

      dap.adapters =
      {
        coreclr = {
          type = "executable",
          command = "/usr/local/netcoredbg",
          args = { "--interpreter=vscode" },
          justMyCode = false,
        },
        netcoredbg = {
          type = "executable",
          command = "/usr/local/netcoredbg",
          args = { "--interpreter=vscode" },
        },
        python = function(cb, config)
          if config.request == 'attach' then
            ---@diagnostic disable-next-line: undefined-field
            local port = (config.connect or config).port
            ---@diagnostic disable-next-line: undefined-field
            local host = (config.connect or config).host or '127.0.0.1'
            cb({
              type = 'server',
              port = assert(port, '`connect.port` is required for a python `attach` configuration'),
              host = host,
              options = {
                source_filetype = 'python',
              },
            })
          else
            cb({
              type = 'executable',
              command = 'python',
              args = { '-m', 'debugpy.adapter' },
              options = {
                source_filetype = 'python',
              },
            })
          end
        end
      }

      dap.configurations = {
        cs = {
          {
            type = "coreclr",
            name = "launch - netcoredbg",
            request = "launch",
            program = function()
              print(vim.g.roslyn_nvim_selected_solution)
              return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
            end,
            args = function()
              return coroutine.create(function(coro)
                local opts = {}
                pickers.new(opts, {
                  prompt_title = "Select launch profile",

                })
              end)
            end
          },
          {
            type = "coreclr",
            name = "launch - godot",
            request = "launch",
            program = "godot",
            args = { "--path", "${workspaceFolder}" },
          }
        },
        python = {
          {
            type = "python",
            request = "launch",
            name = "Launch File",
            program = "${file}", -- This configuration will launch the current file if used.
            pythonPath = function()
              -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
              -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
              -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
              local cwd = vim.fn.getcwd()
              if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
                return cwd .. "/venv/bin/python"
              elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
                return cwd .. "/.venv/bin/python"
              else
                return "/usr/bin/python"
              end
            end,
          }
        }
      }

      vim.fn.sign_define(
        "DapBreakpoint",
        { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
      )
      vim.fn.sign_define(
        "DapStopped",
        { text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" }
      )

      -- Setup Keymaps
      vim.api.nvim_set_keymap("n", "<F9>", ":DapToggleBreakpoint<CR>", { noremap = true })
      vim.api.nvim_set_keymap("n", "<leader>ldb", ":DapToggleBreakpoint<CR>",
        { desc = " Toggle Breakpoint", noremap = true })
      vim.api.nvim_set_keymap("n", "<F5>", ":DapContinue<CR>", { noremap = true })
      vim.api.nvim_set_keymap("n", "<F17>", ":DapTerminate<CR>", { noremap = true })
      vim.api.nvim_set_keymap("n", "<F10>", ":DapStepOver<CR>", { noremap = true })
      vim.api.nvim_set_keymap("n", "<F11>", ":DapStepInto<CR>", { noremap = true })
      vim.api.nvim_set_keymap("n", "<F12>", ":DapStepOut<CR>", { noremap = true })
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()

      --auto open & close the UI panes
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end

      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end

      vim.api.nvim_set_keymap(
        "n",
        "<leader>dr",
        "<cmd>lua require('dapui').toggle({reset = true})<CR>", --reset layout
        { desc = "󰨙 Toggle Debug GUI", noremap = true }
      )
    end
  }
}
