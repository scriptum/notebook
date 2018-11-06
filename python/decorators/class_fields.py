from pprint import pprint
class A:
    "A class"
    x: int = 1
    y = 2 # type: int

print(A.__doc__)
print(A.__annotations__)
