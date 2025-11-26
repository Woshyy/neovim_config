return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      cmdline = {
        enabled = true,
        view = "cmdline_popup", -- THIS is the centered floating command line
      },
      presets = {
        command_palette = true, -- also makes search (/) centered and prettier
        long_message_to_split = true,
      },
    },
  },
}

