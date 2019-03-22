gr() {
  ./gradlew "$@"
}

_complete_gr() {
  local candidates
  local words='build
docker
publish
tasks
dockerPush
bootJar
bootRun
clean
test
check'

  candidates=$(grep "^$2" <<< "$words")

  COMPREPLY=( $(compgen -W "${candidates}" -- "$2") )
}

complete -F _complete_gr -o default gr

alias grb='gr build'
alias grp='gr publishToMavenLocal'
alias grta='gr tasks'
alias grt='gr test'
alias grd='gr docker'
alias grdp='gr dockerPush'
alias grpu='gr publish'
alias grc='gr clean'
