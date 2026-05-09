return {
  {
    "junegunn/gv.vim",
    dependencies = { "tpope/vim-fugitive" },
    cmd = "GV",
    keys = {
      { "<leader>gV", "<cmd>GV<cr>", desc = "Git commit browser" },
      { "<leader>gv", "<cmd>GV!<cr>", desc = "Git commit browser (current file)" },
    },
  },
}
