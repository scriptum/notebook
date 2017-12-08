# translate all aliases and functions
# this makes possible to use common aliases without switching layout

# Usage: add or source into your ~/.bashrc

_mistype_trans()
{
    perl -pe "
    use utf8;
    use open ':std', ':encoding(UTF-8)';
    tr/qwertyuiopasdfghjklzxcvbnm/йцукенгшщзфывапролдячсмить/"
}
_all_aliases()
{
    alias -p | tr = ' ' | fld 2 | grep ^[a-z]
    declare -F | fld 3 | grep ^[a-z]
}
while read a b; do
    if [[ $a != $b ]]; then
        alias $b=$a
    fi
done < <(paste <(_all_aliases) <(_all_aliases | _mistype_trans))
