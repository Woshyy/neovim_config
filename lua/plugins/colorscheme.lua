return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      integrations = {
        treesitter = true,
        semantic_tokens = true,      -- << enable this
        mason = true,
        native_lsp = {
          enabled = true,
          -- (optional) style tweaks for diagnostics & underlines:
          -- virtual_text = { errors = { "italic" }, hints = { "italic" }, warnings = { "italic" }, information = { "italic" } },
          -- underlines   = { errors = { "underline" }, hints = { "underline" }, warnings = { "underline" }, information = { "underline" } },
        },
      },
    })
    vim.cmd.colorscheme("catppuccin")
  end,
}
