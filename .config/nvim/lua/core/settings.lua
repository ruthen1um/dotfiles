vim.opt.termguicolors = true

-- line number
vim.opt.number = false
vim.opt.relativenumber = true

-- tabs
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- indentation
-- vim.opt.smartindent = true
vim.opt.autoindent = true

-- search
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.list = true -- show hidden chars
vim.opt.mouse = nil -- true vim user (disable mouse)

-- completion window
vim.opt.pumheight = 20
vim.opt.pumwidth = 20

vim.opt.updatetime = 750 -- some recommended value
vim.opt.timeoutlen = 300
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.wrapscan = false
vim.opt.spell = false
vim.opt.spelllang = { 'en_us', 'ru' }
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 16
vim.opt.equalalways = true
vim.opt.clipboard = "unnamed"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false
vim.opt.foldminlines = 5
vim.opt.foldnestmax = 5
vim.opt.laststatus = 3
vim.opt.showtabline = 0
vim.opt.completeopt = "menu,preview,menuone,noselect"
vim.opt.backup = true

vim.opt.shortmess = {
  a = true,
  o = true,
  O = true,
  t = true,
  I = true,
  c = true,
}

vim.opt.fillchars = {
  horiz     = '━',
  horizup   = '┻',
  horizdown = '┳',
  vert      = '┃',
  vertleft  = '┫',
  vertright = '┣',
  verthoriz = '╋',
}

vim.opt.listchars = {
  tab   = "··",
  trail = "·",
}

vim.g.mapleader = [[\]]
-- vim.g.python3_host_prog = "/usr/bin/python3"
-- vim.api.nvim_set_hl(0, "FloatBorder", { fg = "" })
