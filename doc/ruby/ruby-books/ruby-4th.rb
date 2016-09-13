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








































































































