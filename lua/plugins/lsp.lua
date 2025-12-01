return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },

    opts = {
      servers = {
        gopls = {
          settings = {
            gopls = {
              analyses = { unusedparams = true, shadow = true },
              staticcheck = true,
              gofumpt = true,
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                parameterTypes = true,
                rangeVariableTypes = true,
              }
            },
          },
        },

        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              cargo = { allFeatures = true },
              checkOnSave = { command = "clippy" },
              inlayHints = {
                enable = true,
                typeHints = true,
                parameterHints = true,
                chainingHints = true,
              }
            },
          },
        },

        lua_ls = {
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
              workspace = { checkThirdParty = false },
            },
          },
        },
      },
    },

    config = function(_, opts)
      -- Pretty hover
      vim.lsp.handlers["textDocument/hover"] =
          vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

      -- Keymaps + semantic tokens on LSP attach (guard client_id!)
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspKeymaps", { clear = true }),
        callback = function(args)
          local bufnr = args.buf
          local cid = args.data and args.data.client_id
          local client = cid and vim.lsp.get_client_by_id(cid)
          if not client then return end

          local map = function(m, lhs, rhs, desc)
            vim.keymap.set(m, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
          end
          map("n", "<leader>ci", vim.lsp.buf.hover, "Hover Info")
          vim.api.nvim_set_keymap("n", "ce", "<cmd>lua vim.diagnostic.open_float()<CR>",
            { noremap = true, silent = true })
          map("n", "<leader>cd", vim.lsp.buf.definition, "Go to Definition")
          map("n", "<leader>cr", vim.lsp.buf.references, "References")
          map("n", "<leader>cc", vim.lsp.buf.rename, "Rename")
          map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
          map("n", "[d", vim.diagnostic.goto_prev, "Prev Diagnostic")
          map("n", "]d", vim.diagnostic.goto_next, "Next Diagnostic")
          map("n", "<leader>i", function()
            local enabled = vim.lsp.inlay_hint.is_enabled()
            vim.lsp.inlay_hint.enable(not enabled)
          end, "Toggle inlay hints")

          if client.server_capabilities.semanticTokensProvider then
            vim.lsp.semantic_tokens.start(bufnr, client.id)
          end
        end,
      })

      -- Mason (installers)
      local ok_mason, mason = pcall(require, "mason")
      if ok_mason then mason.setup() end

      local ok_mason_lsp, mason_lsp = pcall(require, "mason-lspconfig")
      if ok_mason_lsp then
        mason_lsp.setup({
          ensure_installed = vim.tbl_keys(opts.servers or {}),
          automatic_installation = false,
        })
      end

      -- Register + enable each server (Neovim 0.11+ API)
      for name, cfg in pairs(opts.servers or {}) do
        vim.lsp.config(name, cfg)
      end
      for name, _ in pairs(opts.servers or {}) do
        vim.lsp.enable(name) -- explicit per-server enable (works on 0.11.4)
      end
    end,
  },
}
