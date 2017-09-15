# 1) print
# 2 - statement
# 3 - function

# version 3
print(type(print))              # <class 'builtin_function_or_method'>

# 2) dictionaries

# version 3
d = dict()
d = {1:1, 2:2, 3:3}
print(type(d.keys()))               # <class 'dict_keys'>
print(type(d.values()))             # <class 'dict_values'>
print(type(d.items()))              # <class 'dict_items'>


# 3) map & filter

l = [1, 2, 3, 4]
f = lambda x: x + 1
print(type(map(f, l)))              # <class 'map'>
print(type(filter(f, l)))           # <class 'filter'>


# 4) range
print(type(range(10)))              # <class 'range'>

print(type(zip(l, l)))              # <class 'zip'>

print("-"*40)
# 5) syntaxis
# 5.1 annotations

def foo(a: 'x', b: 5 + 6, c: list) -> max(2, 9):
    pass
print(foo.__annotations__.items())

def n_elem(n: int, l: list):
    return l[n]

print(n_elem.__annotations__)           # {'n': <class 'int'>, 'l': <class 'list'>}
print(n_elem.__annotations__.items())   # dict_items([('n', <class 'int'>), ('l', <class 'list'>)])

# 5.2 nonlocal
print("-"*40)
def outer():
   x = 1
   def inner():
       x = 2
       print("inner:", x)
   inner()
   print("outer:", x)

outer()
# inner: 2
# outer: 1


def outer():
   x = 1
   def inner():
       nonlocal x                       # give opportunity to change value of x in upper level method but not global
       x = 2
       print("inner:", x)
   inner()
   print("outer:", x)

outer()
#inner: 2
#outer: 2


# 5.3 PEP 3132: Extended Iterable Unpacking
print("-"*40)
(a, *rest, b) = range(5)
print(a)                        # 0
print(rest)                     # [1, 2, 3]
print(b)                        # 0

print("-"*40)


# 5.4 generator of dictionary

stuff = [(1, "first"), (2, "second")]
print(dict(stuff))                      # {1: 'first', 2: 'second'}
print({k:v for k,v in stuff})           # {1: 'first', 2: 'second'}

print("-"*40)

print(type({}))

