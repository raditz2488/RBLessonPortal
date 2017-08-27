//
//  RBCredentialPersistanceManager.swift
//  RBLessonPortal
//
//  Created by Rohan on 27/08/17.
//  Copyright © 2017 RB. All rights reserved.
//

import Foundation

class RBCredentialPersistanceManager {
    
}

extension RBCredentialPersistanceManager: RBCredentialPersistanceProtocol {
    func lastLoggedInUserCredentials() -> RBLoginCredentials? {
        return ("sqfos18@jombay.com", "test123")
    }
    func storeLoggedInUserCredentials(_ userCredentials: RBLoginCredentials?) {
        
    }
}
