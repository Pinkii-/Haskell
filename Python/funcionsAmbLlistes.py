import math

def myLength(L):
    x = 0
    for _ in L:
        x += 1
    return x

def myMaximum(L):
    myMax = L[0]
    for x in L:
        if x > myMax:
            myMax = x
    return myMax

def suma(L):
    suma = 0.0;
    for x in L:
        suma += x
    return suma

def average(L):
    return suma(L)/myLength(L)

def buildPalindrome(L):
    L2 = L[:]
    for x in L:
        L2.insert(0,x)
    return L2

def remove(L1, L2):
    for x in L1[:]:
        b = False
        for y in L2:
            if x == y:
                b = True
                break
        if b:
            L1.remove(x)
    return L1

def flatten(L):
    if isinstance(L,list):
        L1 = []
        for l in L:
            L2 = flatten(l)
            if isinstance(L2,list):
                for l2 in L2:
                    L1.append(l2)
            else:
                L1.append(L2)
        return L1
    else:
        return L

def oddsNevens(L):
    odds = []
    evens = []
    for l in L:
        if l%2==0:
            odds.append(l)
        else:
            evens.append(l)
    aux = (evens,odds)
    return aux

def primeDivisors(n):
    divisible = True
    L=[]
    number = n
    while divisible:
        saux = math.sqrt(number)
        baux = False
        for i in range(2,int(saux)+1):
            if (number % i) == 0:
                L.append(i)
                baux = True
                while (number % i == 0): number = number/i
                break
        divisible = baux
    if (number != 1): L.append(number)
    return L
