//
//  RBUserProfileTests.swift
//  RBLessonPortal
//
//  Created by Rohan on 27/08/17.
//  Copyright © 2017 RB. All rights reserved.
//

import XCTest
@testable import RBLessonPortal
@testable import RealmSwift

class RBUserProfileTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_UpdateWithUserProfileDictionaryUpdatesUserProfile() {
        let userProfile = RBRMUserProfile()
        XCTAssertEqual(userProfile.id, "")
        XCTAssertEqual(userProfile.userID, "")
        XCTAssertEqual(userProfile.lessons.count, 0)
     
        let userLesson:[String: Any] = [RBKeys.lessonid: "Foo",RBKeys.status: "Bar", RBKeys.lesson: [RBKeys.title:"Baz"]]
        let userLessons:[Any] = [userLesson]
        let userDocument:[String:Any] = [RBKeys.id:"Foo"]
        let userProfileCollection:[String: Any] = [RBKeys.id:"Foo", RBKeys.userdocument:userDocument, RBKeys.userlessons:userLessons]
        let userProfileDictionary: [String: Any] = [RBKeys.userprofile:userProfileCollection]
        
        
        userProfile.update(withUserProfileDictionary:userProfileDictionary)
        XCTAssertEqual(userProfile.id, "Foo")
        XCTAssertEqual(userProfile.userID, "Foo")
        XCTAssertEqual(userProfile.lessons.count, 1)
        XCTAssertEqual(userProfile.lessons[0].id, "Foo")
        XCTAssertEqual(userProfile.lessons[0].status, "Bar")
        XCTAssertEqual(userProfile.lessons[0].title, "Baz")
    }
}
