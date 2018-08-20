sed.test()
{
  local diffcmd=diff
  hash colordiff &>/dev/null && diffcmd=colordiff
  $diffcmd -u ${!#} <(sed "$@" || return 1)
}
