return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = {
          { name = "nvim_lsp" , keyword_length = 1, max_item_count = 20, group_index = 1 },
          -- { name = "tags" },
          -- { name = "buffer" }, 
          -- { name = "path" },  
        },
        formatting = {
          format = function(entry, vim_item)
            vim_item.dup = { buffer = 0, path = 0, nvim_lsp = 0 }[entry.source.name] or 0
            return vim_item
          end
        },
      })
    end,
  },
}
