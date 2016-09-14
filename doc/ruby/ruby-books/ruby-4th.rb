# 第二章 便利的对象
## Hash

将符号当做key来使用的时候
address = {name: "tcui", pinyin: "pinying", age:12}

#### symbol

sym = :foo
sym1 = :"foo"
sym == sym1     # true

## Regex

/cde/ =~ "abcdefg" # 2

i 表示忽略大小写
/cde/i =~ 'abCDEfg'

## nil
if and while 如果是false or nil 则认为是假，其余真

## Array#each
names = ['小林','name']
names.each do |name|
  if /林/ =~ name
    puts name
  end
end

# 第三章 创建命令

ARGV

puts "First param #{ARGV[0]}"

## Read File 会节省内存

filename = ARGV[0]
file = File.open(filename)
file.each_line do |line|
  puts line
end
file.close


## require 是代码替换


# 第四章 对象 变量 和常量

## variable 变量

- local variable [a-zA-Z_]
- global variable $
- instance variable @
- class variable @@

## 伪变量

nil, true, false, self

## 常量

TEST = 1

Module.methods.grep /count/
Module.constants.grep /test/i


## 多重赋值

a, b, c = 1,2,3

a, b, *c = 1,2,3,4,5
a = 1
b = 2
c = [3,4,5]

a, *b, c = 1,2,3,4,5
a = 1
b = [2,3,4]
c = 5

a, b = b, a

# 第五章 条件判断

array = ["a", 1, nil]

array.each do |item|

	case item
	when String
		puts "item is a String"
	when Numeric
		puts "item is a Numeric"
	else
		puts "item is something"
	end	

end

## 更加广义的相等  ===
# switch 中使用 ===

/zz/ === "xyzzy"
String === "xyzzy"

## if or unless 可以写在希望执行的代码后面

puts "ok" if a > b


## eql? or ==

1.0 == 1 # true
1.0.eql? 1 # false

在使用hash的时候，可能有用
hash = { 0 => "0"}

puts hash[0]	# "0"
puts hash[0.0]  # nil

# 第六章 循环

break next redo

# 第七章 方法

## 定义带块的方法

def myloop
	while true
		yield
	end
end

num = 1
myloop do
	puts "num is #{num}"
	break if num > 100
	num *= 2
end

## 参数不确定
def foo(*args)
	args
end

foo(2,3,4) #[2,3,4]

def a(a, *b, c)
	[a, b, c]
end

a(1,2,3,4,5) # [1,[2,3,4], 5]

def meth(x:0, y:0, z:0, **args)
	args
end


## 关键字参数
meth(x:2, y:3, z:1, a:1, b:2) #{:a => 4, :b => 2}

## 关键字参数 和 普通参数 相结合
def func(a, b:1, c:2)
end

func(1, b:2, c:3)

## 把hash 作为参数

def foo(arg)
	arg
end

foo {"a"=> 1, "b" => 2} #{"a" => 1, "b" => 2}
foo("a" => 1, "b" => 2) #{"a" => 1, "b" => 2}
foo(a:1, b:2) #{:a => 1, :b => 2}

# 第八章 Class  Module

array = []
str = "Hello"

array.class
str.class

array.instance_of? Array
str.instance_of? String

BasicObject
	Object
		Array
		String
		Hash
		Regexp
		IO
			File
		Dir
		Numeric
			Integer
				Fixnum
				Bignum
			Float
			Complex
			Rational
		Exception
		Time

str = "This is a string"
str.is_a? String # true
str.is_a? Object # true

## 类的创建

class HelloWorld
	def initialize(myname = "Ruby")
		@name = myname
	end

	def hello
		puts "Hello, #{@name}"
	end
end

## accessors

class HelloWorld
	def name
		@name
	end

	def name=(value)
		@name = value
	end
end

## 存取器的定义

attr_reader :name # name
attr_writer :name # name=(value)
attr_accessor :name


## 类方法

class << HelloWorld
	def hello(name)
		puts "#{name} said hello"
	end
end

HelloWorld.hello("John")

## 在class上下文中使用self时， 引用的对象是该类本身。
## 所以可以用  class << self ~ end

class HelloWorld
	class << self
		def hello
		end
	end
end

## 常量

class HelloWorld
	Version = "1.0"
end

puts HelloWorld::Version

## 类变量

class HelloCount
	@@count = 0
	def HelloCount.count
		@@count
	end

	def initialize(myname = "RUBY")
		@name = myname
	end

	def hello
		@@count += 1
	end
end

