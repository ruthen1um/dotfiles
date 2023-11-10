require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "c",
    "lua",
    "python",
    "comment",
    "make",
  },
  auto_install = false,
  highlight = { enable = true },
  indent = { enable = true },
})
