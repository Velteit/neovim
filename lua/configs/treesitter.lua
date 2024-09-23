-- https://github.com/nvim-treesitter/nvim-treesitter
return {
  ensure_installed = {
    "lua",
    "vim",

    "rust",
    "go",
    "java",
    "scala",

    "c",
    "css",

    "markdown",
    "markdown_inline",

    "sql",
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",

    "json",

    "regex",

    "python",

    "comment",
    "bash",

    "diff",
    "dockerfile",

    "git_rebase",
    "gitcommit",
    "gitignore",

    "yuck",

    "yaml"
  },

  highlight = {
    enable = true,
    use_languagetree = true,
    additional_vim_regex_highlighting = false
  },

  indent = { enable = true },

  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  }
}
