//
//  RBJSONConstants.swift
//  RBLessonPortal
//
//  Created by Rohan on 26/08/17.
//  Copyright © 2017 RB. All rights reserved.
//

enum RBKeys {
    static let username = "username"
    static let password = "password"
    static let granttype = "grant_type"
    static let scope = "scope"
    static let refreshtoken = "refresh_token"
    static let accesstoken = "access_token"
    static let createdat = "created_at"
    static let expiresin = "expires_in"
    static let tokentype = "token_type"
    static let id = "_id"
    static let companyids = "company_ids"
    static let lessonid = "lesson_id"
    static let status = "status"
    static let lesson = "lesson"
    static let title = "title"
    static let userprofile = "user_profile"
    static let userdocument = "user_document"
    static let userlessons = "user_lessons"
    static let error = "error"
    static let email = "email"
    static let mobile = "mobile"
    static let name = "name"
    static let user = "user"
}

enum RBGrantType {
    static let password = "password"
    static let refreshtoken = "refresh_token"
}

enum RBScope {
    static let user = "user"
}

enum RBHttpHeaderKeys {
    static let authorization = "Authorization"
    static let contentType = "Content-Type"
}

enum RBHttpContentTypeValues {
    static let applicationJson = "application/json"
    static let applicationFormURLEncoded = "application/x-www-form-urlencoded"
}

enum RBTokenTypes {
    static let bearer = "bearer"
}
