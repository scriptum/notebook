objdump.pretty()
{
    objdump -S --disassemble -M intel "$@" | sed -r \
        -e 's/  [0-9a-f]+:\s+([0-9a-f][0-9a-f] )+\s*/%\t/' \
        -e 's/#.*//' -e '/^[^%]/s/^/#/' -e 's/^%//' | less
}

objdump.cmp()
{
    meld <(objdump.pretty "$1") <(objdump.pretty "$2")
}
