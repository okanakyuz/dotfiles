vim.opt.expandtab = false      
vim.opt.tabstop = 4           
vim.opt.shiftwidth = 4        
vim.opt.softtabstop = 4
vim.opt.number = true         
vim.opt.relativenumber = true 

vim.g.mapleader = " "
vim.g.maplocalleader = " "


vim.diagnostic.config({
  underline = {
    severity = { min = vim.diagnostic.severity.WARN },
  },
  virtual_text = false,
  signs = {
	severity = { min = vim.diagnostic.severity.WARN },
  },
  update_in_insert = false,
  severity_sort = true,
})

vim.lsp.inlay_hint.enable(false)
