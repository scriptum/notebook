# set of short aliases for files searching

# find files/dirs contains <query>
f() {
    find -iname "*$**" 2> /dev/null
}
# find files starts with <query>
fs() {
    find -type f -iname "$**" 2> /dev/null
}
# find files ends with <query>
fe() {
    find -type f -iname "*$*" 2> /dev/null
}
# find dirs contains <query>
fd() {
    find -type d -iname "*$**" 2> /dev/null
}
# find files contains <query>
ff() {
    find -type f -iname "*$**" 2> /dev/null
}
