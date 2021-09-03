//
//  Builder.swift
//  Builder
//
//  Created by Nayanda Haberty on 15/08/21.
//

import Foundation

public func builder<B: Buildable>(_ type: B.Type) -> Builder<B> {
    Builder(type)
}

public func builder<Object>(_ object: Object) -> Builder<Object> {
    Builder(object)
}

@dynamicMemberLookup
public final class Builder<Object> {
    var object: Object
    
    init(_ object: Object) {
        self.object = object
    }
    
    public subscript<Property>(
        dynamicMember keyPath: KeyPath<Object, Property>) -> PropertyAssigner<Object, Property, Builder<Object>> {
        return PropertyAssigner(keypathOwner: object, keyPath: keyPath) { value, assignType  in
            switch assignType {
            case .directAssign:
                break;
            case .toParent:
                if Property.self is AnyClass {
                    return self
                }
                break;
            case .error:
                return self
            }
            guard let writable = keyPath as? WritableKeyPath<Object, Property> else {
                errorHappens("Failed to assign property keypath of \(String(describing: Object.self)) with property type \(String(describing: Property.self)) because its not writable")
                return self
            }
            self.object[keyPath: writable] = value
            return self
        }
    }
    
    public func build() -> Object { object }
}

public extension Builder where Object: Buildable {
    convenience init(_ type: Object.Type) {
        self.init(.init())
    }
}
