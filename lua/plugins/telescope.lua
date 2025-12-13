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

      local function home(path)
        return vim.fn.expand("~/" .. path)
      end

      local note_dirs = {
        home("OneDrive - Axis Communications AB/Notes")
      }

      local function search_notes()
        for _, dir in pairs(note_dirs) do
          if vim.fn.isdirectory(dir) == 1 then
            tb.find_files({ cwd = dir })
            return
          end
        end

        print("No note directory found.")
      end

      map("n", "<leader><leader>", tb.find_files)
      map("n", "<leader>fj", tb.lsp_document_symbols)
      map("n", "<leader>en", function()
        tb.find_files({
          cwd = vim.fn.stdpath("config"),
        })
      end
      )
      map("n", "<leader>eb", search_notes)
      vim.keymap.set("n", "<space>fb", function()
        tb.buffers({ sort_mru = true, ignore_current_buffer = true })
      end, { desc = "Telescope: buffers (open files)" })
    end,
  },
}
