//
//  RBWebServicesTests.swift
//  RBLessonPortal
//
//  Created by Rohan on 26/08/17.
//  Copyright © 2017 RB. All rights reserved.
//

import XCTest
@testable import RBLessonPortal

class RBWebServicesTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_UrlReturnsAppropriate_AccessToken() {
        let webService = RBWebServices.accessToken
        let url = webService.url
        XCTAssertEqual(url, "https://api.es-q.co/oauth/token.json")
    }
    
    func test_UrlReturnsAppropriate_CurrentUser() {
        let webService = RBWebServices.currentUser
        let url = webService.url
        XCTAssertEqual(url, "https://api.es-q.co/users/current.json")
    }
    
    func test_UrlReturnsAppropriate_UserProfile() {
        let webService = RBWebServices.userProfile(userID: "Foo", companyID: "Bar")
        let url = webService.url
        XCTAssertEqual(url, "https://api.es-q.co/companies/Bar/sq/users/Foo/user_profile?include[user_lessons][only][]=status&include[user_lessons][include][lesson][only]=title&include[user_lessons][only][]=lesson_id&select[]=_id&select[]=user_document")
    }
}
