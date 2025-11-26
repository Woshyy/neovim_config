-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

map("n", "<leader>L", "<cmd>Lazy<cr>", { desc = "Open Lazy.nvim" })

map("n", "<space>fD", function()
  local buf = vim.api.nvim_buf_get_name(0)
  if buf == "" then
    vim.notify("No filename for current buffer", vim.log.levels.WARN)
    return
  end

  local tail = vim.fn.fnamemodify(buf, ":t")
  local encoded = buf:gsub("[/\\]", "%%")   -- Neovim-encoded full path

  local roots = {}
  for _, d in ipairs(vim.split(vim.o.directory, ",", { trimempty = true })) do
    table.insert(roots, vim.fn.expand(d))
  end
  table.insert(roots, ".")
  table.insert(roots, "/tmp")

  local deleted = {}
  for _, root in ipairs(roots) do
    for _, pat in ipairs({ "*.sw?", "**/*.sw?" }) do
      for _, p in ipairs(vim.fn.globpath(root, pat, true, true)) do
        if p:find(tail, 1, true) or p:find(encoded, 1, true) then
          if vim.fn.delete(p) == 0 then
            table.insert(deleted, p)
          end
        end
      end
    end
  end

  if #deleted > 0 then
    vim.notify("Deleted " .. #deleted .. " swap file(s)", vim.log.levels.INFO)
  else
    vim.notify("No swap file found for current buffer", vim.log.levels.WARN)
  end
end, { desc = "Delete swap file(s) for current buffer" })

map("n", "<leader>fs", "<cmd>write<CR>", {desc="Save file"})
