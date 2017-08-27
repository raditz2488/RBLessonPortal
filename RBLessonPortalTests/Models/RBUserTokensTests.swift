//
//  RBUserTokensTests.swift
//  RBLessonPortal
//
//  Created by Rohan on 26/08/17.
//  Copyright © 2017 RB. All rights reserved.
//

import XCTest
@testable import RBLessonPortal

class RBUserTokensTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_InitializationWithTokenDictionary_InitializesAllProperties() {
        let tokenDictionary: [String: Any] = [RBKeys.accesstoken:"Foo", RBKeys.createdat:1503769513, RBKeys.expiresin:3249, RBKeys.refreshtoken:"Bar", RBKeys.scope:RBScope.user, RBKeys.tokentype:RBTokenTypes.bearer]
        let userTokens = RBUserTokens(withTokenDictionary: tokenDictionary)
        XCTAssertEqual(userTokens.accessToken, "Foo")
        XCTAssertEqual(userTokens.createdAt, 1503769513)
        XCTAssertEqual(userTokens.expiresIn, 3249)
        XCTAssertEqual(userTokens.refreshToken, "Bar")
        XCTAssertEqual(userTokens.scope, RBScope.user)
        XCTAssertEqual(userTokens.tokenType, RBTokenTypes.bearer)
    }
    
}
