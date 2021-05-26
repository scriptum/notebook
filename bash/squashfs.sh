mksquashfs.make-image(){
  local dir=$1
  mksquashfs -b 1M -no-exports -no-xattrs -noappend -progress "$dir" "$dir".img
}