__ADB_ORIG=$(type -P adb 2>/dev/null)
adb()
{
    "$__ADB_ORIG" devices | grep device$ | cut -f1 | xargs -I{} -P$(nproc) "$__ADB_ORIG" -s {} "$@"
}
