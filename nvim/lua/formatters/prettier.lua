local prettier = {
  formatCommand = "prettierd --stdin-filepath ${INPUT}",
  formatStdin = true,
}
return prettier
