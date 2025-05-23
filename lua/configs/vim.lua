local utils = require('../utils')
-- HACK: [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!


-- Set highlight on search
vim.o.hlsearch = true

-- Turn off highlight when pressing escape
vim.keymap.set("n", "<esc>", "<cmd>nohlsearch<CR>")

-- Make line numbers default
vim.wo.number = true

vim.o.relativenumber = true

vim.o.shiftwidth = 4
vim.o.tabstop = 4

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

vim.o.conceallevel = 1

-- HACK: [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })


-- Window Navigation
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = 'Change to right window'})
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = 'Change to left window'})
vim.keymap.set("n", "<C-j>", "<C-w>i", { desc = 'Change to down window'})
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = 'Change to up window'})
vim.keymap.set("n", "<C-Right>", "<C-w>l", { desc = 'Change to right window'})
vim.keymap.set("n", "<C-Left>", "<C-w>h", { desc = 'Change to left window'})
vim.keymap.set("n", "<C-Down>", "<C-w>i", { desc = 'Change to down window'})
vim.keymap.set("n", "<C-Up>", "<C-w>k", { desc = 'Change to up window'})


-- HACK: [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})


-- HACK: Moving lines keybinds

vim.keymap.set("n", "<A-j>", ":m .+1<CR>==") -- move line up(n)
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==") -- move line down(n)
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv") -- move line up(v)
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv") -- move line down(v)


-- HACK: Terminal keybinds
local getterminal = function()
  if utils.getOS() == "Windows" then
    return "powershell"
  else
    return "fish" -- kitty loads in separate windows :skull:
  end
end

local terminalname = getterminal()

vim.keymap.set("n", "<leader>t", ":vsplit | terminal " .. terminalname .. "<CR> | a")
vim.keymap.set("t", "<Esc>", "<C-\\><C-n><C-w>q")

-- HACK: Unmap arrow keys because I cannot trust my muscle memory (only in insert mode, duh)
vim.keymap.set("n", "<left>", ":echo \"NO ARROWS!\" <CR>")
vim.keymap.set("n", "<right>", ":echo \"NO ARROWS!\" <CR>")
vim.keymap.set("n", "<up>", ":echo \"NO ARROWS!\" <CR>")
vim.keymap.set("n", "<down>", ":echo \"NO ARROWS!\" <CR>")
vim.keymap.set("v", "<left>", ":echo \"NO ARROWS!\" <CR>")
vim.keymap.set("v", "<right>", ":echo \"NO ARROWS!\" <CR>")
vim.keymap.set("v", "<up>", ":echo \"NO ARROWS!\" <CR>")
vim.keymap.set("v", "<down>", ":echo \"NO ARROWS!\" <CR>")

