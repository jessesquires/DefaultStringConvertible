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

    /// Constructs and returns a recursive (Playground-sidebar-esque) description of the receiver
    public var deepDescription: String {
        return DefaultStringConvertible.deepDescription(self)
    }

    /// Returns the value from `defaultDescription`.
    public var description: String {
        return defaultDescription
    }
}

private func deepDescription(any: Any) -> String {
    func indentedString(string: String) -> String {
        return string.characters
            .split("\r")
            .map(String.init)
            .map { $0.isEmpty ? "" : "\r    \($0)" }
            .joinWithSeparator("")
    }

    func deepUnwrap(any: Any) -> Any? {
        let mirror = Mirror(reflecting: any)

        if mirror.displayStyle != .Optional {
            return any
        }

        if let child = mirror.children.first where child.label == "Some" {
            return deepUnwrap(child.value)
        }

        return nil
    }

    guard let any = deepUnwrap(any) else {
        return "nil"
    }

    if any is Void {
        return "Void"
    }

    if let int = any as? Int {
        return String(int)
    } else if let double = any as? Double {
        return String(double)
    } else if let float = any as? Float {
        return String(float)
    } else if let bool = any as? Bool {
        return String(bool)
    } else if let string = any as? String {
        return "\"\(string)\""
    }

    let mirror = Mirror(reflecting: any)

    var properties = Array(mirror.children)

    var typeName = String(mirror.subjectType)
    if typeName.hasSuffix(".Type") {
        typeName = ""
    } else { typeName = "<\(typeName)> " }

    guard let displayStyle = mirror.displayStyle else {
        return "\(typeName)\(String(any))"
    }

    switch displayStyle {
    case .Tuple:
        if properties.isEmpty { return "()" }

        var string = "("

        for (index, property) in properties.enumerate() {
            if property.label!.characters.first! == "." {
                string += deepDescription(property.value)
            } else {
                string += "\(property.label!): \(deepDescription(property.value))"
            }

            string += (index < properties.count - 1 ? ", " : "")
        }

        return string + ")"
    case .Collection, .Set:
        if properties.isEmpty { return "[]" }

        var string = "["

        for (index, property) in properties.enumerate() {
            string += indentedString(deepDescription(property.value) + (index < properties.count - 1 ? ",\r" : ""))
        }

        return string + "\r]"
    case .Dictionary:
        if properties.isEmpty { return "[:]" }

        var string = "["

        for (index, property) in properties.enumerate() {
            let pair = Array(Mirror(reflecting: property.value).children)

            string += indentedString("\(deepDescription(pair[0].value)): \(deepDescription(pair[1].value))" + (index < properties.count - 1 ? ",\r" : ""))
        }

        return string + "\r]"
    case .Enum:
        if let any = any as? CustomDebugStringConvertible {
            return any.debugDescription
        }

        if properties.isEmpty { return "\(mirror.subjectType)." + String(any) }

        var string = "\(mirror.subjectType).\(properties.first!.label!)"

        let associatedValueString = deepDescription(properties.first!.value)

        if associatedValueString.characters.first! == "(" {
            string += associatedValueString
        } else {
            string += "(\(associatedValueString))"
        }

        return string
    case .Struct, .Class:
        if let any = any as? CustomDebugStringConvertible {
            return any.debugDescription
        }

        var superclassMirror = mirror.superclassMirror()
        repeat {
            if let superChildren = superclassMirror?.children {
                properties.appendContentsOf(superChildren)
            }

            superclassMirror = superclassMirror?.superclassMirror()
        } while superclassMirror != nil

        if properties.isEmpty { return "\(typeName)\(String(any))" }

        var string = "\(typeName){"

        for (index, property) in properties.enumerate() {
            string += indentedString("\(property.label!): \(deepDescription(property.value))" + (index < properties.count - 1 ? ",\r" : ""))
        }

        return string + "\r}"
    case .Optional: fatalError()
    }
}
