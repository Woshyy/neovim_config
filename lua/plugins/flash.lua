return {
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    keys = {
      { "r",     mode = "o",          function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },      function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
    config = function(_, opts)
      local flash = require("flash")
      flash.setup(opts)

      vim.keymap.set({ "n", "x", "o" }, "f", function()
        flash.jump()
      end, { noremap = true, silent = true })

      vim.keymap.set({ "n", "x", "o" }, "F", function()
        flash.treesitter()
      end, { noremap = true, silent = true })
    end,
  },
}
