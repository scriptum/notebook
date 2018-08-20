_MAGEIA_SRPMS_URL=https://mirror.yandex.ru/mageia/distrib/cauldron/SRPMS/core/release/

_mageia_srpms()
{
    curl $_MAGEIA_SRPMS_URL | grep -oP '>[^<]+<' | tr -d '<>'
}

_mageia_srpms_comp() {
    local cur prev words cword
    _init_completion || return
    COMPREPLY=($(compgen -W "$(_mageia_srpms)" -- "$cur"))
    return 0
}

mageia.get()
{
    (
        cd ~/Downloads
        for pkg in "$@"; do
            wget $_MAGEIA_SRPMS_URL/$pkg
        done
    )
}
complete -F _mageia_srpms_comp mageia.get
