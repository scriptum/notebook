if hash pngcrush advdef advpng 2>/dev/null; then
  png.optimize() {
    _find_files_helper "*.png" "$@" | xargs -0 -P$(nproc) -I{} \
    sh -c '_OLD_SIZE="{} $(wc -c < "{}") -> "
            pngcrush -brute -reduce -rem alla -s -ow "{}" 2>/dev/null
            advdef -q -z -4 "{}"
            advpng -q -z -4 "{}"
    echo "$_OLD_SIZE $(wc -c < "{}")"'
  }
  png.optimize.extreme() {
    _find_files_helper "*.png" "$@" | xargs -0 -P$(nproc) -I{} \
    sh -c '_OLD_SIZE="{} $(wc -c < "{}") -> "
        pngcrush -brute -reduce -rem alla -s -ow "{}" 2>/dev/null
        advdef -q -z -4 -i100 "{}"
        advpng -q -z -4 -i100 "{}"
    echo "$_OLD_SIZE $(wc -c < "{}")"'
  }
fi # end of png optimize
