local utils = require('custom.utils')
local wk = require("which-key")

-- HACK: Harpoon setup

local harpoon = require('harpoon').setup({
  global_settings = {
    save_on_toggle = false,
    save_on_change = true,
    enter_on_sendcmd = false,
    tmux_autoclose_windows = false,
    excluded_filetypes = { 'harpoon' },
    mark_branch = true,
    tabline = false,
    tabline_prefix = "  ",
    tabline_suffix = "  ",
  }

}, {});

vim.keymap.set('n', '<leader>hn', function() harpoon:list():next() end, { desc = "Open next marked buffer" })
vim.keymap.set('n', '<leader>hp', function() harpoon:list():prev() end, { desc = "Open previous marked buffer" })
utils.map('n', [[<leader>hm]], ':Telescope harpoon marks<CR>')

-- Harpoon Which-key mappings
wk.register({
    -- The first key you are pressing
    h = {
        name  = "[H]arpoon",
        -- the second key
        x = { function()
            harpoon:list():append()
        end, "Mark file" }
    },
}, { prefix = "<leader>" })

require('telescope').load_extension('harpoon')


-- HACK: Moving lines keybinds

vim.keymap.set("n", "<A-j>", ":m .+1<CR>==") -- move line up(n)
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==") -- move line down(n)
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv") -- move line up(v)
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv") -- move line down(v)


-- HACK: Terminal keybinds

vim.keymap.set("n", "<leader>t", ":vsplit | terminal powershell<CR>")
vim.keymap.set("t", "<Esc>", "<C-\\><C-n><C-w>q")


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
--
-- dap.adapters.cppdbg = {
--   id = "cpptools",
--   type = "executable",
--   command = cpptools_path,
-- }
--
-- dap.configurations.cpp = {
--   {
--     name = "Launch (codelldb)",
--     type = "codelldb",
--     request = "launch",
--     program = function()
--       return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
--     end,
--     cwd = "${workspaceFolder}",
--     stopAtBeginningOfMainSubprogram = false,
--   },
-- }
-- dap.configurations.c = dap.configurations.cpp
-- dap.configurations.rust = dap.configurations.cpp
--
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
vim.keymap.set('n', '<F5>', function() dap.continue() end, { desc = "Dap Continue" })
vim.keymap.set('n', '<F10>', function() dap.step_over() end, { desc = "Step Over" })
vim.keymap.set('n', '<F11>', function() dap.step_into() end, { desc = "Step Into" })
vim.keymap.set('n', '<F12>', function() dap.step_out() end, { desc = "Step Out" })
