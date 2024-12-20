return {
  "vidocqh/auto-indent.nvim",
  opts = {
    ---@param lnum: number
    ---@return number
    indentexpr = function(lnum)
      return require("nvim-treesitter.indent").get_indent(lnum)
    end,
  },
}
