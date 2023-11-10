local opt = vim.opt

opt.number = true
opt.softtabstop = 4
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.ignorecase = true
opt.termguicolors = true
opt.list = true
opt.mouse = "a"
opt.pumheight = 10
opt.smartcase = true
opt.updatetime = 300
opt.timeoutlen = 300
opt.cursorline = true
opt.wrap = false
opt.spell = false
opt.wrapscan = false
opt.scrolloff = 4
opt.sidescrolloff = 8
opt.equalalways = true
opt.clipboard = "unnamedplus"
opt.splitbelow = true
opt.splitright = true
opt.swapfile = false
opt.undofile = true
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldenable = false
opt.foldminlines = 5
opt.foldnestmax = 5
opt.laststatus = 3
opt.showtabline = 2
opt.completeopt = "menu,preview,menuone,noselect"
opt.textwidth = 79

opt.shortmess = {
  a = true,
  o = true,
  O = true,
  t = true,
  I = true,
  c = true,
}

opt.fillchars = {
  horiz     = '━',
  horizup   = '┻',
  horizdown = '┳',
  vert      = '┃',
  vertleft  = '┫',
  vertright = '┣',
  verthoriz = '╋',
}

opt.listchars = {
  tab   = "··",
  trail = "·",
}

vim.cmd.colorscheme("catppuccin-mocha")
vim.g.mapleader = [[\]]
vim.g.python_host_skip_check = 1
vim.loader.enable()
