# grep over history
alias hsg='history | grep --color=auto -i'

# make make parallel - number of processors * 2
alias make="make -j$(($(nproc)*2))"

alias dd='dd status=progress'
alias psg='ps aux | grep -vw grep | grep'

alias ns='netstat -tupln'
alias nsg='netstat -tupln | grep'

mv.bak() {
  mv -T "${1%/}"{,.bak}
}
mv.unbak() {
  mv -T "${1%/}"{.bak,}
}

alias ыыр=ssh

# prefer colordiff if exists
hash colordiff 2>/dev/null && alias diff='colordiff'

alias cdcd='cd; cd -'

# traditional output style for profiler
hash gprof 2> /dev/null && alias gprof='gprof -T'

alias xtar='tar -xvf'

alias l='ls'
alias ll='ls -laFvhQ --color=auto'

alias pstree='pstree -apl'
alias pgrep='pgrep -l'

alias grep='grep --color=auto -i'

alias scp="scp -r"

# aliases for cd including some common mistypes
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# reload bashrc
alias .b='. ~/.bashrc'
# edit bashrc
alias rced="$_MY_EDITOR ~/.bashrc"

if [[ -x /bin/man ]]; then
  # do not show russian man pages
  man() {
    LANG=C LC_ALL=C /bin/man "$@"
  }
fi

dush() {
  case $# in
    0) du -sh ./* | sort -h;;
    1) du -sh "$1"/* | sort -h;;
    *) du -sh "$@" | sort -h;;
  esac
}
alias df='df -h -x tmpfs -x devtmpfs'

# retrieve nth field from file
fld() {
  awk '{print $'$1'}'
}

# get frequency of nth field in file, e.g.:
# - most frequent letter: fold -w1 /etc/passwd | freq
# - cut -d: -f7 /etc/passwd | freq
# - groups in /dev: ls -l /dev | freq 4
freq() {
  local n=0
  [[ $# -ge 1 ]] && n="$1"
  # use awk - it allows to get fields
  awk '{d[$'$n']++}END{for(k in d){printf "%10d %s\n", d[k], k}}' | sort -n
}

hash htop 2>/dev/null && alias top=htop

urldecode() {
    local url
    while read -r url; do
        url="${url//+/ }"
        printf '%b\n' "${url//%/\\x}"
    done
}

recentlyused() {
    xmllint ~/.local/share/recently-used.xbel --xpath //bookmark/@href | tr ' ' '\n' | urldecode | sed -e 's,^href="file://,,' -e 's/"$//'
}

# converts any command output to KOI-7 cyrillic encoding
koi7()
{
    "$@" |& iconv -cf KOI-7
}

hash qrencode 2>/dev/null && hash zsel 2>/dev/null alias qr='xsel | qrencode -t ANSIUTF8 -o-'
