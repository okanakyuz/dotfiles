return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      lspconfig.clangd.setup({})

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
