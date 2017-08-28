//
//  RBCredentialPersistanceManager.swift
//  RBLessonPortal
//
//  Created by Rohan on 27/08/17.
//  Copyright © 2017 RB. All rights reserved.
//

import Foundation

enum RBCredentialPersistanceKeys: String {
    case username = "RB_CREDENTIAL_USERNAME"
    case password = "RB_CREDENTIAL_PASSWORD"
}

class RBCredentialPersistanceManager {
    
}

extension RBCredentialPersistanceManager: RBCredentialPersistanceProtocol {
    func lastLoggedInUserCredentials() -> RBLoginCredentials? {
        guard let username = UserDefaults.standard.object(forKey: RBCredentialPersistanceKeys.username.rawValue) as? String else { return nil }
        guard let password = UserDefaults.standard.object(forKey: RBCredentialPersistanceKeys.password.rawValue) as? String else { return nil }
        return (username, password)
    }
    func storeLoggedInUserCredentials(_ userCredentials: RBLoginCredentials) {
        UserDefaults.standard.set(userCredentials.username as Any, forKey: RBCredentialPersistanceKeys.username.rawValue)
        UserDefaults.standard.set(userCredentials.password as Any, forKey: RBCredentialPersistanceKeys.password.rawValue)
    }
}
