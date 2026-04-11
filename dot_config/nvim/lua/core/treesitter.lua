-- Enable Tree-sitter
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    local ok, _ = pcall(vim.treesitter.start)
    if not ok then
      -- No parser available for this filetype, silently skip
    end
  end,
})
