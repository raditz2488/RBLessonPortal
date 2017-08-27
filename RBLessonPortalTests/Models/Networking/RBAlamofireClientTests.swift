//
//  RBAlamofireClientTests.swift
//  RBLessonPortal
//
//  Created by Rohan on 26/08/17.
//  Copyright © 2017 RB. All rights reserved.
//

import XCTest
@testable import RBLessonPortal
@testable import Alamofire


class RBAlamofireClientTests: XCTestCase {
    
    let sut = RBAlamofireClient()
    var alamofireMock: MockAlamofire!
    
    override func setUp() {
        super.setUp()
        alamofireMock = MockAlamofire()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_InitializingRBAlmofireClient_SetsupRequestClosure() {
        XCTAssertNotNil(sut.requestClosure)
    }
    
    // MARK: Tests for Get Access token
    func test_GetAccessTokenMethod_CallsRequestClosure_ToCreateDataRequest() {
        sut.requestClosure = alamofireMock.request(_:method:parameters:encoding:headers:)
        sut.postAccessToken(forUserName: "", password: "") { (_, _, _) in }
        XCTAssert(alamofireMock.requestClosureCalled)
    }
    
    func test_GetAccessTokenMethod_UsesGetAccessTokenURL_PostMethod_ToCreateDataRequest() {
        sut.requestClosure = alamofireMock.request(_:method:parameters:encoding:headers:)
        sut.postAccessToken(forUserName: "", password: "") { (_, _, _) in }
        XCTAssertEqual(alamofireMock.url, RBWebServices.accessToken.url)
        XCTAssertEqual((alamofireMock.method), .post)
    }
    
    func test_GetAccessTokenMethod_UsesUserNameAndPasswordToCreateDataRequest() {
        sut.requestClosure = alamofireMock.request(_:method:parameters:encoding:headers:)
        sut.postAccessToken(forUserName: "foo", password: "bar") { (_, _, _) in }
        XCTAssertEqual(alamofireMock.username, "foo")
        XCTAssertEqual(alamofireMock.password, "bar")
        XCTAssertEqual(alamofireMock.granttype, RBGrantType.password)
        XCTAssertEqual(alamofireMock.scope, RBScope.user)
    }
    
    func test_GetAccessTokenMethod_UsesAppropriateHeaderToCreateDataRequest() {
        sut.requestClosure = alamofireMock.request(_:method:parameters:encoding:headers:)
        sut.postAccessToken(forUserName: "", password: "") { (_, _, _) in }
        if let currentUserRequestHeader = alamofireMock.currentUserRequestHeader {
            XCTAssertEqual(currentUserRequestHeader[RBHttpHeaderKeys.contentType] as? String, RBHttpContentTypeValues.applicationFormURLEncoded)
        } else {
            XCTFail()
        }
    }
    
    func test_GetAccessTokenMethod_FiresDataRequest() {
        sut.requestClosure = alamofireMock.request(_:method:parameters:encoding:headers:)
        sut.postAccessToken(forUserName: "", password: "") { (_, _, _) in }
        XCTAssert(alamofireMock.mockDataRequest.responseJSONMethodCalled)
    }
    
    func test_GetAccessTokenMethod_FiringDataRequestInvokesCompletionHandler() {
        sut.requestClosure = alamofireMock.request(_:method:parameters:encoding:headers:)
        let completionHanlderExpectation = expectation(description: "completionHanlderExpectation")
        sut.postAccessToken(forUserName: "", password: "") { (_, _, _) in
            completionHanlderExpectation.fulfill()
        }
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    // MARK: Tests for getting current user
    func test_GetCurrentUser_CallsRequestClosure_ToCreateDataRequest() {
        sut.requestClosure = alamofireMock.request(_:method:parameters:encoding:headers:)
        sut.getCurrentUser(fromAccessToken: "") { (_, _, _) in }
        XCTAssert(alamofireMock.requestClosureCalled)
    }
    
    func test_GetCurrentUser_UsesGetCurrentUserURL_GetMethod_ToCreateDataRequest() {
        sut.requestClosure = alamofireMock.request(_:method:parameters:encoding:headers:)
        sut.getCurrentUser(fromAccessToken: "") { (_, _, _) in }
        XCTAssertEqual(alamofireMock.url, RBWebServices.currentUser.url)
        XCTAssertEqual((alamofireMock.method), .get)
    }
    
    func test_GetCurrentUser_UsesJSONEncodingToCreateDataRequest() {
        sut.requestClosure = alamofireMock.request(_:method:parameters:encoding:headers:)
        sut.getCurrentUser(fromAccessToken: "") { (_, _, _) in }
        XCTAssertNotNil(alamofireMock.jsonEncoding)
    }
    
    func test_GetCurrentUser_UsesAppropriateHeaderToCreateDataRequest() {
        sut.requestClosure = alamofireMock.request(_:method:parameters:encoding:headers:)
        sut.getCurrentUser(fromAccessToken: "Foo") { (_, _, _) in }
        if let currentUserRequestHeader = alamofireMock.currentUserRequestHeader {
            XCTAssertEqual(currentUserRequestHeader[RBHttpHeaderKeys.authorization] as? String, "Bearer Foo")
            XCTAssertEqual(currentUserRequestHeader[RBHttpHeaderKeys.contentType] as? String, RBHttpContentTypeValues.applicationJson)
        } else {
            XCTFail()
        }
    }
    
    func test_GetCurrentUser_FiresDataRequest() {
        sut.requestClosure = alamofireMock.request(_:method:parameters:encoding:headers:)
        sut.getCurrentUser(fromAccessToken: "") { (_, _, _) in }
        XCTAssert(alamofireMock.mockDataRequest.responseJSONMethodCalled)
    }
    
    func test_GetCurrentUser_FiringDataRequestInvokesCompletionHandler() {
        sut.requestClosure = alamofireMock.request(_:method:parameters:encoding:headers:)
        let completionHanlderExpectation = expectation(description: "completionHanlderExpectation")
        sut.getCurrentUser(fromAccessToken: "") { (_, _, _) in
            completionHanlderExpectation.fulfill()
        }
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    // MARK: Tests for getting user profile
    func test_GetUserProfile_CallsRequestClosure_ToCreateDataRequest() {
        sut.requestClosure = alamofireMock.request(_:method:parameters:encoding:headers:)
        sut.getUserProfile(forID: "", companyID: "", accessToken: "") { (_, _, _) in }
        XCTAssert(alamofireMock.requestClosureCalled)
    }
    
    func test_GetUserProfile_UsesGetCurrentUserURL_GetMethod_ToCreateDataRequest() {
        sut.requestClosure = alamofireMock.request(_:method:parameters:encoding:headers:)
        sut.getUserProfile(forID: "foo", companyID: "bar", accessToken: "") { (_, _, _) in }
        let url = RBWebServices.userProfile(userID: "foo", companyID: "bar").url
        XCTAssertEqual(alamofireMock.url, url)
        XCTAssertEqual((alamofireMock.method), .get)
    }
    
    func test_GetUserProfile_UsesJSONEncodingToCreateDataRequest() {
        sut.requestClosure = alamofireMock.request(_:method:parameters:encoding:headers:)
        sut.getUserProfile(forID: "", companyID: "", accessToken: "") { (_, _, _) in }
        XCTAssertNotNil(alamofireMock.jsonEncoding)
    }
    
    func test_GetUserProfile_UsesAppropriateHeaderToCreateDataRequest() {
        sut.requestClosure = alamofireMock.request(_:method:parameters:encoding:headers:)
        sut.getUserProfile(forID: "", companyID: "", accessToken: "Foo") { (_, _, _) in }
        if let currentUserRequestHeader = alamofireMock.currentUserRequestHeader {
            XCTAssertEqual(currentUserRequestHeader[RBHttpHeaderKeys.authorization] as? String, "Bearer Foo")
        } else {
            XCTFail()
        }
    }
    
    func test_GetUserProfile_FiresDataRequest() {
        sut.requestClosure = alamofireMock.request(_:method:parameters:encoding:headers:)
        sut.getUserProfile(forID: "", companyID: "", accessToken: "") { (_, _, _) in }
        XCTAssert(alamofireMock.mockDataRequest.responseJSONMethodCalled)
    }
    
    func test_GetUserProfile_FiringDataRequestInvokesCompletionHandler() {
        sut.requestClosure = alamofireMock.request(_:method:parameters:encoding:headers:)
        let completionHanlderExpectation = expectation(description: "completionHanlderExpectation")
        sut.getUserProfile(forID: "", companyID: "", accessToken: "") { (_, _, _) in
            completionHanlderExpectation.fulfill()
        }
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    // MARK: Refresh token request
    func test_PostRefreshTokenRequest_CallsRequestClosure_ToCreateDataRequest() {
        sut.requestClosure = alamofireMock.request(_:method:parameters:encoding:headers:)
        sut.postRefreshTokenRequest(withRefreshToken: "") { (_, _, _) in }
        XCTAssert(alamofireMock.requestClosureCalled)
    }
    
    func test_PostRefreshTokenRequest_UsesGetAccessTokenURL_PostMethod_ToCreateDataRequest() {
        sut.requestClosure = alamofireMock.request(_:method:parameters:encoding:headers:)
        sut.postRefreshTokenRequest(withRefreshToken: "") { (_, _, _) in }
        XCTAssertEqual(alamofireMock.url, RBWebServices.accessToken.url)
        XCTAssertEqual((alamofireMock.method), .post)
    }
    
    func test_PostRefreshTokenRequest_UsesRefreshTokenToCreateDataRequest() {
        sut.requestClosure = alamofireMock.request(_:method:parameters:encoding:headers:)
        sut.postRefreshTokenRequest(withRefreshToken: "Foo") { (_, _, _) in }
        
        XCTAssertEqual(alamofireMock.refreshToken, "Foo")
        XCTAssertEqual(alamofireMock.granttype, RBGrantType.refreshtoken)
        XCTAssertEqual(alamofireMock.scope, RBScope.user)
    }
    
    func test_PostRefreshTokenRequest_UsesAppropriateHeaderToCreateDataRequest() {
        sut.requestClosure = alamofireMock.request(_:method:parameters:encoding:headers:)
        sut.postRefreshTokenRequest(withRefreshToken: "") { (_, _, _) in }
        if let currentUserRequestHeader = alamofireMock.currentUserRequestHeader {
            XCTAssertEqual(currentUserRequestHeader[RBHttpHeaderKeys.contentType] as? String, RBHttpContentTypeValues.applicationFormURLEncoded)
        } else {
            XCTFail()
        }
    }
    
    func test_PostRefreshTokenRequest_FiresDataRequest() {
        sut.requestClosure = alamofireMock.request(_:method:parameters:encoding:headers:)
        sut.postRefreshTokenRequest(withRefreshToken: "") { (_, _, _) in }
        XCTAssert(alamofireMock.mockDataRequest.responseJSONMethodCalled)
    }
    
    func test_PostRefreshTokenRequest_FiringDataRequestInvokesCompletionHandler() {
        sut.requestClosure = alamofireMock.request(_:method:parameters:encoding:headers:)
        let completionHanlderExpectation = expectation(description: "completionHanlderExpectation")
        sut.postRefreshTokenRequest(withRefreshToken: "") { (_, _, _) in
            completionHanlderExpectation.fulfill()
        }
        waitForExpectations(timeout: 3, handler: nil)
    }
}

extension RBAlamofireClientTests {
    class MockAlamofire {
        var requestClosureCalled = false
        var method: HTTPMethod?
        var url: String?
        var username: String?
        var password: String?
        var granttype: String?
        var scope: String?
        var refreshToken: String?
        let mockDataRequest = MockDataRequest()
        var currentUserRequestHeader: [String: Any]?
        var jsonEncoding: JSONEncoding?
        
        func request(
            _ url: URLConvertible,
            method: HTTPMethod = .get,
            parameters: Parameters? = nil,
            encoding: ParameterEncoding = URLEncoding.default,
            headers: HTTPHeaders? = nil)
            -> RBDataRequestProtocol {
                self.requestClosureCalled = true
                self.method = method
                self.url = url as? String
                if let parameters = parameters {
                    self.username = parameters[RBKeys.username] as? String
                    self.password = parameters[RBKeys.password] as? String
                    self.granttype = parameters[RBKeys.granttype] as? String
                    self.scope = parameters[RBKeys.scope] as? String
                    self.refreshToken = parameters[RBKeys.refreshtoken] as? String
                }
                if let headers = headers {
                    self.currentUserRequestHeader = headers
                }
                self.jsonEncoding = encoding as? JSONEncoding
                return mockDataRequest
        }
    }
    
    class MockDataRequest: RBDataRequestProtocol {
        var responseJSONMethodCalled = false
        
        func responseJSON(queue: DispatchQueue?, options: JSONSerialization.ReadingOptions, completionHandler: @escaping (DataResponse<Any>) -> Void) -> Self {
            responseJSONMethodCalled = true
            let error = RBMockError()
            completionHandler(DataResponse(request: nil, response: nil, data: nil, result: Result.failure(error)))
            return self
        }
    }
    
    class RBMockError: Error {
    }
}
