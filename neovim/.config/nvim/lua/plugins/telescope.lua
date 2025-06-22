return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = vim.fn.executable("make") == 1,
        config = function()
          require("telescope").load_extension("fzf")
        end,
      },
    },
    config = function() 
      require("telescope").setup {
        defaults = {
        },
        pickers = {
          git_files = {
            show_untracked = true,
          },
        },
      }
    end,
  },
}
