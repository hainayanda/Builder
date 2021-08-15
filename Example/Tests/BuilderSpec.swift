//
//  BuilderSpec.swift
//  Builder_Tests
//
//  Created by Nayanda Haberty on 15/08/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Builder

class BuilderSpec: QuickSpec {
    override func spec() {
        describe("builder spec") {
            it("should build Buildable class by type") {
                let object = builder(DummyObject.self)
                    .int(10)
                    .subObject.string("inside class")
                    .subStruct.string("inside struct")
                    .build()
                expect(object.int).to(equal(10))
                expect(object.subObject.string).to(equal("inside class"))
                expect(object.subStruct.string).to(equal("inside struct"))
            }
            it("should build Buildable struct by type") {
                let object = builder(DummyStruct.self)
                    .int(10)
                    .subObject.string("inside class")
                    .subStruct.string("inside struct")
                    .build()
                expect(object.int).to(equal(10))
                expect(object.subObject.string).to(equal("inside class"))
                expect(object.subStruct.string).to(equal("inside struct"))
            }
            it("should build Buildable class by object passed") {
                let object = builder(DummyObject())
                    .int(10)
                    .subObject.string("inside class")
                    .subStruct.string("inside struct")
                    .build()
                expect(object.int).to(equal(10))
                expect(object.subObject.string).to(equal("inside class"))
                expect(object.subStruct.string).to(equal("inside struct"))
            }
            it("should build Buildable struct by object passed") {
                let object = builder(DummyStruct())
                    .int(10)
                    .subObject.string("inside class")
                    .subStruct.string("inside struct")
                    .build()
                expect(object.int).to(equal(10))
                expect(object.subObject.string).to(equal("inside class"))
                expect(object.subStruct.string).to(equal("inside struct"))
            }
        }
    }
}

fileprivate class DummyObject: Buildable {
    var int: Int = 0
    var subObject: SubObject = .init()
    var subStruct: SubStruct = .init()
    
    required init() { }
    
    class SubObject {
        var string: String  = ""
    }
    
    class SubStruct {
        var string: String = ""
    }
}

fileprivate class DummyStruct: Buildable {
    var int: Int = 0
    var subObject: SubObject = .init()
    var subStruct: SubStruct = .init()
    
    required init() { }
    
    class SubObject {
        var string: String  = ""
    }
    
    class SubStruct {
        var string: String = ""
    }
}
