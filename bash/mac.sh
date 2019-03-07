if [[ $(uname) == Darwin ]]; then # Mac
if hash brew 2>/dev/null; then
  alias ys='brew search'
  alias yi='brew install'
  alias ql='brew ls'
fi # brew
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
if hash gfind 2>/dev/null; then
find(){
  gfind "$@"
}
xargs(){
  gxargs "$@"
}
locate(){
  glocate "$@"
}
updatedb(){
  gupdatedb "$@"
}
fi
fi # Darwin
