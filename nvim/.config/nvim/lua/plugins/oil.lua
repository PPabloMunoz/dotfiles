return {
  {
    "stevearc/oil.nvim",
    -- oil manages its own buffers, load it eagerly
    lazy = false,
    dependencies = { "nvim-mini/mini.icons" }, -- already shipped with LazyVim
    keys = {
      { "-", "<CMD>Oil<CR>", desc = "Open parent directory (oil)" },
      { "<leader>e", "<CMD>Oil<CR>", desc = "Open oil" },
    },
    opts = {
      view_options = {
        show_hidden = true,
      },
    },
  },

  -- disable LazyVim's default file explorer (snacks.nvim)
  { "folke/snacks.nvim", opts = { explorer = { enabled = false } } },
}
