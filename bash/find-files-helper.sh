# helper function - find files by mask or list arguments if specified
# this allows to use some commands in following scenario:
# - wihout agruments - scan current directory with mask (e.g. *.png)
# - with arguments - print those atruments in find -print0 format (e.g. {a,b,c}.png)
_find_files_helper()
{
  local find_expr="$1"
  shift
  if [[ -z $1 ]]; then
    find -name "$find_expr"  -type f -print0
  else
    ls -1 -- "$@" | tr '\n' '\0'
  fi
}
