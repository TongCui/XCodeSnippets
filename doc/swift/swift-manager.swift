# [Blog](https://quickleft.com/blog/swift-package-manager/) 

## What is a Package Manager?

A package manager is a tool that simplifies the process of working with code from multiple sources. Specifically, it needs to:

- Define what a “package” actually is.
- Define how packages are accessed.
- Allow packages to be versioned.
- Manage dependencies.
- Link code to its dependencies.


## What is a Swift Package?

To understand packages in Swift, you first need to understand that Swift is designed around the concept of “modules.” A module is a collection of source files that are compiled together as a unit. For an iOS app, that would be the files that make up the app. For a Swift package, the module contains package’s the source code files.

## Version

- 1.x   1.1.x
- ~>2.0.1 Version(2, 0, 1) ..< Version(2, 1, 0)


