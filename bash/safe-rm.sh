# protection from accidentally mistyped rm. Use rrm for "old" rm
# do not forget to use /bin/rm instead of just rm in .bashrc

# rm is aliased to rm -i in some distros
[[ $(type -p rm) == "" ]] && unalias rm 2>/dev/null

__RMTHREAD=""
rm()
{
    local threshold=10
    if [[ $1 == "-fr" || $1 == "-rf" || $# -gt $threshold ]]; then
        local sec=10
        {(
            echo "After $sec s files wil be removed:"
            echo "$@"
            sleep $sec
            /bin/rm "$@"
        )& disown;} 2>/dev/null
        __RMTHREAD=$!
        echo "Type $(tput bold)mr$(tput sgr0) to cancel"
    else
        /bin/rm "$@"
    fi
}
mr()
{
    kill $__RMTHREAD 2>/dev/null
    __RMTHREAD=""
}
rrm()
{
    /bin/rm "$@"
}
