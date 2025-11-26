return {
  {
    "stevearc/aerial.nvim",
    config = function()
      require("aerial").setup({
        backends = { "lsp" },
        manage_folds = false,
        open_automatic = false,
        close_automatic_events = {},
        nav = {
          keymaps = {
            ["q"] = "actions.close",
          },
        }
      })

      vim.keymap.set("n", "<leader>ff", function()
        require("aerial").nav_toggle()
      end, { desc = "Aerial navigation popup" })
    end,
  },
}
