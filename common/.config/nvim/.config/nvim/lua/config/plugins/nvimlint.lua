return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    lint.linters.golangci_lint = {
      cmd = "golangci-lint",
      stdin = false,
      args = { "run", "--out-format", "line-number" },
      stream = "stdout",
      ignore_exitcode = true,
      parser = require("lint.parser").from_errorformat(
        "%f:%l:%c: %m",
        { source = "golangci-lint" }
      ),
    }

    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      lua = { "luacheck" },
      go = { "golangci_lint" },
    }

    local augroup = vim.api.nvim_create_augroup("NvimLint", { clear = true })

    vim.api.nvim_create_autocmd("BufWritePost", {
      group = augroup,
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
