//
//  RBUserTokens.swift
//  RBLessonPortal
//
//  Created by Rohan on 26/08/17.
//  Copyright © 2017 RB. All rights reserved.
//

import Foundation

struct RBUserTokens {
    var accessToken = ""
    var tokenType = ""
    var expiresIn = 0
    var refreshToken = ""
    var scope = ""
    var createdAt = 0
    
    init(withTokenDictionary dictionary: [String: Any]) {
        guard let accessToken = dictionary["access_token"] as? String, let tokenType = dictionary["token_type"] as? String, let expiresIn = dictionary["expires_in"] as? Int, let refreshToken = dictionary["refresh_token"] as? String, let scope = dictionary["scope"] as? String, let createdAt = dictionary["created_at"] as? Int else { fatalError("RBToken couldn't be genrated from token dictionary") }
        
        self.accessToken = accessToken
        self.tokenType = tokenType
        self.expiresIn = expiresIn
        self.refreshToken = refreshToken
        self.scope = scope
        self.createdAt = createdAt
    }
}
