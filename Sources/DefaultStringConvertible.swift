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


/// A better default implementation of `description`. 
/// Displays the type name followed by all members with labels.
/// Based on [this post](http://ericasadun.com/2016/04/18/default-reflection/).
public extension CustomStringConvertible {

    /**
     Constructs a detailed description of the receiver via its `Mirror`.

     - parameter instance: The caller.

     - returns: A detailed description of the receiver
     */
    public func defaultDescription<T>(instance: T) -> String {
        let mirror = Mirror(reflecting: instance)
        let chunks = mirror.children.map({
            (label: String?, value: Any) -> String in
            if let label = label {
                if value is String {
                    return "\(label): \"\(value)\""
                }
                return "\(label): \(value)"
            } else {
                return "\(value)"
            }
        })

        if chunks.count > 0 {
            let chunksString = chunks.joinWithSeparator(", ")
            return "\(mirror.subjectType)(\(chunksString))"
        }

        return "\(instance)"
    }

    /// Returns the value from `defaultDescription`.
    public var description: String {
        return defaultDescription(self)
    }
}
