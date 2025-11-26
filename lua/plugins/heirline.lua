return {
  "rebelot/heirline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },

  config = function()
    local conditions = require("heirline.conditions")
    local utils = require("heirline.utils")

    -- Colors will adapt to your colorscheme
    local theme = {
      normal  = { fg = utils.get_highlight("StatusLine").fg,  bg = utils.get_highlight("StatusLine").bg },
      insert  = { fg = utils.get_highlight("String").fg,      bg = utils.get_highlight("StatusLine").bg },
      visual  = { fg = utils.get_highlight("Type").fg,        bg = utils.get_highlight("StatusLine").bg },
      replace = { fg = utils.get_highlight("Constant").fg,    bg = utils.get_highlight("StatusLine").bg },
      command = { fg = utils.get_highlight("Statement").fg,   bg = utils.get_highlight("StatusLine").bg },
      inactive = { fg = utils.get_highlight("Comment").fg,    bg = utils.get_highlight("StatusLine").bg },
    }

    -- ========= COMPONENTS ==========

    local ViMode = {
      init = function(self) self.mode = vim.fn.mode(1) end,
      provider = function(self) return " " .. self.mode:sub(1, 1):upper() .. " " end,
      hl = function(self)
        if self.mode:match("i") then return theme.insert end
        if self.mode:match("v") then return theme.visual end
        if self.mode:match("r") then return theme.replace end
        if self.mode:match("c") then return theme.command end
        return theme.normal
      end,
    }

    local FileName = {
      provider = function() return "  " .. vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t") .. " " end,
      hl = theme.normal,
    }

    local Diagnostics = {
      condition = conditions.has_diagnostics,
      provider = function()
        local icons = { Error = " ", Warn = " ", Hint = " ", Info = " " }
        local result = ""
        for name, icon in pairs(icons) do
          local count = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity[name:upper()] })
          if count > 0 then result = result .. icon .. count .. " " end
        end
        return (#result > 0) and (" " .. result .. " ") or ""
      end,
      hl = theme.normal,
    }

    local Git = {
      condition = conditions.is_git_repo,
      provider = function()
        local g = vim.b.gitsigns_status_dict
        return g and ("  " .. g.head .. " ") or ""
      end,
      hl = theme.normal,
    }

    local Ruler = {
      provider = function() return " %l:%c " end,
      hl = theme.normal,
    }

    -- ========= LAYOUT ==========
    require("heirline").setup({
      statusline = {
        ViMode, FileName, Git,
        { provider = "%=" }, -- center separator
        Diagnostics, Ruler,
      },
    })
  end,
}
