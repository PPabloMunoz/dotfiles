-- LSP Configuration

return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
      'saghen/blink.cmp',
      { 'folke/lazydev.nvim', opts = {} },
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end
          local tb = require('telescope.builtin')
          map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('grd', tb.lsp_definitions, '[G]oto [D]efinition')
          map('grr', tb.lsp_references, '[G]oto [R]eferences')
          map('gri', tb.lsp_implementations, '[G]oto [I]mplementation')
          -- map('gO', tb.lsp_document_symbols, 'Open Document Symbols')
          -- map('gW', tb.lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')
          -- map('grt', tb.lsp_type_definitions, '[G]oto [T]ype Definition')
          -- map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
          -- map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        end,
      })

      vim.diagnostic.config({
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        virtual_text = { source = 'if_many', spacing = 2 },
      })

      local capabilities = require('blink.cmp').get_lsp_capabilities()

      require('mason-tool-installer').setup({
        ensure_installed = { 'stylua', 'lua_ls', 'gopls', 'goimports', 'golangci-lint', 'gofumpt' },
      })

      require('mason-lspconfig').setup({
        ensure_installed = {},
        automatic_installation = false,
        handlers = {
          function(server_name)
            require('lspconfig')[server_name].setup({ capabilities = capabilities })
          end,
        },
      })
    end,
  },
}
