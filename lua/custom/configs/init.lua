-- HACK: Moving lines keybinds

vim.keymap.set("n", "<A-j>", ":m .+1<CR>==") -- move line up(n)
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==") -- move line down(n)
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv") -- move line up(v)
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv") -- move line down(v)


-- HACK: Terminal keybinds

vim.keymap.set("n", "<leader>t", ":vsplit | terminal powershell<CR> | a")
vim.keymap.set("t", "<Esc>", "<C-\\><C-n><C-w>q")


-- HACK: LOAD PLUGIN CONFIGS

require('custom.configs.harpoon')
require('custom.configs.dap')
require('custom.configs.colorscheme')
require('custom.configs.neotree')
require('custom.configs.chatgpt')
require('custom.configs.indent')
