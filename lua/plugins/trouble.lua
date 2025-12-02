return {
  "folke/trouble.nvim",
  cmd = "Trouble",
  opts = {}, -- for default options, refer to the configuration section for custom setup.
  lazy = true,
  specs = {
    "folke/snacks.nvim",
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts or {}, {
        picker = {
          actions = require("trouble.sources.snacks").actions,
          win = {
            input = {
              keys = {
                ["<c-t>"] = {
                  "trouble_open",
                  mode = { "n", "i" },
                },
              },
            },
          },
        },
      })
    end,
  },
  keys = {
    {
      "<leader>ce",
      "<cmd>Trouble diagnostics toggle focus=true<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<leader>xX",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Buffer Diagnostics (Trouble)",
    },
    {
      "<leader>cs",
      "<cmd>Trouble symbols toggle focus=false<cr>",
      desc = "Symbols (Trouble)",
    },
    {
      "<leader>cl",
      "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
      desc = "LSP Definitions / references / ... (Trouble)",
    },
    {
      "<leader>xL",
      "<cmd>Trouble loclist toggle<cr>",
      desc = "Location List (Trouble)",
    },
    {
      "<leader>xQ",
      "<cmd>Trouble qflist toggle<cr>",
      desc = "Quickfix List (Trouble)",
    },
  },
  config = function()
    require("trouble").setup({
      -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
      mode = "workspace_diagnostics",
      padding = false,
      win = {
        type = "float",      -- <─ make it a floating window
        relative = "editor", -- or "win" if you want it relative to the current window
        border = "rounded",  -- "single", "double", "none", etc
        position = "bottom", -- or "top", "left", "right", "bottomright", ...
        size = {             -- can be absolute or 0–1 for percentage
          width = 0.6,
          height = 0.3,
        },
      },
      action_keys = {
        -- key mappings for actions in the trouble list
        close = "q",               -- close the list
        cancel = "<esc>",          -- cancel the preview and get back to your last window / buffer / cursor
        refresh = "r",             -- manually refresh
        jump = { "<tab>" },        -- jump to the diagnostic or open / close folds
        open_split = { "<c-x>" },  -- open buffer in new split
        open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
        open_tab = { "<c-t>" },    -- open buffer in new tab
        jump_close = { "<cr>" },   -- jump to the diagnostic and close the list
        toggle_mode = "m",         -- toggle between "workspace" and "document" diagnostics mode
        toggle_preview = "P",      -- toggle auto_preview
        hover = "K",               -- opens a small popup with the full multiline message
        preview = "p",             -- preview the diagnostic location
        close_folds = { "zM" },    -- close all folds
        open_folds = { "zR" },     -- open all folds
        toggle_fold = { "za" },    -- toggle fold of current file
      },
      auto_jump = {},
      use_diagnostic_signs = true,
    })
  end,
}
