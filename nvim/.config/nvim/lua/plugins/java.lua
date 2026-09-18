return {
  {
    "mfussenegger/nvim-jdtls",
    opts = function(_, opts)
      local lombok = vim.fn.expand("~/.local/share/nvim/mason/share/jdtls/lombok.jar")

      -- Prefer Mason's jdtls if it exists
      local mason_jdtls = vim.fn.expand("~/.local/share/nvim/mason/bin/jdtls")
      local cmd = vim.fn.executable(mason_jdtls) == 1 and mason_jdtls or "jdtls"

      opts.cmd = {
        cmd,
        "--jvm-arg=-javaagent:" .. lombok,
      }

      return opts
    end,
  },
}
