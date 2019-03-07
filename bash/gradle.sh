gr() {
  ./gradlew "$@"
}

_complete_gr() {
  local candidates cur
  _init_completion -s || return
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

  candidates=$(grep "^$cur" <<< "$words")

  COMPREPLY=( $(compgen -W "${candidates}" -- "$cur") )
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
