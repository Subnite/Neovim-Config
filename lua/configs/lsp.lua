-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
  nmap('<leader>ss', require('telescope.builtin').lsp_document_symbols, '[S]earch [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- document existing key chains
require('which-key').add ({
  {'<leader>c', group = '[C]ode' },
  {'<leader>c_', hidden = true },
  {'<leader>d', group = '[D]ebug'},
  {'<leader>d_', hidden = true },
  {'<leader>g', group = '[G]it'},
  {'<leader>g_', hidden = true },
  {'<leader>r', group = '[R]ename'},
  {'<leader>r_', hidden = true },
  {'<leader>s', group = '[S]earch'},
  {'<leader>s_', hidden = true },
  {'<leader>t', group = '[T]oggle'},
  {'<leader>t_', hidden = true },
  {'<leader>w', group = '[W]orkspace'},
  {'<leader>w_', hidden = true },
})


-- mason-lspconfig requires that these setup functions are called in this order
-- before setting up the servers.
require('mason').setup()
require('mason-lspconfig').setup()

-- Enable the following language servers
--  HACK: Update these as well
local servers = {
  clangd = {},                                          -- c, c++
  -- csharp_ls = {},                                       -- c# replaced by OmniSharp later
  rust_analyzer = {},                                   -- rust
  html = { filetypes = { 'html', 'twig', 'hbs'} },      -- html
  cmake = {},                                           -- cmake 
  cssls = {},                                           -- css
  jsonls = {},                                          -- json
  marksman = {},                                        -- markdown
  lemminx = {},                                         -- xml
  lua_ls = {                                            -- lua
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
      -- diagnostics = { disable = { 'missing-fields' } },
    },
  },
  hyprls = {},
  nil_ls = {}
  -- rnix_lsp = {},
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end,
}

-- specific attach for omnisharp
local on_attach_omnisharp = function(client, bufnr)
  on_attach(client, bufnr) -- the normal on attach function
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc') -- Omnicompletion
end

-- Omnisharp/C#/Unity
local pid = vim.fn.getpid()
local omnisharp_bin = vim.fn.stdpath "data" .. "/mason/packages/omnisharp/libexec/OmniSharp.exe"
require'lspconfig'.omnisharp.setup{
  on_attach = on_attach_omnisharp,
  flags = {
    debounce_text_changes = 150,
  },
  cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) },
  root_dir = function ()
    return vim.loop.cwd()
  end,
  enable_rosalyn_analyzers = true,
  enable_import_completion = true,
}
