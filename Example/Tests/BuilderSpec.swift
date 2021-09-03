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
                    .subObjectLet.string("inside class")
                    .build()
                expect(object.int).to(equal(10))
                expect(object.subObject.string).to(equal("inside class"))
                expect(object.subStruct.string).to(equal("inside struct"))
                expect(object.subObjectLet.string).to(equal("inside class"))
            }
            it("should build Buildable struct by type") {
                let object = builder(DummyStruct.self)
                    .int(10)
                    .subObject.string("inside class")
                    .subStruct.string("inside struct")
                    .subObjectLet.string("inside class")
                    .build()
                expect(object.int).to(equal(10))
                expect(object.subObject.string).to(equal("inside class"))
                expect(object.subStruct.string).to(equal("inside struct"))
                expect(object.subObjectLet.string).to(equal("inside class"))
            }
            it("should build Buildable class by object passed") {
                let object = builder(DummyObject())
                    .int(10)
                    .subObject.string("inside class")
                    .subStruct.string("inside struct")
                    .subObjectLet.string("inside class")
                    .build()
                expect(object.int).to(equal(10))
                expect(object.subObject.string).to(equal("inside class"))
                expect(object.subStruct.string).to(equal("inside struct"))
                expect(object.subObjectLet.string).to(equal("inside class"))
            }
            it("should build Buildable struct by object passed") {
                let object = builder(DummyStruct())
                    .int(10)
                    .subObject.string("inside class")
                    .subStruct.string("inside struct")
                    .subObjectLet.string("inside class")
                    .build()
                expect(object.int).to(equal(10))
                expect(object.subObject.string).to(equal("inside class"))
                expect(object.subStruct.string).to(equal("inside struct"))
                expect(object.subObjectLet.string).to(equal("inside class"))
            }
            it("should fail to build on let struct") {
                let object = builder(DummyStruct())
                    .int(10)
                    .intLet(10)
                    .subObject.string("inside class")
                    .subObject.stringLet("should fail")
                    .subStruct.string("inside struct")
                    .subStruct.stringLet("should fail")
                    .subObjectLet.string("inside class")
                    .subStructLet.string("should fail")
                    .build()
                expect(object.int).to(equal(10))
                expect(object.intLet).toNot(equal(10))
                expect(object.subObject.string).to(equal("inside class"))
                expect(object.subObject.stringLet).toNot(equal("should fail"))
                expect(object.subStruct.string).to(equal("inside struct"))
                expect(object.subStruct.stringLet).toNot(equal("should fail"))
                expect(object.subObjectLet.string).to(equal("inside class"))
                expect(object.subStruct.string).toNot(equal("should fail"))
            }
        }
    }
}

fileprivate class DummyObject: Buildable {
    var int: Int = 0
    let intLet: Int = 0
    var subObject: SubObject = .init()
    var subStruct: SubStruct = .init()
    let subObjectLet: SubObject = .init()
    let subStructLet: SubStruct = .init()
    
    required init() { }
    
    class SubObject {
        var string: String  = ""
        let stringLet: String = ""
    }
    
    struct SubStruct {
        var string: String = ""
        let stringLet: String = ""
    }
}

fileprivate struct DummyStruct: Buildable {
    var int: Int = 0
    let intLet: Int = 0
    var subObject: SubObject = .init()
    var subStruct: SubStruct = .init()
    let subObjectLet: SubObject = .init()
    let subStructLet: SubStruct = .init()
    
    class SubObject {
        var string: String  = ""
        let stringLet: String = ""
    }
    
    struct SubStruct {
        var string: String = ""
        let stringLet: String = ""
    }
}
