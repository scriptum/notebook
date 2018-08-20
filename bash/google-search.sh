# google search with some helper keywords
gg() {
  case "${*,,}" in
  g_*|g[td]k_*)
    o "https://google.ru/search?q=$* site:developer.gnome.org" >& /dev/null
  ;;
  nim*)
    o "https://google.ru/search?q=$* site:nim-lang.org" >& /dev/null
  ;;
  vsc*)
    o "https://google.ru/search?q=visual studio code${*#vsc}" >& /dev/null
  ;;
  rn*)
    o "https://google.ru/search?q=react native${*#rn}" >& /dev/null
  ;;
  *)
    o "https://google.ru/search?q=$*" >& /dev/null
  esac
}
