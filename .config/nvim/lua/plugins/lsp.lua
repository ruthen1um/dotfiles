local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = false

local on_attach = function(_, bufnr)
  local opts = { noremap = true, buffer = bufnr }
  require("lsp_signature").on_attach({}, bufnr)

  vim.keymap.set("n", "gd", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "<C-]>", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "<Leader>gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<F3>", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<F4>", vim.lsp.buf.format, opts)
  vim.keymap.set("n", "<Leader>dp", vim.diagnostic.goto_prev, opts)
  vim.keymap.set("n", "<Leader>dn", vim.diagnostic.goto_next, opts)
  vim.keymap.set("n", "<Leader>dt", function() require("trouble").toggle("document_diagnostics") end, opts)
end

vim.diagnostic.config({ update_in_insert = true, virtual_text = false, signs = false })
-- local metals_config = require("metals").bare_config()

-- metals_config.settings = {
--   showImplicitArguments = true,
--   showImplicitConversionsAndClasses = true,
--   showInferredType = true,
--   enableSemanticHighlighting = true,
-- }
--
-- metals_config.init_options.statusBarProvider = "on"
-- metals_config.capabilities = capabilities
-- metals_config.on_attach = on_attach
--
-- local metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
--
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = { "scala", "sbt" },
--   callback = function()
--     vim.opt.indentexpr = "nvim_treesitter#indent()"
--     require("metals").initialize_or_attach(metals_config)
--   end,
--   group = metals_group,
-- })

lspconfig["lua_ls"].setup({
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { os.getenv("HOME") .. "/repo/lua-language-server/bin/lua-language-server" },
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

lspconfig["ccls"].setup({
  on_attach = on_attach,
  capabilities = capabilities,
  init_options = {
    compilationDatabaseDirectory = "build",
  },
})

lspconfig["texlab"].setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

lspconfig["cmake"].setup({
  on_attach = on_attach,
  capabilities = capabilities,
})
