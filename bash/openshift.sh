alias ocpods='oc get pods -o wide'
alias ocsh='oc rsh'
alias ocrsh='oc rsh'
alias oclog='oc logs'
alias oclogf='oc logs'

_comp_ocsh() {
  COMPREPLY=( $( oc get pods | tail -n+2 | awk '/Running/{print $1}' | grep "^$2" ) )
}
complete -F _comp_ocsh ocsh
_comp_oclog() {
  COMPREPLY=( $( oc get pods | tail -n+2 | awk '{print $1}' | grep -v -- -deploy | grep "^$2" ) )
}
complete -F _comp_oclog oclog oclogf
