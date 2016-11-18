# DefaultStringConvertible
[![Build Status](https://secure.travis-ci.org/jessesquires/DefaultStringConvertible.svg)](http://travis-ci.org/jessesquires/DefaultStringConvertible) [![Version Status](https://img.shields.io/cocoapods/v/DefaultStringConvertible.svg)][podLink] [![license MIT](https://img.shields.io/cocoapods/l/DefaultStringConvertible.svg)][mitLink] [![codecov](https://codecov.io/gh/jessesquires/DefaultStringConvertible/branch/develop/graph/badge.svg)](https://codecov.io/gh/jessesquires/DefaultStringConvertible) [![Platform](https://img.shields.io/badge/platform-Linux%20%7C%20macOS%20%7C%20iOS%20%7C%20watchOS%20%7C%20tvOS-lightgrey.svg)][docsLink] [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

*A default `CustomStringConvertible` implementation for Swift types*

## About

Never implement `var description: String` again. Simply `import DefaultStringConvertible` and conform to `CustomStringConvertible` and get a default type description for free.

> **This micro-library is based on [this post](http://ericasadun.com/2016/04/18/default-reflection/) from Erica Sadun.**

## Requirements

* Swift 3
* Xcode 8
* iOS 8.0+
* OSX 10.10+
* tvOS 9.0+
* watchOS 2.0+
* Ubuntu 14.04+

## Installation

#### [CocoaPods](http://cocoapods.org) (recommended)

````ruby
use_frameworks!

# For latest release in cocoapods
pod 'DefaultStringConvertible'

# Feeling adventurous? Get the latest on develop
pod 'DefaultStringConvertible', :git => 'https://github.com/jessesquires/DefaultStringConvertible.git', :branch => 'develop'
````

#### [Carthage](https://github.com/Carthage/Carthage)

````bash
github "jessesquires/DefaultStringConvertible"
````

#### [Swift Package Manager](https://github.com/apple/swift-package-manager)

Add DefaultStringConvertible as a dependency to your `Package.swift`. For example:

````swift
let package = Package(
    name: "YourPackageName",
    dependencies: [
        .Package(url: "https://github.com/jessesquires/DefaultStringConvertible.git", majorVersion: 2)
    ]
)
````

## Documentation

Read the [docs][docsLink]. Generated with [jazzy](https://github.com/realm/jazzy). Hosted by [GitHub Pages](https://pages.github.com).

#### Generate

````bash
$ ./build_docs.sh
````

#### Preview

````bash
$ open index.html -a Safari
````

## Getting Started

````swift
import DefaultStringConvertible

class MyClass: CustomStringConvertible {
    // ...

    // You *do not* need to implement `var description: String`
    // by importing `DefaultStringConvertible`, you get a default `description` for free
}
````

## Unit tests

There's a suite of unit tests for `DefaultStringConvertible`. Run them from Xcode by opening `DefaultStringConvertible.xcodeproj`.

## Contribute

Please follow these sweet [contribution guidelines](https://github.com/jessesquires/HowToContribute).

## Credits

Created and maintained by [**@jesse_squires**](https://twitter.com/jesse_squires).

## License

`DefaultStringConvertible` is released under an [MIT License][mitLink]. See `LICENSE` for details.

>**Copyright &copy; 2016-present Jesse Squires.**

*Please provide attribution, it is greatly appreciated.*

[podLink]:https://cocoapods.org/pods/DefaultStringConvertible
[docsLink]:http://www.jessesquires.com/DefaultStringConvertible
[mitLink]:http://opensource.org/licenses/MIT
