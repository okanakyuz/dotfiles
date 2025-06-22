return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      lspconfig.clangd.setup({
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
        cmd = { "clangd", "--header-insertion=never", "--inlay-hints=false" }, 
      })
      lspconfig.rust_analyzer.setup({
            settings = {
                ["rust-analyzer"] = {
                checkOnSave = {
                    command = "clippy"
                }
                }
            }
        })
    end,
  },
}
