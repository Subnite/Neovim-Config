-- HACK: Harpoon setup
local utils = require('custom.utils')
local wk = require("which-key")


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
wk.add({
  {'<leader>h', group = "[H]arpoon"},
  {'<leader>h_', hidden = true},
  {'<leader>hx', function ()
    harpoon:list():append()
  end, desc = "Mark file"},
})
require('telescope').load_extension('harpoon')
