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
        return generateDefaultDescription(self)
    }

    /// Constructs and returns a recursive description of the receiver, similar to a Playgrounds sidebar description.
    public var deepDescription: String {
        return generateDeepDescription(self)
    }

    /// Returns the value from `defaultDescription`.
    public var description: String {
        return defaultDescription
    }
}


private func generateDefaultDescription(_ any: Any) -> String {
    let mirror = Mirror(reflecting: any)
    var children = Array(mirror.children)

    var superclassMirror = mirror.superclassMirror
    repeat {
        if let superChildren = superclassMirror?.children {
            children.append(contentsOf: superChildren)
        }
        superclassMirror = superclassMirror?.superclassMirror
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
        let chunksString = chunks.joined(separator: ", ")
        return "\(mirror.subjectType)(\(chunksString))"
    }

    return "\(type(of: any))"
}


private func generateDeepDescription(_ any: Any) -> String {

    func indentedString(_ string: String) -> String {
        return string.characters
            .split(separator: "\r")
            .map(String.init)
            .map { $0.isEmpty ? "" : "\r    \($0)" }
            .joined(separator: "")
    }

    func deepUnwrap(_ any: Any) -> Any? {
        let mirror = Mirror(reflecting: any)

        if mirror.displayStyle != .optional {
            return any
        }

        if let child = mirror.children.first , child.label == "some" {
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

    var typeName = String(describing: mirror.subjectType)
    if typeName.hasSuffix(".Type") {
        typeName = ""
    } else { typeName = "<\(typeName)> " }

    guard let displayStyle = mirror.displayStyle else {
        return "\(typeName)\(String(describing: any))"
    }

    switch displayStyle {
    case .tuple:
        if properties.isEmpty { return "()" }

        var string = "("

        for (index, property) in properties.enumerated() {
            if property.label!.characters.first! == "." {
                string += generateDeepDescription(property.value)
            } else {
                string += "\(property.label!): \(generateDeepDescription(property.value))"
            }

            string += (index < properties.count - 1 ? ", " : "")
        }
        return string + ")"

    case .collection, .set:
        if properties.isEmpty { return "[]" }

        var string = "["

        for (index, property) in properties.enumerated() {
            string += indentedString(generateDeepDescription(property.value) + (index < properties.count - 1 ? ",\r" : ""))
        }
        return string + "\r]"

    case .dictionary:
        if properties.isEmpty {
            return "[:]"
        }

        var string = "["
        for (index, property) in properties.enumerated() {
            let pair = Array(Mirror(reflecting: property.value).children)
            string += indentedString("\(generateDeepDescription(pair[0].value)): \(generateDeepDescription(pair[1].value))"
                + (index < properties.count - 1 ? ",\r" : ""))
        }
        return string + "\r]"

    case .enum:
        if let any = any as? CustomDebugStringConvertible {
            return any.debugDescription
        }

        if properties.isEmpty {
            return "\(mirror.subjectType)." + String(describing: any)
        }

        var string = "\(mirror.subjectType).\(properties.first!.label!)"
        let associatedValueString = generateDeepDescription(properties.first!.value)

        if associatedValueString.characters.first! == "(" {
            string += associatedValueString
        } else {
            string += "(\(associatedValueString))"
        }
        return string

    case .struct, .class:
        if let any = any as? CustomDebugStringConvertible {
            return any.debugDescription
        }

        var superclassMirror = mirror.superclassMirror
        repeat {
            if let superChildren = superclassMirror?.children {
                properties.append(contentsOf: superChildren)
            }

            superclassMirror = superclassMirror?.superclassMirror
        } while superclassMirror != nil

        if properties.isEmpty { return "\(typeName)\(String(describing: any))" }
        var string = "\(typeName){"
        for (index, property) in properties.enumerated() {
            string += indentedString("\(property.label!): \(generateDeepDescription(property.value))" + (index < properties.count - 1 ? ",\r" : ""))
        }
        return string + "\r}"

    case .optional:
        return generateDefaultDescription(any)
    }
}

// Since these methods are not available in Linux
#if !(os(macOS) || os(iOS) || os(watchOS) || os(tvOS))
    extension String {

        public func hasPrefix(_ prefix: String) -> Bool {
            return prefix == String(characters.prefix(prefix.characters.count))
        }
        
        public func hasSuffix(_ suffix: String) -> Bool {
            return suffix == String(characters.suffix(suffix.characters.count))
        }
    }
#endif
