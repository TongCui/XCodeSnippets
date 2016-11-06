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

# sort
a = [1,5,2,1,3]
a.sort()
a.sort(reverse = True)
a = ["a", "c", "B"]
sorted(a, key=str.lower, reverse = True)
sorted([i.lower() for i in a], reverse = True)

# equal or same
a = [1,2,3]
b = [1,2,3]

a == b # True
a is b # False

# true or false
'spam' # True
'' # False
[] # False
{} # False
1 # True
0.0 # False
None # False

# python syntax
1. 程序由模块组成
2. 模块包含语句
3. 语句包含表达式
4. 表达式建立并处理对象

# stdout
import sys
sys.stdout = open('log.txt', 'a')
print("hello, world")
sys.stdout.close()

# list
[x + y  for x in 'abc' for y in 'ABC']

# file
[line.upper() for line in open('test.txt')]
list(map(str.upper, open('test.txt')))

# some build in functions
sum([1,2,3])
any(['', 1, 2])
all(['', 1, 2])
max([1,2,3])
min([1,2,3])
a, *b = open('text.txt')
{line for line in open('text.txt') if line[0] == 'p'}

# intersect
s1 = "SPAM"
s2 = "SBAM"

#intersect(s1, s2)
[x for x in s1 if x in s2]








