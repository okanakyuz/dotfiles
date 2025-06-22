return {
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
      })
  
      require("mason-lspconfig").setup_handlers({
        function(server_name)
          require("lspconfig")[server_name].setup({})
        end,
        ["rust_analyzer"] = function()
          -- rust_analyzer'ı zaten elle yapılandırdığın için burada bir şey yapma
        end,
      })
    end,
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
