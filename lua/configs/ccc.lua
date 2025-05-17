local ccc = require('ccc')

vim.opt.termguicolors = true

ccc.setup({
  highlighter = {
    auto_enable = true,
    lsp = true,
  },
})
