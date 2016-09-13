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












