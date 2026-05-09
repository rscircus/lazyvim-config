return {
  "jubnzv/mdeval.nvim",
  ft = "markdown",
  opts = {
    on_exit = function() end,
  },
  config = function(_, opts)
    require("mdeval").setup(opts)

    local function set_keymap(buffer)
      vim.keymap.set("n", "<leader>e", require("mdeval").eval_code_block, {
        desc = "Evaluate Code Block",
        buffer = buffer,
      })
    end

    set_keymap(0)

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "markdown",
      callback = function(args)
        set_keymap(args.buf)
      end,
    })
  end,
}
