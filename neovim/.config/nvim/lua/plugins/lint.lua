return {
    {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
        local null_ls = require("null-ls")

        null_ls.setup({
        sources = {
            null_ls.builtins.diagnostics.cpplint.with({
            extra_args = { "--filter=-whitespace" },
            }),
            null_ls.builtins.diagnostics.golangci_lint,
        },
        })
    end,
    }
}