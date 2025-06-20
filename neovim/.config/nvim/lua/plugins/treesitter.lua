return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        highlight = { enable = true },
        indent = { enable = true },
        ensure_installed = {
          "lua", "go", "bash", "json", "yaml", "toml", "c", "cpp", "rust"
        },
      })
    end,
  },
}
