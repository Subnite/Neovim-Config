vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

return {
  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
      'folke/neodev.nvim',
      'Hoffs/omnisharp-extended-lsp.nvim', -- for omnisharp
    },
  },

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
  },

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim', opts = {} },

  -- Adds git related signs to the gutter, as well as utilities for managing changes
  'lewis6991/gitsigns.nvim',

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = false,
        component_separators = '|',
        section_separators = '',
      },
    },
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },

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
    priority = 999,
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
    priority = 999,
    config = function ()
      -- vim.cmd.colorscheme 'cyberdream'
    end,
  },

  {
    'tribela/transparent.nvim',
    event = 'VimEnter',
    priority = 1000,
    --[[ config = true, ]]
    opts = {
      auto = true, -- Automatically applies transparent
      extra_groups = { 'StatusLine'}, -- If you want to add some groups to be transparent. eg: { 'Pmenu', 'CocFloating' }
      excludes = {}, -- If you want to excludes from default transparent groups. eg: { 'LineNr' }
    },
    config = function()
      -- vim.cmd[[TransparentToggle]]
      -- vim.cmd[[TransparentEnable]]
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
    -- config = function()
    --   require("chatgpt").setup()
    -- end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim", -- optional
      "nvim-telescope/telescope.nvim"
    }
  },

  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('dashboard').setup {
        -- config
        hide = {
          "tabline",
        },
      }
    end,
    dependencies = { {'nvim-tree/nvim-web-devicons'}}
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    priority = 1000,
    event = 'VimEnter',
    lazy = false,
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    -- opts = {},
    dependencies = {
      "HiPhish/rainbow-delimiters.nvim"
    },
  },

  {
    'brianhuster/live-preview.nvim',
      dependencies = {
          -- You can choose one of the following pickers
          'nvim-telescope/telescope.nvim',
          -- 'ibhagwan/fzf-lua',
          -- 'echasnovski/mini.pick',
      },
  },
}
