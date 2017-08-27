//
//  RBUserTests.swift
//  RBLessonPortal
//
//  Created by Rohan on 27/08/17.
//  Copyright © 2017 RB. All rights reserved.
//

import XCTest
@testable import RBLessonPortal
@testable import RealmSwift

class RBRMUserTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_UpdateWithUserDictionary_UpdatesUserIDAndCompanyIDs() {
        let user = RBRMUser()
        XCTAssertEqual(user.id, "")
        XCTAssertEqual(user.companyIDs.count, 0)
        
        let userDictionary:[String: Any] = [RBKeys.id:"Foo", RBKeys.companyids:["Bar"], RBKeys.email:"Bat",RBKeys.mobile:"Baz",RBKeys.name:"Sut",RBKeys.username:"Fun"]
        user.update(withUserDictionary:userDictionary)
        XCTAssertEqual(user.id, "Foo")
        XCTAssertEqual(user.companyIDs.count, 1)
        XCTAssertEqual(user.companyIDs[0].id, "Bar")
        XCTAssertEqual(user.email, "Bat")
        XCTAssertEqual(user.mobile, "Baz")
        XCTAssertEqual(user.name, "Sut")
        XCTAssertEqual(user.username, "Fun")
    }
    
}
