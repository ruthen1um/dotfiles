require("paq")({
  "savq/paq-nvim",

  --[[ ui ]]--
  "nvim-tree/nvim-web-devicons",
  "lukas-reineke/indent-blankline.nvim",
  "onsails/lspkind.nvim",
  { "catppuccin/nvim", as = "catppuccin" },
  "ellisonleao/gruvbox.nvim",

  --[[ syntax highlighting ]]--
  { "nvim-treesitter/nvim-treesitter", run = function() vim.cmd.TSUpdate() end },

  --[[ lsp ]]--
  "neovim/nvim-lspconfig",

  --[[ completion ]]--
  "hrsh7th/nvim-cmp",
  "windwp/nvim-autopairs",
  "kylechui/nvim-surround",

  --[[ completion sources ]]--
  "hrsh7th/cmp-nvim-lsp-signature-help",
  "amarakon/nvim-cmp-buffer-lines",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-nvim-lua",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-omni",
  "dcampos/cmp-snippy",
  "dcampos/nvim-snippy",
  "honza/vim-snippets",

  --[[ conviniency ]]
  "numToStr/Comment.nvim",
  "norcalli/nvim-colorizer.lua",

  "lervag/vimtex",
  "scalameta/nvim-metals",

  "nvim-lua/plenary.nvim",
  "dstein64/vim-startuptime",
})
