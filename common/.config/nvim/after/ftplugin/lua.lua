vim.opt_local.shiftwidth = 4


vim.api.nvim_create_autocmd("BufAdd", {
  callback = function(args)
    local ft = vim.bo[args.buf].filetype
    if ft == "mini.files" then
      -- mark buffer as not listed so tabufline ignores it
      vim.bo[args.buf].buflisted = false
    end
  end,
})

