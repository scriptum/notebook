# Set of handy aliases and functions in RPM distro (Fedora, CentOS, Mageia)
# It also extremely increases performance of packages autocompletion
#
# YUM aliases (or alternativaly uses dnf if installed and repoqurey if present)
# yi    Install pakcage
# yu    Update (package)
# ye    Autoremove package (with all orphans)
# yr    Reinstall package
# ys    Search package
# yinf  Info about package
# yf    Info about package
# yp    Search provides
# yps   Search SRPM provides
# yca   Clean all
#
# RPM handy aliases
# qi        Query info
# qf        Query file (show rpm package for file)
# ql        Query file list (show all files in package)
# qa        Query all files
# qag       Query all files and grep
# rpm.name  Show name of package for list of files (e.g. ls *.rpm | rpm.name)
# rpm.qa    Faster version of rpm -qa --qa '%{N}\n' (show all rpm names)
# rpm.top   Show most heavy packages
# rpm.last  Show last installed packages

if hash rpm 2>/dev/null; then # rpm
    _PKGMGR=yum
    hash dnf 2>/dev/null && _PKGMGR=dnf
    alias yca="sudo $_PKGMGR clean all"
    alias ye="sudo $_PKGMGR autoremove -C"
    alias yi="sudo $_PKGMGR install -y"
    alias yr="sudo $_PKGMGR reinstall -y"
    alias yu="sudo $_PKGMGR update -y"
    if hash repoquery 2>/dev/null && ! hash dnf 2>/dev/null; then # repoquery present
        alias yp="repoquery --whatprovides --qf %{name}"
        alias yps="repoquery --whatprovides --qf %{name} -s"
        alias yinf="repoquery --info"
        alias yf="repoquery --info"
        alias ys="repoquery --search"
    else
        alias yinf="$_PKGMGR -C info"
        alias yf="$_PKGMGR -C info"
        alias yp="$_PKGMGR -C provides"
        # alias yps="$_PKGMGR -C provides --qf %{name} -s"
        alias ys="$_PKGMGR search"
    fi
    unset _PKGMGR

    if hash dnf 2>/dev/null; then # dnf
        # dnf aliases
        _dnf_aliased() {
            let COMP_CWORD+=1
        }
    else # yum aliases
        _yum_aliased() {
            let COMP_CWORD+=1
        }
    fi #dnf

    _RPMGRP=$(echo /usr/share/doc/rpm-*/GROUPS)
    if [[ -f $_RPMGRP ]]; then
        alias rpm.groups="less -XFR $_RPMGRP"
    fi
    unset _RPMGRP

    # extract rpm package name from file name
    rpm.name()
    {
        local expr="-e s@.*/@@ -e s@^[0-9]:@@ -e s/-[^/-]*-[^-]*$//"
        if [[ -t 0 ]] && hash xsel 2>/dev/null; then
            xsel | sed $expr
        else
            sed $expr
        fi
    }

    # rpm package by file name
    qf() {
        if [[ -f $1 ]]; then
            rpm -qf "$1"
        else
            rpm -qf "$(type -P "$1")"
        fi
    }
    # fast package list
    rpm.qa() {
        python -c "
import bsddb
F = '/var/lib/rpm/Name'
try:
    it = bsddb.btopen(F, 'r')
except:
    it = bsddb.hashopen(F, 'r')
for k in it:
    if k.startswith('$1'): print k"
    }

    alias qi='rpm -qi'
    alias ql='rpm -ql'
    alias qa='rpm -qa'
    alias qag='rpm.qa | grep --color=auto -i'
    alias rpm.top='rpm -qa --qf "%-15{SIZE}%{NVRA}\n" | sort -nr | head'
    alias rpm.last='rpm -qa --last | less -XFR'

    if [[ -f /var/lib/rpm/Name ]]; then
        # fast version of rpm -qa for autocompletion
        _rpm_installed_packages() {
            COMPREPLY=( $( compgen -W "$(rpm.qa "$2")" -- "$2" ) )
        }
    fi
    complete -F _rpm_installed_packages ql i qi ye yu


    rpm.show_spec()
    {
        for f in "$@"; do
            rpm2cpio "$f" | cpio --to-stdout -i "*.spec"
        done
    }
fi #end of rpm
