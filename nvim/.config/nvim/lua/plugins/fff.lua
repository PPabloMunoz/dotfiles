return {
  {
    "dmtrKovalenko/fff",
    -- downloads a prebuilt binary, falls back to cargo build
    build = function()
      require("fff.download").download_or_build_binary()
    end,
    lazy = false, -- the plugin lazy-initialises itself
    opts = {},
  },
}
