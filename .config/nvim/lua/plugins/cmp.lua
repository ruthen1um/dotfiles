local cmp = require("cmp")
local luasnip = require("luasnip")

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

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
  sources = {
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "luasnip" },
    { name = "buffer" },
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
      luasnip.lsp_expand(args.body)
    end,
  },

  mapping = {
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
        -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
        -- that way you will only jump inside the snippet region
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
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
    { name = 'cmdline' }
  }
})

-- require("nvim-surround").setup()
-- require("Comment").setup()
--
-- local npairs = require("nvim-autopairs")
--
-- npairs.setup({
--   enable_check_bracket_line = false,
--   ignored_next_char = "[%w%.]",
-- })
--
-- local Rule = require("nvim-autopairs.rule")
--
-- local brackets = { { '(', ')' }, { '[', ']' }, { '{', '}' } }
--
-- npairs.add_rules {
--   Rule(' ', ' ')
--     :with_pair(function (opts)
--       local pair = opts.line:sub(opts.col - 1, opts.col)
--       return vim.tbl_contains({
--         brackets[1][1]..brackets[1][2],
--         brackets[2][1]..brackets[2][2],
--         brackets[3][1]..brackets[3][2],
--       }, pair)
--     end)
-- }
-- for _,bracket in pairs(brackets) do
--   npairs.add_rules {
--     Rule(bracket[1]..' ', ' '..bracket[2])
--       :with_pair(function() return false end)
--       :with_move(function(opts)
--         return opts.prev_char:match('.%'..bracket[2]) ~= nil
--       end)
--       :use_key(bracket[2])
--   }
-- end
