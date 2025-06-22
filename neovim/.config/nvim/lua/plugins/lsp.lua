return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      lspconfig.clangd.setup({
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
        cmd = { "clangd", "--header-insertion=never" },
        on_attach = function(client, bufnr)
            vim.lsp.inlay_hint.enable(false, {bufnr=0})
        end,
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
