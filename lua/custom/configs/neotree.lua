local ntree = require('neo-tree.command')
require('neo-tree').setup({
  close_if_last_window = true,   -- Close Neo-tree if it's the last window
  enable_git_status = true,
  filesystem = {
    filtered_items = {
      hide_dotfiles = true,
      hide_gitignored = true,
    },
    follow_current_file = {
      enabled = true,
    }, -- Sync tree with open file
    leave_dirs_open = true,
    -- hijack_netrw_behavior = "open_default", -- Replace netrw
  },
  window = {
    width = 30,
    mappings = {
      -- ["?"] = "thisisfake"       -- Look at the keymaps. <cmd> :help neo-tree-mappings shows instructions
    }
  },
})


vim.keymap.set('n', '<leader>se', function ()
  ntree.execute({ toggle = true, dir = vim.loop.cwd() })
end, { desc = '[S]earch N[E]otree' })
