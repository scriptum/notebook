# ansible
if hash ansible-playbook 2>/dev/null; then
    ap()
    {
        ansible-playbook "$@"
    }

    av()
    {
        cmd=$1
        shift

        if [[ -n "$ANSIBLE_VAULT_PASSWORD_FILE" ]]; then
            EDITOR=mousepad ansible-vault $cmd --vault-password-file="$ANSIBLE_VAULT_PASSWORD_FILE" "$@"
        else
            echo 'Put file path with password into $ANSIBLE_VAULT_PASSWORD_FILE environment variable' >&2
            return 1
        fi
    }

    _ap() {
        local cur prev words cword
        _init_completion || return
        _filedir yml
        return 0
    }
    complete -F _ap ap
fi
