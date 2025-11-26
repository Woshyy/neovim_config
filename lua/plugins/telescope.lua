return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      local tb = require("telescope.builtin")
      local map = vim.keymap.set
      map("n", "<leader><leader>", tb.find_files)
      map("n", "<leader>fj", tb.lsp_document_symbols)
      map("n", "<leader>en", function()
        tb.find_files({
          cwd = vim.fn.stdpath("config"),
        })
      end
      )
      vim.keymap.set("n", "<space>fb", function()
        tb.buffers({ sort_mru = true, ignore_current_buffer = true })
      end, { desc = "Telescope: buffers (open files)" })
    end,
  },
}