puts HelloCount.count
HelloCount.new("Bob").hello
puts HelloCount.count

## 方法的作用范围

public 
private
protected

class AccTest
	def pub
	end

	public :pub

	def priv
	end

	private :priv
end

class AccTest
	# 不指定参数时， 下面的方法都是ublic
	public

	def pub
	end

	private
	def priv
	end
end

class Point
	attr_accessor :x, :y
	protected :x=, :y=

	def initialize(x = 0.0, y = 0.0)
		@x, @y = x, y
	end

	def swap(other)
		temp_x, temp_y = @x, @y
		@x, @y = other.x, other.y
		other.x, other.y = temp_x, temp_y
		return self
	end
end

## 类扩展

## 类继承
class ClassName < SuperClassName
end

class RingArray < Array
	def [](i)
		idx = i % size
		super(idx)
	end
end

## 如果没有写明继承，则继承Object


## alias undef

class C2 < C1
	alias old_hello hello
	def hello
	end
end

## Module
 模块表现的就只是实物的行为部分

 - 模块不能拥有实例
 - 模块不能被继承

## Mix-in
就是将模块混合到类中

module HelloModule
	Version = "1.0"

	def hello(name)
	end

	module_function :hello
end

HelloModule::Version
HelloModule.hello "Alice"
include HelloModule
Version
hello "Alice"

mudule M
	def meth
	end
end

class C
	include M
end

c = C.new
c.meth
c.include? M # true

C的实例 会 C, M , C superclass的顺序查找方法
M 相当于虚拟父类

include 两次之后，第二次会被忽略

## extend

Object#extend

可以实现批量定义单例方法

module Edition
	def edition(n)
		"#{self} #{n}"
	end
end

str = "Ruby"
str.extend(Edition)

str.edition(5)

include 可以帮助我们突破继承的限制，通过模块扩展类的功能
extend 可以帮助我们跨过类，直接通过模块扩展对象的功能

module ClassMethods
	def cmethod
	end
end

module InstanceMethod
	def imethod
	end
end

class MyClass
	extend ClassMethods
	include InstanceMethods
end

MyClass.cmethod
MyClass.new.imethod

# 在 Ruby， 所有方法的执行，都需要通过作为接受者的某个对象的调用

# 面向对象的特征

1.封装
	用方法把数据包装起来，避免设置非法数据，产生异常
2.多态
	各个对象都有自己对消息的解释权
	一个方法名属于多个对象

# 鸭子类型
一种结合对象特征，灵活运用多态的思考方法——鸭子类型

能像鸭子走路，像鸭子叫，那就一定是鸭子
就是说
对象的特征不是由类和继承关系决定的，而是由对象本身具有什么样的行为决定的。

比如

def fetch_and_downcase(ary, index)
	if str = ary[index]
		return str.downcase
	end
end

ary 可以是 [1,2,3] 也可以是 {0=>"1"}

缺点是增加了程序运行前检查的困难
优点非常简单的使没有明确继承关系的对象之间的处理变得通用

只要能执行相同的操作，我们并不介意执行者是否一样

# 第九章 运算符

var || "Ruby"

var nil or false  # "Ruby"

name = var || "Ruby"

name = "Ruby"
if var
	name = var
end

item = nil
if ary
	item = ary[0]
end

item = ary && ary[0]

## 范围运算符

Range.new(1, 10)
1..10

在Range对象内部，可以使用succ方法根据起点值组个生成接下来的值

val = "a"
val.succ
val.succ

## 定义运算符

绝大多数可以定义或者重定义
但有一些不能  :: && || .. ... ?: not = and or

class Point
	attr_reader :x, :y

	def initialize(x = 0, y = 0)
		@x, @y = x, y
	end

	def +(other)
		self.class.new(x+other.x, y + other.y)
	end
end

## 一元运算符

class Point
	def +@
		dup
	end

	def -@
		self.class.new(-x,-y)
	end

	def ~@
		self.class.new(-y, x)
	end
end


## 下标方法

class Point
	def [](index)
		case index
		when 0
			x
		when 1
			y
		else
			raise ArgumentError, "out of range `#{index}`"
		end
	end

	def []=(index, val)
		case index
		when 0
			self.x = val
		when 1
			self.y = val
		else
			raise ArgumentError, "Error"
		end
	end
end

# 第十章 错误处理和异常

begin
	a()
	b()
	c()
rescue
	# error
ensure
	# somthing
end

$! 最后发生的异常（异常对象）
$@ 最后发生异常的位置信息

异常对象的方法
- class
- message
- backtrace ($@ = $!.backtrace)

