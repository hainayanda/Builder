//
//  Builder.swift
//  Builder
//
//  Created by Nayanda Haberty on 15/08/21.
//

import Foundation

public protocol Buildable {
    init()
}

public func builder<B: Buildable>(_ type: B.Type) -> Builder<B> {
    Builder(object: .init())
}

public func builder<Object>(_ object: Object) -> Builder<Object> {
    Builder(object: object)
}

@dynamicMemberLookup
public final class Builder<Object> {
    var object: Object
    
    init(object: Object) {
        self.object = object
    }
    
    public subscript<Property>(
        dynamicMember keyPath: WritableKeyPath<Object, Property>) -> PropertyAssigner<Object, Property, Builder<Object>> {
        return PropertyAssigner(keypathOwner: object, keyPath: keyPath) { value in
            self.object[keyPath: keyPath] = value
            return self
        }
    }
    
    public func build() -> Object { object }
}

@dynamicCallable
@dynamicMemberLookup
public final class PropertyAssigner<PropertyOwner, Property, ReturnValue> {
    var keypathOwner: PropertyOwner
    var keyPath: WritableKeyPath<PropertyOwner, Property>
    var parentAsigning: (Property) -> ReturnValue
    
    internal init(
        keypathOwner: PropertyOwner,
        keyPath: WritableKeyPath<PropertyOwner, Property>,
        whenAssigned parentAsigning: @escaping (Property) -> ReturnValue) {
        self.keypathOwner = keypathOwner
        self.keyPath = keyPath
        self.parentAsigning = parentAsigning
    }
    
    public func dynamicallyCall(withArguments arguments: [Property]) -> ReturnValue {
        parentAsigning(arguments[0])
    }
    
    public subscript<SubProperty>(
        dynamicMember keyPath: WritableKeyPath<Property, SubProperty>) -> PropertyAssigner<Property, SubProperty, ReturnValue> {
        var property = keypathOwner[keyPath: self.keyPath]
        return .init(keypathOwner: property, keyPath: keyPath) { value in
            property[keyPath: keyPath] = value
            return self.parentAsigning(property)
        }
    }
}
