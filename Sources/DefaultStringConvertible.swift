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


/**
 A better default implementation of `description`.
 Displays the type name followed by all members with labels.
 Based on [this post](http://ericasadun.com/2016/04/18/default-reflection/).
 */
public extension CustomStringConvertible {

    /// Constructs and returns a detailed description of the receiver via its `Mirror`.
    public var defaultDescription: String {
        let mirror = Mirror(reflecting: self)
        var children = Array(mirror.children)
        
        var superclassMirror = mirror.superclassMirror()
        repeat {
            if let superChildren = superclassMirror?.children {
                children.appendContentsOf(superChildren)
            }
            superclassMirror = superclassMirror?.superclassMirror()
        } while superclassMirror != nil

        let chunks = children.map { (label: String?, value: Any) -> String in
            if let label = label {
                if value is String {
                    return "\(label): \"\(value)\""
                }
                return "\(label): \(value)"
            }
            return "\(value)"
        }

        if chunks.count > 0 {
            let chunksString = chunks.joinWithSeparator(", ")
            return "\(mirror.subjectType)(\(chunksString))"
        }

        return "\(self.dynamicType)"
    }

    /// Returns the value from `defaultDescription`.
    public var description: String {
        return defaultDescription
    }
}