## Retry

file = ARGV[0]

begin
	io = File.open(file)
rescue
	sleep 10
	retry
end

data = io.read
io.close

## 如果指定了无论如何都打不开的文件，程序会陷入死循环

n = Integer(val) rescure 0

## 类定义过程中使用rescure ensure

class Foo
	xxx
rescue => ex
	handle ex
ensure
	xxx
end

## 异常类

Exception
	SystemExit
	NoMemoryError
	SignalException
	ScriptError
		LoadError
		SyntaxError
		NotImplementedError
	StandardError
		RuntimeError
		SecurityError
		NameError
			NoMethodError
		IOError
			EOFError
		SystemCallError
			Errno::EPERM
			Errno::ENOENT

MyError = Class.new(StandardError)
MyError1 = Class.new(MyError)
MyError2 = Class.new(MyError)
MyError3 = Class.new(MyError)

## 主动抛出异常

raise message # RuntimeError
raise 异常类
raise 异常类， message

# 第11章 块

array = ["ruby", "Perl", "PHP", "Python"]
sorted = array.sort #["PHP", "Perl", "Python", "ruby"]

sorted = array.sort {|a, b| a<=> b}

sorted = array.sort_by {|a| a.length}

ary = %w(
Line a
line b
)


from.upto(to)
to.downto(from)
from.step(to, step)

def total(from, to)
	result = 0
	from.upto(to) do |num|
		if block_given?
			result += yield(num)
		else
			result += num
		end
	end
	result
end

total(1,10)
total(1,10) {|num| num ** 2}


## 把块封装成对象

Proc 对象 能让块作为对象在程序中使用的类

hello = Proc.new do |name|
	puts "#{name}"
end

hello.call "World"

## 把block从一个方法传给另一个方法
## 首先通过变量把block 作为Proc对象接受，然后再传给另一个方法
## 在方法定义时， 如果末尾的参数使用&参数名 Ruby就会自动把调用方法时传来的block封装成Proc对象

def total(from, to, &block)
	result = 0
	from.upto(to) do |num|
		if block
			result += block.call num
		else
			result += num
		end
	end
	result
end

total(1,10)
total(1,10) {|num| num ** 2}

# 第12章 数值类

Numeric   ->  	Integer			->		Fixnum
														->		Bignum
					->		Float
					->		Retional
					->		Complex


2.3.0 :066 > a = Rational(2,5)
 => (2/5) 
2.3.0 :067 > b = Rational(1,3)
 => (1/3) 
2.3.0 :068 > c = a+b
 => (11/15) 
2.3.0 :069 > c.to_f
=> 0.7333333333333333 

## 除法

5.div(2) # 2
5.div(2.2) # 2
-5.div(2) # -3

5.quo(2) # (5/2)

ans = x.divmod(y)

a, b = 5.divmod 2 # 2,1

## 随机数
Random.rand
Random.rand(100)

r1 = Random.new(1)

[r1.rand, r2.rand]

## 近似值误差

a = 0.1 + 0.2
b = 0.3
[a, b]
a == b

a = Rational(1, 10) + Rational(2, 10)
b = Rational(3, 10)
[a, b]
a == b

## Comparable

< <= == >= > between?

class Vector
	include Comparable

	attr_accessor :x, :y

	def initialize(x, y)
		@x, @y = x, y
	end

	def scalar
		Math.sqrt(x**2 + y**2)
	end

	def <=> (other)
		scalar <=> other.scalar
	end
end

# 第13章 数组类

## 创建数组

Array.new

Array.new(5) # [nil, nil, nil, nil, nil]

Array.new(5, 0) # [0,0,0,0,0]

## 使用%w 与 %i

lang = %w(Ruby Perl Python Scheme Pike REBOL)	# [String]
lang = %i(Ruby Perl Python Scheme Pike REBOL) # [Symbol]

a = (1..10).to_s
a.values_at(1,3,5)

## Array 方法

a.compact
a.compact!
a.delete(x)
a.delete_at(x)
a.delete_if{|item| ...}
a.reject{|item|...}
a.reject!{|item|...}

a.collect{|item|...}	# map
a.collect!{|item|...} # map
a.fill(value)
a.fill(value, begin)
a.fill(value, begin, to)
a.fill(value, n..m)
a.flatten
a.flatten!
a.each
a.each_with_index

a = Array.new(3) do
	[0,0,0]
end

a[0][1] = 2

result = []
ary1.zip(ary2, ary3) do |a, b,c|
	result << a + b + c
end

# 第14章 字符串类

















