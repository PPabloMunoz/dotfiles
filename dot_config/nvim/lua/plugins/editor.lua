-- Editor enhancements

return {
  -- Treesitter for syntax highlighting
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'diff',
        'html',
        'lua',
        'luadoc',
        'vim',
        'vimdoc',
        'typescript',
        'tsx',
        'go',
        'cmake',
        'javascript',
        'json5',
        'toml',
        'java',
      },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    },
    config = function(_, opts)
      require('nvim-treesitter').setup(opts)
    end,
  },

  -- Guess indentation style
  'NMAC427/guess-indent.nvim',
}
