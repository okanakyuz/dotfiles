return {
  {
    "dylanaraps/wal.vim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("wal")
      vim.cmd([[
        highlight Normal guibg=NONE ctermbg=NONE
        highlight NormalNC guibg=NONE ctermbg=NONE
        highlight SignColumn guibg=NONE ctermbg=NONE
        highlight VertSplit guibg=NONE ctermbg=NONE
        highlight StatusLine guibg=NONE ctermbg=NONE
      ]])
    end,
  },
}
