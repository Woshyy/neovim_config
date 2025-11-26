return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = {
    ensure_installed = { "lua", "go", "rust", "typescript", "tsx", "javascript", "vim", "vimdoc", "query" },
    highlight = { enable = true },
  },
  config = function(_, opts) require("nvim-treesitter.configs").setup(opts) end,
}
