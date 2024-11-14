return {
  'mfussenegger/nvim-dap',
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    --golang
    'leoluz/nvim-dap-go',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'node2',
        'chrome',
        'delve', -- golang
      },
    }

    -- Basic debugging keymaps, feel free to change to your liking!
    vim.keymap.set('n', '<leader>ds', dap.continue, { desc = '[s]tart / continue' })
    vim.keymap.set('n', '<leader>di', dap.step_into, { desc = 'Step [i]nto' })
    vim.keymap.set('n', '<leader>do', dap.step_over, { desc = 'Step [o]ver' })
    vim.keymap.set('n', '<leader>dx', dap.step_out, { desc = 'Step out / e[x]it' })
    vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Toggle [b]reakpoint' })
    vim.keymap.set('n', '<leader>dc', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint [c]ondition: ')
    end, { desc = 'Set Breakpoint' })

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    vim.keymap.set('n', '<leader>dl', dapui.toggle, { desc = 'See [l]ast session result' })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Install golang specific config
    require('dap-go').setup {}

    -- Debugger configurations
    dap.configurations.javascript = {
      {
        name = 'Launch',
        type = 'node2',
        request = 'launch',
        program = '${file}',
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = 'inspector',
        console = 'integratedTerminal',
      },
      {
        -- For this to work you need to make sure the node process is started with the `--inspect` flag.
        name = 'Attach to process',
        type = 'node2',
        request = 'attach',
        processId = require('dap.utils').pick_process,
      },
    }
    dap.configurations.javascriptreact = {
      {
        name = 'Attach to Chrome (JavaScript)',
        type = 'chrome',
        request = 'attach',
        program = '${file}',
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = 'inspector',
        port = 9222,
        webRoot = '${workspaceFolder}',
      },
    }
    dap.configurations.typescriptreact = {
      {
        name = 'Attach to Chrome (TypeScript)',
        type = 'chrome',
        request = 'attach',
        program = '${file}',
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = 'inspector',
        port = 9222,
        webRoot = '${workspaceFolder}',
      },
    }

    -- Kotlin debugging
    if not dap.adapters.kotlin then
      dap.adapters.kotlin = {
        type = 'executable',
        command = 'kotlin-debug-adapter',
        options = { auto_continue_if_many_stopped = false },
      }
    end
    dap.configurations.kotlin = {
      {
        type = 'kotlin',
        request = 'launch',
        name = 'This file',
        -- may differ, when in doubt, whatever your project structure may be,
        -- it has to correspond to the class file located at `build/classes/`
        -- and of course you have to build before you debug
        mainClass = function()
          local root = vim.fs.find('src', { path = vim.uv.cwd(), upward = true, stop = vim.env.HOME })[1] or ''
          local fname = vim.api.nvim_buf_get_name(0)
          -- src/main/kotlin/websearch/Main.kt -> websearch.MainKt
          return fname:gsub(root, ''):gsub('main/kotlin/', ''):gsub('.kt', 'Kt'):gsub('/', '.'):sub(2, -1)
        end,
        projectRoot = '${workspaceFolder}',
        jsonLogFile = '',
        enableJsonLogging = false,
      },
      {
        -- Use this for unit tests
        -- First, run
        -- ./gradlew --info cleanTest test --debug-jvm
        -- then attach the debugger to it
        type = 'kotlin',
        request = 'attach',
        name = 'Attach to debugging session',
        port = 5005,
        args = {},
        projectRoot = vim.fn.getcwd,
        hostName = 'localhost',
        timeout = 2000,
      },
    }
  end,
}
