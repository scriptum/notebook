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

png.fill.holes() {
    for f in "$@"; do
        convert "$f" -transparent black -channel A -morphology EdgeIn Diamond -type TrueColorMatte png8:.mask.png
        convert .mask.png txt:- | sed '1d; /0)/d; s/:.* /,/;' | convert "$f" -sparse-color voronoi '@-' .fill.png
        convert .fill.png "$f" -composite "$f" -compose copy_opacity -composite .new.png
        mv "$f" "$f".bak
        mv .new.png "$f"
        /bin/rm -f .mask.png .fill.png
    done
}
png.quantize() {
    colors=$1
    shift
    for f in "$@"; do
        convert "$f" -separate -channel RGB -dither none -colors $colors +channel -combine .new.png
        mv "$f" "$f".bak
        mv .new.png "$f"
    done
}