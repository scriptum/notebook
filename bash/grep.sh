if hash ggrep 2>/dev/null; then
  _GREP=ggrep
else
  _GREP=/bin/grep
fi
# search anything in c/c++ source
src() {
  $_GREP --color=always -InRswa \
  '--include=*.'{[ch]{,pp,xx,++},h[hp],c[cp],tcc,[CH],CPP} \
  "$@" . 2> /dev/null | less -XFRS
}
alias grep.c=src

# search anything in python source
srp() {
  $_GREP --color=always -InRswa '--include=*.py' "$@" . 2> /dev/null | less -XFRS
}
alias grep.py=srp

# search anything in nim source
srn() {
  $_GREP --color=always -iInRswa '--include=*.nim' "$@" . 2> /dev/null | less -XFRS
}
alias grep.nim=srn

# search in assembler
srs() {
  $_GREP --color=always -InRsa '--include=*.s' "$@" . 2> /dev/null | less -XFRS
}
alias grep.asm=srs

# search in javascript
srj() {
  $_GREP --color=always --exclude-dir=node_modules --exclude-dir=.git --exclude-dir=.svn -InRswa '--include=*.js' "$@" . 2> /dev/null | less -XFRS
}
alias grep.js=srj

# search anything
sr() {
  local inc=()
  # e.g. sr *.m4 SOME_MACRO
  while [[ $1 == \** ]]; do
    inc+="--include=$1"
    shift
  done
  $_GREP --color=always -iInRs --exclude-dir=.git --exclude-dir=.svn --exclude-dir=.idea  --exclude-dir=.vscode --exclude-dir=build --exclude-dir=node_modules --exclude-dir=venv --exclude=package-lock.json --exclude=yarn.lock "${inc[@]}" "$@" . 2> /dev/null | less -XFRS
}

if hash isoinfo 2>/dev/null; then
grep.iso() {
  { isoinfo -fJ -i "$1" 2> /dev/null || isoinfo -fR -i "$1"; } | \
    grep -e 'rpm$' -e 'deb$' | sed s@.*/@@ | grep "$2"
}
fi

if [[ -d ~/.Skype ]]; then
grep.skype() {
  local db=$(ls ~/.Skype/*/main.db | head -1)
  sqlite3 -separator " " "$db" "select datetime(timestamp, 'unixepoch', 'localtime'), author, body_xml from messages;" | \
    grep -i "$@" | less -XFRS
}
fi
