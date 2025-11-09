function getPythonPath()
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
end

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

      require("mason-nvim-dap").setup({
        automatic_installation = false,
        ensure_installed = {},
        handlers = {
          function(config)
            require("mason-nvim-dap").default_setup(config)
          end,
        },
      })

      dap.adapters =
      {
        lldb = {
          type = "executable",
          command = "lldb-dap",
        },
        coreclr = {
          type = "executable",
          command = "/usr/local/netcoredbg",
          args = { "--interpreter=vscode" },
          justMyCode = true,
        },
        netcoredbg = {
          type = "executable",
          command = "/usr/local/netcoredbg",
          args = { "--interpreter=vscode" },
        },
        debugpy = function(cb, config)
          if config.request == 'attach' then
            ---@diagnostic disable-next-line: undefined-field
            local port = (config.connect or config).port
            ---@diagnostic disable-next-line: undefined-field
            local host = (config.connect or config).host or '127.0.0.1'
            cb({
              type = "server",
              port = assert(port, "`connect.port` is required for a python `attach` configuration"),
              host = host,
              options = {
                source_filetype = "python",
              },
            })
          else
            cb({
              type = "executable",
              command = "python",
              args = { "-m", "debugpy.adapter" },
              options = {
                source_filetype = "python",
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
              return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
            end,
          },
          {
            type = "coreclr",
            name = "launch - godot",
            request = "launch",
            program = "godot",
            args = { "--path", "${workspaceFolder}" },
          },
          {
            type = "lldb",
            name = "LLDB",
            request = "launch",
            program = function() -- 👈 focus this function
              return coroutine.create(function(dap_run_co)
                local picker = require("scripts.picker")
                picker.get_file(
                  { title = "python <file>: select input file:" },
                  function(select_item)
                    coroutine.resume(dap_run_co, select_item)
                  end
                )
              end)
            end,
            sourceMap = {
              { "/", "${workspaceFolder}" },
            },
          }
        },
        python = {
          {
            type = "debugpy",
            request = "launch",
            name = "Launch File",
            program = "${file}",
            pythonPath = getPythonPath,
          },
          {
            type = "debugpy",
            request = "launch",
            name = "Launch File With Args",
            args = function()
              local input = vim.fn.input({ prompt = "Args: " })
              local t = {}
              for str in string.gmatch(input, "([^" .. " " .. "]+)") do
                table.insert(t, str)
              end
              return t
            end,
            program = "${file}",
            pythonPath = getPythonPath,
          },
          {
            type = "debugpy",
            request = "launch",
            name = "Launch Module",
            program = "-m ${file}", -- This configuration will launch the current file if used.
            pythonPath = getPythonPath,
            args = function()
              return vim.fn.input({ prompt = "Args: " })
            end
          },
        }
      }

      require("overseer").enable_dap()

      vim.fn.sign_define(
        "DapBreakpoint",
        { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
      )
      vim.fn.sign_define(
        "DapStopped",
        { text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" }
      )

      -- Setup Keymaps
      vim.api.nvim_set_keymap("n", "<leader>db", ":DapToggleBreakpoint<CR>",
        { desc = " Toggle Breakpoint", noremap = true })
      vim.api.nvim_set_keymap("n", "<leader>dc", ":DapContinue<CR>", { desc = " Continue", noremap = true })
      vim.api.nvim_set_keymap("n", "<leader>dc", ":DapContinue<CR>", { desc = " Continue", noremap = true })
      vim.api.nvim_set_keymap("n", "<leader>ds", ":DapTerminate<CR>", { desc = " Terminate", noremap = true })
      vim.api.nvim_set_keymap("n", "<leader>do", ":DapStepOver<CR>", { desc = " Step Over", noremap = true })
      vim.api.nvim_set_keymap("n", "<leader>di", ":DapStepInto<CR>", { desc = "󰆹 Step Into", noremap = true })
      vim.api.nvim_set_keymap("n", "<leader>de", ":DapStepOut<CR>", { desc = "󰆸 Step Out", noremap = true })
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

      vim.keymap.set("n", "<leader>dt", function()
        require('dapui').toggle({ reset = true })
      end, { desc = "󰨙 Toggle Debug GUI", })
    end
  }
}
