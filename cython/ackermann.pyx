#!/usr/bin/env cpython
cdef inline int ackermann(int m, int n):
    if m == 0:
        return n + 1
    elif n == 0:
        return ackermann(m - 1, 1)
    else:
        return ackermann(m - 1, ackermann(m, n - 1))

print("Ackermann:")
print(ackermann(0, 3))
print(ackermann(1, 4))
