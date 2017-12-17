# pretty-print and verify yaml file
yaml.lint()
{
    < "$1" python -c 'import sys, pprint, yaml; pprint.pprint(yaml.load(sys.stdin), width=1)' | less -XFR
}
