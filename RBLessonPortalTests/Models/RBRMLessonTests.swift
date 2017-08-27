//
//  RBRMLessonsTests.swift
//  RBLessonPortal
//
//  Created by Rohan on 27/08/17.
//  Copyright © 2017 RB. All rights reserved.
//

import XCTest
@testable import RBLessonPortal
@testable import RealmSwift

class RBRMLessonTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_UpdateWithLessonDictionaryUpdatesLesson() {
        let lesson = RBRMLesson()
        XCTAssertEqual(lesson.id, "")
        XCTAssertEqual(lesson.status, "")
        XCTAssertEqual(lesson.title, "")
        let lessonDictionary:[String: Any] = [RBKeys.lessonid:"Foo", RBKeys.status:"Bar", RBKeys.lesson:[RBKeys.title:"Baz"]]
        lesson.update(withLessonDictionary: lessonDictionary)
        XCTAssertEqual(lesson.id, "Foo")
        XCTAssertEqual(lesson.status, "Bar")
        XCTAssertEqual(lesson.title, "Baz")
    }
    
}
