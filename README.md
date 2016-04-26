# DefaultStringConvertible
[![Build Status](https://secure.travis-ci.org/jessesquires/DefaultStringConvertible.svg)](http://travis-ci.org/jessesquires/DefaultStringConvertible) [![Version Status](https://img.shields.io/cocoapods/v/DefaultStringConvertible.svg)][podLink] [![license MIT](https://img.shields.io/cocoapods/l/DefaultStringConvertible.svg)][mitLink] [![codecov.io](https://img.shields.io/codecov/c/github/jessesquires/DefaultStringConvertible.svg)](http://codecov.io/github/jessesquires/DefaultStringConvertible) [![Platform](https://img.shields.io/cocoapods/p/DefaultStringConvertible.svg)][docsLink] [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

*A default `CustomStringConvertible` implementation for Swift types*

## About 

Never implement `var description: String` again. Simply `import DefaultStringConvertible` and conform to `CustomStringConvertible` and get a default type description for free.

> **This micro-library is based on [this post](http://ericasadun.com/2016/04/18/default-reflection/) from Erica Sadun.**

## Requirements

* Xcode 7.3+
* iOS 8.0+
* OSX 10.10+
* tvOS 9.0+
* watchOS 2.0+
* Swift 2.2+

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

## Documentation

Read the [docs][docsLink]. Generated with [jazzy](https://github.com/realm/jazzy). Hosted by [GitHub Pages](https://pages.github.com). More information on the [`gh-pages`](https://github.com/jessesquires/DefaultStringConvertible/tree/gh-pages) branch.

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

There's a suite of unit tests for `DefaultStringConvertible`. Run them from Xcode by opening `DefaultStringConvertible.xcodeproj`. These tests are well commented and serve as further documentation for how to use this library.

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
