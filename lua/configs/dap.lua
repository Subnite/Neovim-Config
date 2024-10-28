-- HACK: Debugger setup
require("mason-nvim-dap").setup()
local dap = require("dap")

local mason_registry = require("mason-registry")
local codelldb = mason_registry.get_package("codelldb")
local codelldb_path = codelldb:get_install_path() .. "/extension/lldb/bin/lldb"
local cpptools = mason_registry.get_package("cpptools")
local cpptools_path = cpptools:get_install_path() .. "/extension/bin/cpptools"

-- dap.adapters.codelldb = {
--     id = "codelldb",
--     type = "executable",
--     command = codelldb_path,
-- }

dap.adapters.cppdbg = {

  id = "cpptools",
  type = "executable",
  command = cpptools_path,
}

dap.configurations.cpp = {
  {
    name = "Launch (codelldb)",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopAtBeginningOfMainSubprogram = false,
    runInTerminal = true,
    stopOnEntry = false,
    args = {},
  },
  {
    name = "AudioPluginHost",
    type = "codelldb",
    request = "launch",
    program = function()
      return "C:/Program Files/JUCE_v7.0.5/Builds/extras/AudioPluginHost/AudioPluginHost_artefacts/Release/AudioPluginHost.exe"
    end,
    cwd = "${workspaceFolder}",
    stopAtBeginningOfMainSubprogram = false,
    runInTerminal = true,
    stopOnEntry = false,
    args = {},
  },
  {
    type = "codelldb",
    request = "launch",
    name = "Ableton",
    program = function()
      return "C:/ProgramData/Ableton/Live 12 Suite/Program/Ableton Live 12 Suite.exe"
    end,
    args = {},
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    runInTerminal = true,
    stopAtBeginningOfMainSubprogram = false,
  },
  {
    name = "juce_vst3_helper",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.getcwd() .. "/build/Source/juce_vst3_helper.exe"
    end,
    cwd = "${workspaceFolder}",
    stopAtBeginningOfMainSubprogram = false,
    runInTerminal = true,
    stopOnEntry = false,
    vstname = function()
      vim.fn.input("Plugin Name: ")
    end,
    args = {
      "-create",
      "-version", "1.0.0",
      "-path", "${workspaceFolder}/build/Source/${vstname}_artefacts/Debug/VST3/${vstname}.vst3/Contents/x86_64-win/${vstname}.vst3",
      "-output", "${workspaceFolder}/build/moduleinfo.json"},
  },
}
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

local dapui = require('dapui')
dapui.setup()

-- auto open and close
dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

vim.keymap.set('n', '<leader>db', function() dap.toggle_breakpoint() end, { desc = "[D]ebug [B]reakpoint" })
vim.keymap.set('n', '<leader>du', function() dapui.toggle() end, { desc = "[D]ap [U]I" })
vim.keymap.set('n', '<leader>dc', function() dap.continue() end, { desc = "[D]ap [C]ontinue" })
vim.keymap.set('n', '<leader>do', function() dap.step_over() end, { desc = "[D]ap Step [O]ver" })
vim.keymap.set('n', '<leader>di', function() dap.step_into() end, { desc = "[D]ap Step [I]nto" })
vim.keymap.set('n', '<leader>dO', function() dap.step_out() end, { desc = "[D]ap Step [O]ut" })
vim.keymap.set('n', '<leader>dC', function() dap.clear_breakpoints() end, { desc = "[D]ap [C]lear breakpoints" })
