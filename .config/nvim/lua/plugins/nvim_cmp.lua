local kind_icons = {
  Text = "󰉿 ",
  Method = "󰆧 ",
  Function = "󰊕 ",
  Constructor = " ",
  Field = "󰜢 ",
  Variable = "󰀫 ",
  Class = "󰠱 ",
  Interface = " ",
  Module = " ",
  Property = "󰜢 ",
  Unit = " ",
  Value = "󰎠 ",
  Enum = " ",
  Keyword = "󰌋 ",
  Snippet = " ",
  Color = "󰏘 ",
  File = "󰈙 ",
  Reference = "󰈇 ",
  Folder = "󰉋 ",
  EnumMember = " ",
  Constant = "󰏿 ",
  Struct = "󰙅 ",
  Event = " ",
  Operator = "󰆕 ",
  TypeParameter = "󰅲 ",
}

return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
      build = "make install_jsregexp"
    },
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "ray-x/lsp_signature.nvim",
  },
  event = { "InsertEnter", "CmdlineEnter" },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    local config = {}

    config.sources = {
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "path" },
    }

    config.window = {
      completion = cmp.config.window.bordered({ scrollbar = false, winhighlight = "Search:None" }),
      documentation = cmp.config.window.bordered({ scrollbar = false, winhighlight = "Search:None" }),
    }

    config.snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end
    }

    config.formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
        vim_item.menu = ({
          nvim_lsp = "[LSP]",
          path = "[Path]",
          luasnip = "[LuaSnip]",
        })[entry.source.name]
        vim_item.abbr = string.sub(vim_item.abbr, 1, 50)
        vim_item.kind = kind_icons[vim_item.kind]
        return vim_item
      end,
    }

    config.mapping = {
      ["<C-b>"] = cmp.mapping.scroll_docs(-1),

      ["<C-f>"] = cmp.mapping.scroll_docs(1),

      ["<C-Space>"] = cmp.mapping.complete(),

      ["<C-e>"] = cmp.mapping.abort(),

      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        elseif luasnip.locally_jumpable(1) then
          luasnip.jump(1)
        -- elseif not luasnip.in_snippet() then
        else
          fallback()
        end
      end, { "i", "s" }),

      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
        elseif luasnip.locally_jumpable(-1) then
          luasnip.jump(-1)
        -- elseif not luasnip.in_snippet() then
        else
          fallback()
        end
      end, { "i", "s" }),

      ["<CR>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert })
        else
          fallback()
        end
      end)
    }

    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })

    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "cmdline" },
      }
    })

    cmp.setup(config)
  end
}
