return {
  {
    'olexsmir/gopher.nvim',
    ft = 'go',
    -- branch = "develop"
    -- (optional) updates the plugin's dependencies on each update
    build = function()
      vim.cmd.GoInstallDeps()
    end,
    opts = {},
    keys = {
      -- Struct tags
      { '<leader>gtj', '<cmd>GoTagAdd json<CR>', desc = 'Add json tags' },
      { '<leader>gty', '<cmd>GoTagAdd yaml<CR>', desc = 'Add yaml tags' },
      { '<leader>gtr', '<cmd>GoTagRm json<CR>', desc = 'Remove json tags' },

      -- Add if err
      { '<leader>gie', '<cmd>GoIfErr<CR>', desc = 'Add if err block' },
    },
  },
}
