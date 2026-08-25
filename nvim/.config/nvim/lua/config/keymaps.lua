-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- use oil.nvim instead of the snacks explorer for <leader>e
vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>", { desc = "Open oil" })

-- use fff.nvim instead of the snacks smart picker for <leader><space>
vim.keymap.set("n", "<leader><space>", function()
  require("fff").find_files()
end, { desc = "Find files (fff)" })
