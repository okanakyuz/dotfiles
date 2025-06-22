return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
    end,
  },
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "clangd", "rust_analyzer" },
        automatic_installation = false,
        handlers = {
          function(server_name)
              require("lspconfig")[server_name].setup {}
          end,
          ["rust_analyzer"] = function()
              require("lspconfig").rust_analyzer.setup({
              settings = {
                ["rust-analyzer"] = {
                  checkOnSave = { command = "clippy" },
                },
              },
            })
          end,
        },
      })
  },
  {
    "jay-babu/mason-null-ls.nvim",
    dependencies = { "mason.nvim", "nvimtools/none-ls.nvim" },
    config = function()
      require("mason-null-ls").setup({
        ensure_installed = {
          "clang-format",
          "golines",
          "rustfmt",
          "cpplint",
          "golangci-lint",
        },
        automatic_installation = true,
      })
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("mason-nvim-dap").setup({
        ensure_installed = { "cpptools", "delve" },
        automatic_installation = true,
      })
    end,
  },
}
