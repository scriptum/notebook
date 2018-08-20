# favorite editor
_MY_EDITOR=code
g()
{
  local f=$1
  if [[ $f == *:[0-9]* ]]; then
    $_MY_EDITOR -r -g "$f"
  else
    $_MY_EDITOR -r "$f"
  fi
}
