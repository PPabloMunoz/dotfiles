-- Autocompletion with blink.cmp

return {
  {
    'saghen/blink.cmp',
    version = '1.*',
    dependencies = { 'folke/lazydev.nvim' },

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = { preset = 'default' },
      appearance = { nerd_font_variant = 'mono' },
      completion = { documentation = { auto_show = false }, ghost_text = { enabled = true } },
      sources = { default = { 'lsp', 'path' } },
      fuzzy = { implementation = 'prefer_rust_with_warning' },
      signature = { enabled = true },
    },
  },
}
