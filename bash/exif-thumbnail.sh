if hash exiftool 2>/dev/null; then
  exif.thumbnail(){
    for i in "$@"; do
      exiftool '-ThumbnailImage<='<(convert "$i" -thumbnail 128x128 -format jpg -) "$i"
    done
  }
fi
