# commandline search on rpmfind.net
rpm.find()
{
    [[ $# -eq 0 ]] && return 1
    curl -s -G https://www.rpmfind.net/linux/rpm2html/search.php \
        --data-urlencode "query=$*" \
        | grep -oE "/[^']*\.html" | grep x86_64 \
        | sed s@^@http://rpmfind.net@
}
