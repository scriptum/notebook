#!/usr/bin/env python
#-*- coding:utf-8 -*-

from __future__ import print_function


class Base(object):
    """Base class

    Just a base class
    """

    def __init__(self):
        print("      Base init")


class ChildA(Base):
    """Child class A

    Doesn't user super()
    """

    def __init__(self):
        print("    A init")
        Base.__init__(self)


class ChildB(Base):
    """Child class B

    Use super()
    """

    def __init__(self):
        print("    B init")
        super(ChildB, self).__init__()


class InjectedClass(Base):
    """Class to be injected between base and child
    """

    def __init__(self):
        print("     InjectedClass init")
        super(InjectedClass, self).__init__()

# ChildB users super while ChildA doesn't:


class UserA(ChildA, InjectedClass):
    def __init__(self):
        print("  UserA init")
        super(UserA, self).__init__()


class UserB(ChildB, InjectedClass):
    def __init__(self):
        print("  UserB init")
        super(UserB, self).__init__()


print("Without super:")
UserA()
# Without super:
#   UserA init
#     A init
#       Base init

print("With super:")
UserB()
# With super:
#   UserB init
#     B init
#      InjectedClass init
#       Base init
