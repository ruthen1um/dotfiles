return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "LspInfo", "LspInstall", "LspUninstall" },
  config = function()
    local lspconfig = require("lspconfig")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    require("lsp_signature").setup({
      hint_enable = false,
    })

    local on_attach = function(_, bufnr)
      local opts = { noremap = true, buffer = bufnr }

      vim.keymap.set("n", "gd", vim.lsp.buf.declaration, opts)
      vim.keymap.set("n", "<C-]>", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
      vim.keymap.set("n", "<F3>", vim.lsp.buf.code_action, opts)
      vim.keymap.set("n", "<F4>", vim.lsp.buf.format, opts)
      vim.keymap.set("n", "dp", vim.diagnostic.goto_prev, opts)
      vim.keymap.set("n", "dn", vim.diagnostic.goto_next, opts)
    end

    vim.diagnostic.config({ update_in_insert = true, virtual_text = false, signs = false })

    lspconfig["lua_ls"].setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          completion = {
            showWord = "Disable",
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
        },
      },
    })

    lspconfig["pylsp"].setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })

    lspconfig["clangd"].setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })

    lspconfig["jdtls"].setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
  end
}

