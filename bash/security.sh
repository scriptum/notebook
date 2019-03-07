# Mac
if [[ $(uname) == Darwin ]]; then
    secret.save() {
        local pass
        read -r  -p "Enter secret: " pass
        security add-generic-password -a "$USER" -s "$1" -w "$pass"
    }
    secret.load() {
        security find-generic-password -a "$USER" -s "$1" -w
    }
else
    secret.save() {
        secret-tool store --label="$1" "$1" "$1"
    }
    secret.load() {
        secret-tool lookup "$1" "$1"
    }
fi
