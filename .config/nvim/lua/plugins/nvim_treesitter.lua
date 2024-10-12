return {
  "nvim-treesitter/nvim-treesitter",
  enable = false,
  build = ":TSUpdate",
  main = "nvim-treesitter.configs",
  opts = {
    highlight = { enable = true },
    indent = { enable = true },
    auto_install = false,
  }
}
