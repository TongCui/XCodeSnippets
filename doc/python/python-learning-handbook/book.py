#!/usr/bin/env python

# import this
import this

# input
a = input()
> book
# a = "book"

# reload module
from imp import reload
reload(xxx)

# debug
pdb

# random
import random
random.random()
random.choice([1,2,3,4])
random.randomint(1,10)

# string
immutable

s.find('pa')
s.replace('pa','ab')
s.split('.')
s.upper()
s.isalpha()
s.rstrip()

"%s = %s" % ('a', 'b')
"{0} = {1}".format('a', 'b')


# dir
dir('s')

help('s'.replace)

# list comprehension expression
M = [[1,2,3], [4,5,6], [7,8,9]]
[row[1] for row in M]
[row[1] for row in M if row[1] % 2 == 0]

[ord(x) for x in 'spaam']
{ord(x) for x in 'spaam'}
{x : ord(x) for x in 'spaam'}


# number
3//2
3/2
x < y < z #  x < y and y < z
int(3.14159)
float(3)

# echos and prints
num = 1/3
repr(num)
str(num)

# format
"%o, %x, %X" % (64, 255, 255)
"{0:o}, {1:x}, {2:X}".format(64, 255, 255)

# math
import math
math.pi
math.e

# sqrt
import math
math.sqrt(144)
144 ** 0.5
pow(144, 0.5)

# Fractions
from fractions import fraction
x = Franction(1,3)
