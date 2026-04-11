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
        formatters_by_ft = {
          lua = { 'stylua' },
          golang = { 'goimports', 'golangci-lint' },
        },
      })
    end,
    opts = {},
  },
}
