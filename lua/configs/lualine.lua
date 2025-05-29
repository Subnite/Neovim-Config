-- Bubbles config for lualine
-- Author: lokesh-krishna
-- MIT license, see LICENSE for more details.

-- stylua: ignore
local colors = {
  blue   = '#80a0ff',
  cyan   = '#79dac8',
  black  = '#080808',
  white  = '#c6c6c6',
  red    = '#ff5189',
  violet = '#d183e8',
  grey   = '#303030',
}

local bubbles_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.violet },
    b = { fg = colors.white, bg = colors.grey },
    c = { fg = colors.white },
  },

  insert = { a = { fg = colors.black, bg = colors.blue } },
  visual = { a = { fg = colors.black, bg = colors.cyan } },
  replace = { a = { fg = colors.black, bg = colors.red } },

  inactive = {
    a = { fg = colors.white, bg = colors.black },
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.white },
  },
}

require('lualine').setup {
  options = {
    theme = bubbles_theme,
    component_separators = '',
    section_separators = { left = '', right = '' },
    winbar_separators = { left = '', right = '' },
    disabled_filetypes = { statusline = { "dashboard" } },
  },
  sections = {
    lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
    lualine_b = { 'filename', 'branch' },
    lualine_c = {},
    lualine_x = {},
    lualine_y = { 'filetype', 'progress' },
    lualine_z = {
      { 'location', separator = { right = '' }, left_padding = 2 },
    },
  },
  inactive_sections = {
    lualine_a = { 'filename' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'location' },
  },
  winbar = {
    lualine_a = { { "os.date('%H:%M:%S')", separator = { left = ''}, right_padding = 2 }  },
    lualine_b = { 'progress', 'diagnostics', 'lsp_status' },
    lualine_c = {
      {
        function ()
          return require("nvim-navic").get_location()
        end,
        cond = function ()
          return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
        end
      }
    },
  },
  inactive_winbar = {
    lualine_a = { 'filename' },
  },
  tabline = {},
  extensions = { 'neo-tree', 'lazy', 'nvim-dap-ui', 'quickfix' },
  refresh = {
    statusline = 200,
    tabline = 200,
    winbar = 200,
  },
}
