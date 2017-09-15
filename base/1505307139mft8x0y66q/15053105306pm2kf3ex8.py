# 1) print
# 2 - statement
# 3 - function

#print(type(print))

# 2) dictionaries

# version 2
d = dict()
d = {1:1, 2:2, 3:3}
print(type(d.keys()))           # list
print(type(d.values()))         # list
print(type(d.items()))          # list

# 3) map & filter

l = [1, 2, 3, 4]
f = lambda x: x + 1
print(type(map(f, l)))          # list
print(type(filter(f, l)))       # list



# 4) range
print(type(range(10)))          # list

print(type(zip(l, l)))          # list

print(type({}))

s = 'something else'
sum_all = reduce(lambda x,y: x + y, filter(lambda x: not x == 's', s))
print(sum_all)