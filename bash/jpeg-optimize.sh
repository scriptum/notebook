if hash jpegtran 2>/dev/null; then
  jpg.optimize() {
    _find_files_helper "*.jpg" "$@" | xargs -0 -P$(nproc) -I{} \
    sh -c 'OS=$(wc -c < "{}")
    T="$(mktemp)"
    jpegtran -copy none -progressive -optimize "{}" > "$T"
    if [[ $? -eq 0 ]]; then
        NS=$(wc -c < "$T")
        if [[ $NS -gt $OS ]]; then
            rm "$T"
            NS=$OS
        else
            mv "$T" "{}"
        fi
        printf "%-30s %10s -> %-10s\n" "{}" "$OS" "$NS"
    else
        rm "$T"
    fi'
  }
fi # end of jpegtran
