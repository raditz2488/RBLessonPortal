//
//  RBLoginViewModel.swift
//  RBLessonPortal
//
//  Created by Rohan on 27/08/17.
//  Copyright © 2017 RB. All rights reserved.
//

import Foundation

typealias RBLoginCredentials = (username: String, password: String)

enum RBLoginState {
    case idle
    case processing
}

enum RBCredentialValidationError: Error {
    case usernameEmpty
    case passwordEmpty
    case usernameInvalid
    case passwordInvalid
}

enum RBLoginManagerError: Error {
    case notAuthorized
}

protocol RBCredentialPersistanceProtocol {
    func lastLoggedInUserCredentials() -> RBLoginCredentials?
    func storeLoggedInUserCredentials(_ userCredentials: RBLoginCredentials)
}

protocol RBLoginManager {
    typealias RBLoginCompletionHandler = (Bool, Error?, String) -> Void
    func login(withUserName username: String, password: String, completionHandler:@escaping RBLoginCompletionHandler)
}

protocol RBLoginObserver: class {
    func userLoggedIn()
    func userLogInFailed(withError error: Error?, message: String)
    func userLoginInProcess()
    func userLoginIdle()
}

class RBLoginViewModel {
    // MARK: Properties
    let credentialPersistanceManager: RBCredentialPersistanceProtocol = RBCredentialPersistanceManager()
    weak var loginObserver: RBLoginObserver?
    private var loginStatus: RBLoginState = .idle {
        willSet(newStatus){
            switch newStatus {
            case .idle:
                loginObserver?.userLoginIdle()
            case .processing:
                loginObserver?.userLoginInProcess()
            }
        }
    }
    
    func lastLoggedInUserCredentials() -> RBLoginCredentials? {
        return credentialPersistanceManager.lastLoggedInUserCredentials()
    }
    
    func loginTapped(withUserCredentials userCredentials: RBLoginCredentials) throws {
        
        //https://stackoverflow.com/questions/25471114/how-to-validate-an-e-mail-address-in-swift
        func isValidEmail(testStr:String) -> Bool {
            // print("validate calendar: \(testStr)")
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailTest.evaluate(with: testStr)
        }
        
        //https://stackoverflow.com/questions/43533854/password-validation-in-swift
        func isPasswordValid(_ password : String) -> Bool {
            //Replaced my validation for simple uses
            let trimmedString = password.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            if trimmedString.characters.count < 4 {
                return false
            }
            return true
        }
        
        guard !userCredentials.username.isEmpty else { throw RBCredentialValidationError.usernameEmpty }
        guard !userCredentials.password.isEmpty else {throw RBCredentialValidationError.passwordEmpty }
        guard isValidEmail(testStr: userCredentials.username) else { throw RBCredentialValidationError.usernameInvalid }
        guard isPasswordValid(userCredentials.password) else { throw RBCredentialValidationError.passwordInvalid }
        loginStatus = .processing
        RBApplicationDataManager.shared.login(withUserName: userCredentials.username, password: userCredentials.password) { [weak self](success, error, message) in
            if success {
                self?.credentialPersistanceManager.storeLoggedInUserCredentials(userCredentials)
                self?.loginObserver?.userLoggedIn()
            } else {
                self?.loginObserver?.userLogInFailed(withError: error, message: message)
            }
            self?.loginStatus = .idle
        }
    }
}
