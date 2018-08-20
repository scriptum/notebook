# search anything in c/c++ source
src() {
  /bin/grep --color=always -InRswa \
  '--include=*.'{[ch]{,pp,xx,++},h[hp],c[cp],tcc,[CH],CPP} \
  "$@" . 2> /dev/null | less -XFRS
}
alias grep.c=src

# search anything in python source
srp() {
  /bin/grep --color=always -InRswa '--include=*.py' "$@" . 2> /dev/null | less -XFRS
}
alias grep.py=srp

# search anything in nim source
srn() {
  /bin/grep --color=always -iInRswa '--include=*.nim' "$@" . 2> /dev/null | less -XFRS
}
alias grep.nim=srn

# search in assembler
srs() {
  /bin/grep --color=always -InRsa '--include=*.s' "$@" . 2> /dev/null | less -XFRS
}
alias grep.asm=srs

# search in javascript
srj() {
  /bin/grep --color=always -InRswa '--include=*.js' "$@" . 2> /dev/null | less -XFRS
}
alias grep.js=srj

# search anything
sr() {
  local inc
  # e.g. sr *.m4 SOME_MACRO
  while [[ $1 == \** ]]; do
    inc="$inc --include=$1"
    shift
  done
  /bin/grep --color=always -iInRs --exclude-dir=.git --exclude-dir=.svn "$inc" "$@" . 2> /dev/null | less -XFRS
}

grep.iso() {
  { isoinfo -fJ -i "$1" 2> /dev/null || isoinfo -fR -i "$1"; } | \
    grep -e rpm$ -e deb$ | sed s@.*/@@ | grep "$2"
}

grep.skype() {
  local db=$(ls ~/.Skype/*/main.db | head -1)
  sqlite3 -separator " " "$db" "select datetime(timestamp, 'unixepoch', 'localtime'), author, body_xml from messages;" | \
    grep -i "$@" | less -XFRS
}
