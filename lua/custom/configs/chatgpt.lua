local chatgpt = require("chatgpt")
chatgpt.setup()

vim.keymap.set('n', '<leader>sc', function() chatgpt.openChat() end, { desc = "[S]earch [C]hatGPT" })
