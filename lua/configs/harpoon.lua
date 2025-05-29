-- HACK: Harpoon setup
local utils = require('utils')
local wk = require("which-key")


local harpoon = require('harpoon')
harpoon.setup()

vim.keymap.set('n', '<leader>hn', function() harpoon:list():next() end, { desc = "Open next marked buffer" })
vim.keymap.set('n', '<leader>hp', function() harpoon:list():prev() end, { desc = "Open previous marked buffer" })
vim.keymap.set('n', '<leader>hx', function() harpoon:list():add() end, { desc = "Mark current buffer" })
vim.keymap.set('n', '<leader>hd', function() harpoon:list():remove() end, { desc = "Remove current buffer from marks" })

local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end

vim.keymap.set("n", "<leader>hm", function() toggle_telescope(harpoon:list()) end,
    { desc = "Open harpoon window" })


-- Harpoon Which-key mappings
wk.add({
  {'<leader>h', group = "[H]arpoon"},
  {'<leader>h_', hidden = true},
})

require('telescope').load_extension('harpoon')
