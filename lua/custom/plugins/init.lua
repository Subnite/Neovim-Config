-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
-- TODO somethin
return {
  -- Colorscheme Kanagawa Theme
  -- {
  --   'rebelot/kanagawa.nvim',
  --   priority = 1000,
  --   config = function()
  --     vim.cmd.colorscheme 'kanagawa-wave'
  --   end,
  --   transparent = true,
  -- },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'tokyonight'
      --
      -- -- NOTE: don't enable these
      -- vim.cmd[[highlight Normal ctermbg=0 guibg=0]]
      -- vim.cmd[[highlight NonText ctermbg=0 guibg=0]]
      -- vim.cmd[[highlight SignColumn ctermbg=0 guibg=0]]
      --
      -- vim.cmd[[highlight TelescopeNormal ctermbg=0 guibg=0]]
      -- vim.cmd[[highlight TelescopePreviewNormal ctermbg=0 guibg=0]]
      -- vim.cmd[[highlight TelescopeResultsNormal ctermbg=0 guibg=0]]
      -- vim.cmd[[highlight TelescopePromptNormal ctermbg=0 guibg=0]]
    end,

  },

  {
    "scottmckendry/cyberdream.nvim",
    lazy = true,
    priority = 1000,
    config = function ()
      -- vim.cmd.colorscheme 'cyberdream'
    end,
  },

  {
    'tribela/transparent.nvim',
    event = 'VimEnter',
    --[[ config = true, ]]
    opts = {
      auto = true, -- Automatically applies transparent
      extra_groups = { 'StatusLine'}, -- If you want to add some groups to be transparent. eg: { 'Pmenu', 'CocFloating' }
      excludes = {}, -- If you want to excludes from default transparent groups. eg: { 'LineNr' }
    },
    config = function()
      vim.cmd[[TransparentToggle]]
      vim.cmd[[TransparentEnable]]
    end,

  },


  -- file browser
  {
    "nvim-neo-tree/neo-tree.nvim",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
  },

  -- NOTE: this is for all the comment colors for note, fix, ...
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },


  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  {
    "mfussenegger/nvim-dap"
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio", "theHamsta/nvim-dap-virtual-text" },
  },

  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
    opts = {
      handlers = {},
      ensure_installed = { "codelldb", "cpptools" }
    },
  },

  {
  "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    config = function()
      require("chatgpt").setup()
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim", -- optional
      "nvim-telescope/telescope.nvim"
    }
  },
}
