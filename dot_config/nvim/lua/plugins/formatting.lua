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
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = true,
      format_on_save = function(bufnr)
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        elseif vim.bo[bufnr].filetype == 'java' then
          return {
            timeout_ms = 500,
            lsp_format = 'prefer', -- use jdtls for Java
          }
        else
          return {
            timeout_ms = 500,
            lsp_format = 'never',
          }
        end
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        golang = { 'goimports', 'gofumpt' },
        javascript = { 'biome' },
        javascriptreact = { 'biome' },
        typescript = { 'biome' },
        typescriptreact = { 'biome' },
        json = { 'biome' },
        jsonc = { 'biome' },
        java = {}, -- uses jdtls LSP formatting
      },
    },
  },
}
