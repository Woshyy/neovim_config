return {
  { "williamboman/mason.nvim", config = true },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = { "gopls", "lua_ls", "rust_analyzer" }, -- add more if you like
      automatic_installation = true,
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "gofumpt",
        "goimports",
        "golangci-lint",
        "delve",
      },
      auto_update = false,
      run_on_start = true,
    },
  },
}

