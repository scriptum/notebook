#!/usr/bin/env python
from __future__ import print_function
from timeit import timeit

setup = 'x = "Hello";y = "world"'
setup_big = 'x = "Hello"*100;y = "world"*100'

stmts = [
    'x + " " + y',
    '" ".join((x,y))',
    '" ".join([x,y])',
    '"%s %s" % (x, y)',
    '"{} {}".format(x, y)',
    '"{0} {1}".format(x, y)',
    '"{x} {y}".format(x=x, y=y)',
]
for stmt in stmts:
    print("{:30} {:.3f} {:.3f}".format(stmt, timeit(
        stmt, setup=setup), timeit(stmt, setup=setup_big)))
