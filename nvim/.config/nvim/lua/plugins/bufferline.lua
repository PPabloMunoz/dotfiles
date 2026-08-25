return {
  -- disable bufferline.nvim (the tab bar at the top)
  { "akinsho/bufferline.nvim", enabled = false },

  -- disable the snacks buffer-picker keymaps
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>,", false },
      { "<leader>fb", false },
      { "<leader>fB", false },
    },
  },
}
