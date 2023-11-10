local cmp = require("cmp")

local snippy = require("snippy")

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

cmp.setup({
  sources = {
    { name = "nvim_lsp", priority = 9 },
    { name = "nvim_lua", priority = 8 },
    { name = "snippy", priority = 7 },
    { name = "buffer", priority = 6 },
    { name = "nvim_lsp_signature_help" },
    { name = "omni" },
    { name = "path" },
  },

  window = {
    completion = {
      border = "single",
      winhighlight = "Normal:Normal,FloatBorder:FloatBorder,Search:Search",
      scrollbar = false,
    },
    documentation = {
      border = "single",
      winhighlight = "Normal:Normal,FloatBorder:FloatBorder,Search:Search",
      scrollbar = false,
    }
  },

  sorting = {
    priority_weight = 1.0,
  },

  formatting = {
    fields = { "abbr", "kind" },
    format = function(_, vim_item)
      vim_item.abbr = string.sub(vim_item.abbr, 1, 50)
      vim_item.kind = kind_icons[vim_item.kind]
      return vim_item
    end,
  },

  snippet = {
    expand = function(args)
      snippy.expand_snippet(args.body)
    end,
  },

  mapping = {
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif snippy.can_expand_or_advance() then
        snippy.expand_or_advance()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif snippy.can_jump(-1) then
        snippy.previous()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<CR>"] = cmp.mapping.confirm({ select = false, behavior = cmp.ConfirmBehavior.Insert }),
    ["<C-e>"] = cmp.mapping.abort(),
  },
})

cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  view = {
    entries = { name = "wildmenu", separator = " | " }
  },
  sources = {
    { name = "buffer" },
  },
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  view = {
    entries = { name = "wildmenu", separator = " | " }
  },
  sources = {
    { name = 'path' },
    { name = 'cmdline' }
  }
})

cmp.event:on(
  "confirm_done",
  require("nvim-autopairs.completion.cmp").on_confirm_done({
    filetypes = {
      scala = false,
    }
  })
)

require("nvim-surround").setup()
require("Comment").setup()

local npairs = require("nvim-autopairs")

npairs.setup({
  enable_check_bracket_line = false,
  ignored_next_char = "[%w%.]",
})

local Rule = require("nvim-autopairs.rule")

local brackets = { { '(', ')' }, { '[', ']' }, { '{', '}' } }

npairs.add_rules {
  Rule(' ', ' ')
    :with_pair(function (opts)
      local pair = opts.line:sub(opts.col - 1, opts.col)
      return vim.tbl_contains({
        brackets[1][1]..brackets[1][2],
        brackets[2][1]..brackets[2][2],
        brackets[3][1]..brackets[3][2],
      }, pair)
    end)
}
for _,bracket in pairs(brackets) do
  npairs.add_rules {
    Rule(bracket[1]..' ', ' '..bracket[2])
      :with_pair(function() return false end)
      :with_move(function(opts)
        return opts.prev_char:match('.%'..bracket[2]) ~= nil
      end)
      :use_key(bracket[2])
  }
end
