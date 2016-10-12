# [swiftenv](https://github.com/kylef/swiftenv)

## Installation

```
$ brew install kylef/formulae/swiftenv
$ echo 'if which swiftenv > /dev/null; then eval "$(swiftenv init -)"; fi' >> ~/.bash_profile
```

## Usage

```
$ swift version
$ swift versions
$ swift global 3.0
$ swiftenv global
3.0
$ swiftenv local 3.0
$ swiftenv local
3.0
$ swiftenv install 3.0
$ swiftenv uninstall 3.0
# Installs shims for the Swift binaries. This command should be ran after you manually install new versions of Swift.
$ swiftenv rehash
# Displays the full path to the executable that would be invoked for the selected version for the given command.
$ swiftenv which swift
/home/kyle/.swiftenv/versions/3.0/usr/bin/swift

$ swiftenv which lldb
/home/kyle/.swiftenv/versions/3.0/usr/bin/lldb
```

# Swift org

## Getting Started

#### Using the Package Manager

```
$ mkdir Hello
$ cd Hello
$ swift package init
$ swift build
$ swift test
```

#### Building an Executable

```
$ swift package init --type executable
```

```
main.swift

if CommandLine.arguments.count != 2 {
    print("Usage: hello NAME")
} else {
    let name = CommandLine.arguments[1]
    sayHello(name: name)
}

```

#### Using the LLDB Debugger

Factorial.swift
```
func factorial(n: Int) -> Int {
    if n <= 1 { return n }
    return n * factorial(n: n - 1)
}

let number = 4
print("\(number)! is equal to \(factorial(n: number))")

```

command line

```

$ swiftc -g Factorial.swift
$ ls
Factorial.dSYM
Factorial.swift
Factorial*
$ lldb Factorial

(lldb) b 2
(lldb) r
(lldb) p n * n
(Int) $R1 = 16
(lldb) bt
(lldb) br di
(lldb) c

```
















