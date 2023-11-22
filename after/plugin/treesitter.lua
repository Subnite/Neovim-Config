require 'nvim-treesitter.install'.prefer_git = false
require 'nvim-treesitter.install'.compilers = { "gcc", "clang" }

 require'nvim-treesitter.configs'.setup {
     ensure_installed = {"cpp", "lua", "xml", "markdown", "cmake", "gitignore", "c", "c_sharp"},
     sync_install = false,
     auto_install = true,
     ignore_install = { },

     highlight = {
       enable = true,
       disable = { },
       additional_vim_regex_highlighting = false,
     },
 }

print("treesitter setup done")
