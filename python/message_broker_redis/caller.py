#!/usr/bin/env python
#-*- coding:utf-8 -*-

from __future__ import print_function
from mytasks import mytask

for i in range(1000):
    print(mytask.delay(str(i)).get())
