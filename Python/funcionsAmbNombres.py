import math

def absValue(x):
    if x < 0:
        return -x
    else: 
        return x

def power(x,p):
    return x ** p

def isPrime(x):
    if x < 2:
        return False
    else:
        aux = math.sqrt(x)
        for i in range(2,int(aux)+1):
            if (x % i) == 0:
                return False
        return True

def slowFib(n):
    if n == 0: return 0
    elif n == 1: return 1
    else: return slowFib(n-1) + slowFib(n-2)

def quickFib(n):
    a, b = 0, 1
    for _ in range(n):
        a, b = b, a+b
    return a
