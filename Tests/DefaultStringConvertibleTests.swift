//
//  Created by Jesse Squires
//  http://www.jessesquires.com
//
//
//  Documentation
//  http://jessesquires.com/DefaultStringConvertible
//
//
//  GitHub
//  https://github.com/jessesquires/DefaultStringConvertible
//
//
//  License
//  Copyright © 2016 Jesse Squires
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

import XCTest

import DefaultStringConvertible


final class DefaultStringConvertibleTests: XCTestCase {

    func test_thatClassProvidesDefaultDescription() {
        let c = MyClass()
        let description = c.description

        XCTAssertEqual(description, "MyClass(myString: \"my string var\", myInt: 666, myDouble: 42.0, myChar: c)")

        print("\n", c, "\n")
    }
}



// MARK: Fakes

class MyClass: CustomStringConvertible {

    let myString = "my string var"
    let myInt = 666
    let myDouble = 42.0
    let myChar = Character("c")
}