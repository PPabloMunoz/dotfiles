-- Enable Tree-sitter
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'typescript', 'tsx', 'go', 'bash' },
  callback = function(args)
    local lang = vim.bo[args.buf].filetype
    local ok, err = pcall(vim.treesitter.start, args.buf, lang)
    if not ok then
      vim.notify('Tree-sitter failed to start for ' .. lang .. ': ' .. err, vim.log.levels.ERROR)
    end
  end,
})
