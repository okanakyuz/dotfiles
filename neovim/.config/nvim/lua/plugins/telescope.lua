return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    config = function()
      require("telescope").setup {
        defaults = {
          -- tercihen burada ayar yapabilirsin
        },
        pickers = {
          git_files = {
            show_untracked = true,
          },
        },
      }
      -- load fzf native extension
      require("telescope").load_extension("fzf")
    end,
  },
}