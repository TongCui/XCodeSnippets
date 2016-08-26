[Examples of using RVM](https://rvm.io/workflow/examples)

### RVM version

```
$ rvm -v
```
### Use a particular Ruby.

```
$ rvm use 2.1.1
```

### List Ruby interpreters available for installation

```
$ rvm list known
```

### List Ruby interpreters you've already installed

```
$ rvm list
```

### Ruby information for the current shell

```
$ rvm info
```
  
### Use Ruby 2.1.1

```
$  rvm use 2.1.1
```
### Equivalent to "rvm use 2.1.1", due to defaults

```
$  rvm 2.1.1
```

### Switch to gems directory for current ruby

```
$ rvm gemdir
```
```
$ rvm gemdir system
```

### Use the user set default ruby
```
$  rvm default
```

### Use the system ruby (as if no rvm)

```
$  rvm system
```
### Reset to pre-RVM state.

```
$  rvm reset
```
### Uninstall RVM installed 2.0.0 version
```
$  rvm uninstall 2.0.0
```

