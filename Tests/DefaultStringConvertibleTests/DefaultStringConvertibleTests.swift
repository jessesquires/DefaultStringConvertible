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
import Foundation
import DefaultStringConvertible


final class DefaultStringConvertibleTests: XCTestCase {

    static var allTests = {
        return [
            ("test_thatClass_providesDefaultDescription_1", test_thatClass_providesDefaultDescription_1),
            ("test_thatClass_providesDefaultDescription_2", test_thatClass_providesDefaultDescription_2),
            ("test_thatClass_providesDefaultDescription_3", test_thatClass_providesDefaultDescription_3),
            ("test_thatClass_providesDefaultDescription_4", test_thatClass_providesDefaultDescription_4),
            ("test_thatStruct_providesDefaultDescription_1", test_thatStruct_providesDefaultDescription_1),
            ("test_thatStruct_providesCustomDescription", test_thatStruct_providesCustomDescription),
            ("test_thatStruct_providesDeepDescription", test_thatStruct_providesDeepDescription),
            ("test_thatEnum_providesDeepDescription", test_thatEnum_providesDeepDescription),
            ("test_thatClass_providesDeepDescription", test_thatClass_providesDeepDescription),
            ("test_thatInherittingClass_providesDeepDescription", test_thatInherittingClass_providesDeepDescription),
            ("test_thatDictionary_providesDeepDescription", test_thatDictionary_providesDeepDescription)
        ]
    }()

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

    func test_thatStruct_providesCustomDescription() {
        let v = OtherStruct()
        let deepDescription = v.description

        XCTAssertEqual(deepDescription, "OtherStruct: override description")
        print("\n", deepDescription, "\n")

    }

    func test_thatStruct_providesDeepDescription() {
        let v = SomeStruct(prop1: 4, prop2: "hey there", optionalProp: 2.71828)
        let deepDescription = v.deepDescription

        XCTAssertEqual(deepDescription, "<SomeStruct> {\r    prop1: 4,\r    prop2: \"hey there\",\r    optionalProp: 2.71828\r}")
        print("\n", deepDescription, "\n")

    }

    func test_thatEnum_providesDeepDescription() {
        let v = SomeEnum.case3(value1: nil)
        let deepDescription = v.deepDescription

        XCTAssertEqual(deepDescription, "SomeEnum.case3(nil)")
        print("\n", deepDescription, "\n")

    }

    func test_thatClass_providesDeepDescription() {

        let v = SomeClass(prop1: [1, 2, 3], prop2: [0, "hello world", [String : String]()], optionalProp: 2.71828)

        let deepDescription = v.deepDescription

        XCTAssertEqual(deepDescription,
                       "<SomeClass> {\r    prop1: [\r        1,\r        2,\r        3\r    ],\r    prop2: "
                        + "[\r        0,\r        \"hello world\",\r        [:]\r    ],\r    optionalProp: 2.71828\r}")
        print("\n", deepDescription, "\n")
    }

    func test_thatInherittingClass_providesDeepDescription() {
        let v = InheritingClass(
            prop1: [0],
            prop2: [SomeClass.self, InheritingClass.self],
            prop3: .case2(value1: -1, value2: false),
            prop4: [0, "goodbye", 0.66],
            prop5: (6.66, "stringgg"),
            optionalProp: 2.71828
        )
        let deepDescription = v.deepDescription

        XCTAssertEqual(deepDescription,
                       "<InheritingClass> {\r    prop3: SomeEnum.case2(-1, false),\r    prop4: [\r        0,\r"
                        + "        \"goodbye\",\r        0.66\r    ],\r    prop5: (6.66, \"stringgg\"),\r    prop1: [\r        0\r    ],\r"
                        + "    prop2: [\r        SomeClass,\r        InheritingClass\r    ],\r    optionalProp: 2.71828\r}")
        print("\n", deepDescription, "\n")
    }

    func test_thatDictionary_providesDeepDescription() {
        let v: [String: Any] = [
            "someClass": SomeClass(prop1: [1, 2, 3], prop2: [0, "hello world"], optionalProp: 2.71828),
            ]
        let deepDescription = v.deepDescription

        XCTAssertEqual(deepDescription,
                       "[\r    \"someClass\": <SomeClass> {\r        prop1: [\r            1,\r            2,\r            3\r"
                        + "        ],\r        prop2: [\r            0,\r            \"hello world\"\r        ],\r        optionalProp: 2.71828\r    }\r]")
        print("\n", deepDescription, "\n")
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


struct SomeStruct: CustomStringConvertible {
    let prop1: Int
    let prop2: String
    var optionalProp: Double?
}


enum SomeEnum: CustomStringConvertible {
    case case1
    case case2(value1: Int, value2: Bool)
    case case3(value1: String?)
}


class SomeClass: CustomStringConvertible {
    let prop1: [Int]
    var prop2: [Any]
    var optionalProp: Double?
    
    init(prop1: [Int], prop2: [Any], optionalProp: Double?) {
        self.prop1 = prop1
        self.prop2 = prop2
        self.optionalProp = optionalProp
    }
}

class InheritingClass: SomeClass {
    let prop3: SomeEnum
    let prop4: [Any]
    let prop5: (Double, String)

    init(prop1: [Int],
         prop2: [Any],
         prop3: SomeEnum,
         prop4: [Any],
         prop5: (Double, String),
         optionalProp: Double?) {
        
        self.prop3 = prop3
        self.prop4 = prop4
        self.prop5 = prop5
        super.init(prop1: prop1, prop2: prop2, optionalProp: optionalProp)
    }
}

struct OtherStruct: CustomStringConvertible {
    var description: String {
        return "OtherStruct: override description"
    }
}
