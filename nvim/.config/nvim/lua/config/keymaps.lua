-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- use jk to exit insert mode
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode" })

-- use oil.nvim instead of the snacks explorer for <leader>e
vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>", { desc = "Open oil" })

-- use fff.nvim instead of the snacks smart picker for <leader><space>
vim.keymap.set("n", "<leader><space>", function()
  require("fff").find_files()
end, { desc = "Find files (fff)" })

-- remove LazyVim's buffer-navigation / buffer-management keymaps
local function unmap(mode, lhs)
  if vim.fn.maparg(lhs, mode) ~= "" then
    vim.keymap.del(mode, lhs)
  end
end
unmap("n", "<S-h>") -- prev buffer
unmap("n", "<S-l>") -- next buffer
unmap("n", "<leader>bb") -- switch to other buffer
unmap("n", "<leader>bd") -- delete buffer
unmap("n", "<leader>bo") -- delete other buffers
unmap("n", "<leader>bi") -- delete invisible buffers
unmap("n", "<leader>bD") -- delete buffer and window

-- [b / ]b come from neovim core defaults, which are applied after user config,
-- so remove them on VimEnter
vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    unmap("n", "[b")
    unmap("n", "]b")
  end,
})
