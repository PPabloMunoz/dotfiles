-- Formatting with conform.nvim

return {
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format({ async = true, lsp_format = 'fallback' })
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    config = function()
      require('conform').setup({
        notify_on_error = true,
        notify_no_formatters = true,
        format_on_save = { timeout_ms = 500, lsp_format = 'fallback' },
        formatters_by_ft = {
          lua = { 'stylua' },
          go = { 'goimports', 'gofumpt' },
          javascript = { 'oxlint', 'oxfmt' },
          typescript = { 'oxlint', 'oxfmt' },
          javascriptreact = { 'oxlint', 'oxfmt' },
          typescriptreact = { 'oxlint', 'oxfmt' },
          astro = { 'oxlint', 'oxfmt' },
        },
      })
    end,
    opts = {},
  },
}
