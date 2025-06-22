return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      lspconfig.clangd.setup({
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
        cmd = { "clangd", "--header-insertion=never" },
        on_attach = function(client, bufnr)
          if client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(false, {bufnr=0})
          end
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
