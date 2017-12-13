if [[ -x /usr/bin/gs ]]; then
# pdf optimizer
pdf.optimize() {
    local size_old size_new tmp file
    for file in "$@"; do
        tmp=$(mktemp)
        size_old=$(wc -c < "$file")
        echo "Optimizing '$file' of size $size_old"
        /usr/bin/gs \
        -sDEVICE=pdfwrite \
        -dCompatibilityLevel=1.4 \
        -dPDFSETTINGS=/ebook \
        -dDetectDuplicateImages=true \
        -dNOPAUSE \
        -dBATCH \
        -dQUIET \
        -sOutputFile="$tmp" \
        "$file"
        size_new=$(wc -c < "$tmp")
        if ((size_new > size_old)); then
            echo "New size ($size_new) is bigger, skipping"
            /usr/bin/rm "$tmp"
        else
            echo "New size: $size_new"
            /usr/bin/mv "$file" "~$file"
            /usr/bin/mv "$tmp" "$file"
        fi
    done
}
fi # end of gs
