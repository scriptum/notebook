# improved bc with trigonometry and useful functions
bc() {
    /usr/bin/bc -qli <(echo '
    scale=32
    pi=4*a(1)
    e=e(1)
    scale=20

    define sin(x) {
        return (s(x))
    }

    define cos(x) {
        return (c(x))
    }

    define atan(x) {
        return (a(x))
    }

    define arctg(x) {
        return (a(x))
    }

    define tan(x) {
        return (s(x)/c(x))
    }

    define tg(x) {
        return (s(x)/c(x))
    }

    define asin(x) {
        if(x==1) return(pi/2)
        if(x==-1) return(-pi/2)
        return(a(x/sqrt(1-(x^2))))
    }

    define arcsin(x) {
        return (asin(x))
    }

    define acos(x) {
        if(x==1) return(0)
        if(x==-1) return(pi)
        return(pi/2-a(x/sqrt(1-(x^2))))
    }

    define arccos(x) {
        return (acos(x))
    }

    define cot(x) {
        return(c(x)/s(x))
    }

    define ctg(x) {
        return(c(x)/s(x))
    }

    define acot(x) {
        return(pi/2-a(x))
    }

    define arcctg(x) {
        return(pi/2-a(x))
    }

    define sec(x) {
        return(1/c(x))
    }

    define cosec(x) {
        return(1/s(x))
    }

    define csc(x) {
        return(1/s(x))
    }

    define asec(x) {
        return(acos(1/x))
    }

    define acosec(x) {
        return(asin(1/x))
    }

    define acsc(x) {
        return(asin(1/x))
    }

    define ln(x) {
        return(l(x))
    }

    define log(x) {
        return(l(x)/l(10))
    }

    define pow(x,y) {
        return(e(y*l(x)))
    }')
}
