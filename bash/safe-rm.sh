# protection from accidentally mistyped rm. Use rrm for "old" rm
# do not forget to use /bin/rm instead of just rm in .bashrc

# rm is aliased to rm -i in some distros
[[ $(type -p rm) == "" ]] && unalias rm 2>/dev/null

if [[ $(uname) == Darwin ]]; then
rm() {
    [[ $1 == "-fr" || $1 == "-rf" ]] && shift
    trash "$@"
}
else
rm() {
    [[ $1 == "-fr" || $1 == "-rf" ]] && shift
    gio trash "$@"
}
fi

rrm() {
    /bin/rm "$@"
}
