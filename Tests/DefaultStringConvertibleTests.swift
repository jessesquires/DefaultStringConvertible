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

    func test_thatClass_providesDefaultDescription_1() {
        let c = MyClass1()
        let description = c.description

        XCTAssertEqual(description, "MyClass1(myString: \"my string var\", myInt: 666, myDouble: 42.0, myChar: c)")
        print("\n", c, "\n")
    }

    func test_thatClass_providesDefaultDescription_2() {
        let c = MyClass2()
        let description = c.description

        XCTAssertEqual(description, "MyClass2")
        print("\n", c, "\n")
    }

    func test_thatClass_providesDefaultDescription_3() {
        let c = MyClass3()
        let description = c.description

        XCTAssertEqual(description, "MyClass3(myBool: true, myString: \"my string var\", myInt: 0, myDouble: 42.0, myChar: c)")
        print("\n", c, "\n")
    }

    func test_thatClass_providesDefaultDescription_4() {
        let c = MyClass4()
        let description = c.description

        XCTAssertEqual(description, "MyClass4(myBool: true, myString: \"my string var\", myInt: 0, myDouble: 42.0, myChar: c)")
        print("\n", c, "\n")
    }

    func test_thatStruct_providesDefaultDescription_1() {
        let s = MyStruct1()
        let description = s.description

        XCTAssertEqual(description, "MyStruct1(myString: \"my string var\", myInt: 666, myDouble: 42.0, myChar: x, myBool: false)")
        print("\n", s, "\n")
    }
}



// MARK: Fakes

class MyClass1: CustomStringConvertible {

    let myString = "my string var"
    var myInt = 666
    let myDouble = 42.0
    let myChar = Character("c")
}


class MyClass2: CustomStringConvertible {
    
}


class MyClass3: MyClass1 {

    let myBool = true

    override init() {
        super.init()
        myInt = 0
    }
}


class MyClass4: MyClass3 {

}


struct MyStruct1: CustomStringConvertible {
    let myString = "my string var"
    var myInt = 666
    let myDouble = 42.0
    let myChar = Character("x")
    let myBool = false
}

