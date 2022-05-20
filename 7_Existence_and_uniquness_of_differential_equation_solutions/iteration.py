#!/usr/bin/env python3

def f(x):
    return x**2

def f_ntimes(x, n):
    for i in range(1, n):
        x = f(x)
    return x

x0 = 2

for i in range(2, 10):
    print(f_ntimes(x0, i))
