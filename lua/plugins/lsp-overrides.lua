-- Performance optimizations for LSP
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Disable marksman - extremely slow in large files
        marksman = {
          enabled = false,
        },
      },
    },
  },
  -- Add LSP timeout to prevent slow servers from blocking
  {
    "hinell/lsp-timeout.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    opts = {
      -- Timeout for LSP requests in milliseconds
      timeout_ms = 1000,
      -- Stop blocking requests after timeout
      stop_on_timeout = true,
    },
  },
}
