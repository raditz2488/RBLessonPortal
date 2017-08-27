//
//  RBTokenPersistanceManager.swift
//  RBLessonPortal
//
//  Created by Rohan on 27/08/17.
//  Copyright © 2017 RB. All rights reserved.
//

import Foundation

enum RBTokenPersistanceKeys: String {
    case accessToken = "RBAccessToken"
    case tokenType = "RBTokenType"
    case expiresIn = "RBExpiresIn"
    case refreshToken = "RBRefreshToken"
    case scope = "RBScope"
    case createdAt = "RBCreatedAt"
}

class RBTokenPersistanceManager {
    
}

extension RBTokenPersistanceManager: RBTokenPersistanceStore{
    func tokens() -> RBUserTokens? {
        guard let accessToken = UserDefaults.standard.object(forKey: RBTokenPersistanceKeys.accessToken.rawValue) as? String else { return nil }
        guard let tokenType = UserDefaults.standard.object(forKey: RBTokenPersistanceKeys.tokenType.rawValue) as? String else { return nil }
        guard let refreshToken = UserDefaults.standard.object(forKey: RBTokenPersistanceKeys.refreshToken.rawValue) as? String else { return nil }
        guard let scope = UserDefaults.standard.object(forKey: RBTokenPersistanceKeys.scope.rawValue) as? String else { return nil }
        let createdAt =  UserDefaults.standard.integer(forKey: RBTokenPersistanceKeys.createdAt.rawValue)
        let expiresIn = UserDefaults.standard.integer(forKey: RBTokenPersistanceKeys.expiresIn.rawValue)
        
        let tokenDictionary: [String: Any] = [RBKeys.accesstoken:accessToken, RBKeys.createdat:createdAt, RBKeys.expiresin:expiresIn, RBKeys.refreshtoken:refreshToken, RBKeys.scope:scope, RBKeys.tokentype:tokenType]
        
        let userTokens = RBUserTokens(withTokenDictionary: tokenDictionary)
        return userTokens
    }
    
    func store(userTokens: RBUserTokens) {
        UserDefaults.standard.set(userTokens.accessToken as Any, forKey: RBTokenPersistanceKeys.accessToken.rawValue)
        UserDefaults.standard.set(userTokens.tokenType, forKey: RBTokenPersistanceKeys.tokenType.rawValue)
        UserDefaults.standard.set(userTokens.expiresIn, forKey: RBTokenPersistanceKeys.expiresIn.rawValue)
        UserDefaults.standard.set(userTokens.refreshToken, forKey: RBTokenPersistanceKeys.refreshToken.rawValue)
        UserDefaults.standard.set(userTokens.scope, forKey: RBTokenPersistanceKeys.scope.rawValue)
        UserDefaults.standard.set(userTokens.createdAt, forKey: RBTokenPersistanceKeys.createdAt.rawValue)
        
    }
    
    func eraseUserTokens() {
        UserDefaults.standard.removeObject(forKey: RBTokenPersistanceKeys.accessToken.rawValue)
        UserDefaults.standard.removeObject(forKey: RBTokenPersistanceKeys.refreshToken.rawValue)
    }
}
