--[[ installed servers ]]--
--  nvim-metals
--  asm_lsp
--  bashls
--  ccls
--  pyright
--  lua_ls
--  texlab

local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local on_attach = function(_, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }

  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<F3>", vim.lsp.buf.code_action, opts)

end

local metals_config = require("metals").bare_config()

metals_config.settings = {
  showImplicitArguments = true,
  showImplicitConversionsAndClasses = true,
  showInferredType = true,
  enableSemanticHighlighting = true,
}

metals_config.init_options.statusBarProvider = "on"
metals_config.capabilities = capabilities
metals_config.on_attach = on_attach

local metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "scala", "sbt" },
  callback = function()
    vim.opt.indentexpr = "nvim_treesitter#indent()"
    require("metals").initialize_or_attach(metals_config)
  end,
  group = metals_group,
})

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
      },
    },
  },
})

lspconfig["pyright"].setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

lspconfig["ccls"].setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

lspconfig["asm_lsp"].setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

lspconfig["texlab"].setup({
  on_attach = on_attach,
  capabilities = capabilities,
})
