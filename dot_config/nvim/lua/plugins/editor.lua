-- Editor enhancements

return {
  -- Treesitter for syntax highlighting
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      -- local tr = require('nvim-treesitter')
      -- tr.setup({
      --   auto_install = true,
      --   highlight = { enable = true },
      --   indent = { enable = true },
      -- })
      -- tr.install({ 'go', 'typescript' })
    end,
  },
}
