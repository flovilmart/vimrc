function config()
  dap = require('dap')
  -- Set keymaps to control the debugger
  vim.keymap.set('n', '<leader>c', dap.continue)
  vim.keymap.set('n', '<leader>s', dap.step_over)
  vim.keymap.set('n', '<leader>d', dap.step_into)
  vim.keymap.set('n', '<leader>a', dap.step_out)
  vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint)
  vim.keymap.set('n', '<leader>B', function()
    dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
  end)

  vim.keymap.set('n', '<leader>de', function()
    vim.ui.input({ prompt = 'Enter the port number: ', default = '9229' }, function(input)
    if input then
      local port = tonumber(input)
      if port and port > 0 and port < 65536 then
        require("dap").adapters["node"] = {
          type = "server",
          host = "localhost",
          port = port,
          executable = {
            command = "node",
            -- 💀 Make sure to update this path to point to your installation
            args = {"/Users/florentvilmart/src/microsoft/js-debug/src/dapDebugServer.js", port},
          },
          enrich_config = function(config, on_config)
            local final_config = vim.deepcopy(config)
            on_config(final_config)
          end
        }
        print('Debugger configured to use port: ' .. port)
        dapui.open({})
        dap.continue({ configuration = "Attach" })
      else
        print('Invalid port number. Please enter a number between 1 and 65535.')
      end
    end
end)
  end)

  require("dap").adapters["node"] = {
    type = "server",
    host = "localhost",
    port = "${port}",
    executable = {
      command = "node",
      -- 💀 Make sure to update this path to point to your installation
      args = {"/Users/florentvilmart/src/microsoft/js-debug/src/dapDebugServer.js", "${port}"},
    },
    enrich_config = function(config, on_config)
      local final_config = vim.deepcopy(config)
      on_config(final_config)
    end
  }

  local js_based_languages = { "typescript", "javascript", "typescriptreact" }

  for _, language in ipairs(js_based_languages) do
    dap.configurations[language] = {
      {
        type = "node",
        request = "attach",
        name = "Attach",
        host = "localhost",
        port = 9229,
        cwd = "${workspaceFolder}"
      }
      -- {
      --   type = "node",
      --   request = "launch",
      --   name = "Launch file",
      --   program = "${file}",
      --   cwd = "${workspaceFolder}",
      -- },
      -- {
      --   type = "chrome",
      --   request = "launch",
      --   name = "Start Chrome with \"localhost\"",
      --   url = "http://localhost:3000",
      --   webRoot = "${workspaceFolder}",
      --   userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir"
      -- }
    }
  end
  dapui = require('dapui')

  dapui.setup()

  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open({})
  end
  -- dap.listeners.before.event_terminated["dapui_config"] = function()
  --   dapui.close({})
  -- end
  -- dap.listeners.before.event_exited["dapui_config"] = function()
  --   dapui.close({})
  -- end

  vim.keymap.set('n', '<leader>ui', require 'dapui'.toggle)
end

return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio',
    },
    config = config
  }
}
