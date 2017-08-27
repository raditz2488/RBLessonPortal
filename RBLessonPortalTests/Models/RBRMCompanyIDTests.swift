//
//  RBRMCompanyIDTests.swift
//  RBLessonPortal
//
//  Created by Rohan on 27/08/17.
//  Copyright © 2017 RB. All rights reserved.
//

import XCTest
@testable import RBLessonPortal
@testable import RealmSwift

class RBRMCompanyIDTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_UpdateWithCompanyID_UpdatesCompanyID() {
        let companyIDObject = RBRMCompanyID()
        XCTAssertEqual(companyIDObject.id, "")
        companyIDObject.update(withCompanyID:"Foo")
        XCTAssertEqual(companyIDObject.id, "Foo")
    }
    
}
