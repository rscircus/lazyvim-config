return {
  "jubnzv/mdeval.nvim",
  opts = {
    -- To disable the "Execution Finished" notification,
    -- override the on_exit callback with an empty function.
    on_exit = function(code, output) end,
  },
  config = function(_, opts)
    require("mdeval").setup(opts)
    
    -- Create an autocommand that sets the keybinding only for markdown files
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {"markdown", "md"},
      callback = function()
        vim.keymap.set("n", "<leader>e", require("mdeval").eval_code_block, 
          { desc = "Evaluate Code Block", buffer = true })
      end,
    })
  end,
}