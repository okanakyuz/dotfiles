return {
  {
    "nvimtools/none-ls.nvim",
    config = function()
      local null_ls = require("null-ls")

      local mason_path = vim.fn.stdpath("data") .. "/mason/bin"

      null_ls.setup({
        sources = {
          null_ls.builtins.diagnostics.cpplint.with({
            command = mason_path .. "/cpplint",
            extra_args = { "--filter=-whitespace" },
            }),
          null_ls.builtins.diagnostics.golangci_lint,
          null_ls.builtins.diagnostics.clippy, -- rust linter
        },
      })
    end,
  },
}
