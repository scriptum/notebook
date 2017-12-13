# create archive quickly
pack()
{
    local force=0 file
    if [[ $1 == -f ]]; then
        force=1
        shift
    fi
    file="${1%/}.tar.gz"
    if [[ -f "$file" && $force == 0 ]]; then
        echo "'$file': file exists"
        return 1
    fi
    tar -cvzf "$file" "$@"
    file=$(readlink -f "$file")
    hash xclip 2>/dev/null && xclip <<< "$file"
    echo "$file"
}
