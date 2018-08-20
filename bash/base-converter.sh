dec2bin() {
    echo "obase=2; ibase=10; $1" | /usr/bin/bc
}
dec2hex() {
    echo "obase=16; ibase=10; $1" | /usr/bin/bc
}
hex2dec() {
    local n=${1^^}
    echo "obase=10; ibase=16; ${n#0X}" | /usr/bin/bc
}
hex2bin() {
    local n=${1^^}
    echo "obase=2; ibase=16; ${n#0X}" | /usr/bin/bc
}
oct2dec() {
    echo "obase=10; ibase=8; ${1#0}" | /usr/bin/bc
}
bin2oct() {
    echo "obase=10; ibase=8; ${1#0}" | /usr/bin/bc
}
oct2bin() {
    echo "obase=2; ibase=8; ${1#0}" | /usr/bin/bc
}
dec2oct() {
    echo "obase=8; ibase=10; $1" | /usr/bin/bc
}
