//
//  RBPersonalUserInfoViewModel.swift
//  RBLessonPortal
//
//  Created by Rohan on 27/08/17.
//  Copyright © 2017 RB. All rights reserved.
//

import Foundation

typealias RBUserPersonalData = (title: String, value: String)
typealias RBUserInfoState = RBLoginState

enum RBUserInfoError: Error {
    case noTokensFound
    case notAuthorized
}

protocol RBUserInfoManager {
    typealias RBUserInfoCompletionHandler = (Bool, Error?, String) -> Void
    func getCurrentUserInfo(_ completionHandler:@escaping RBUserInfoCompletionHandler)
    func getRefreshToken(_ completionHandler: @escaping RBUserInfoCompletionHandler)
}

protocol RBUerInfoObserver: class {
    func successfullyFetchedUserInfo()
    func userInfoFetchedFailed()
    func userInfoInProcess()
    func userInfoIdle()
}

class RBPersonalUserInfoViewModel {
    
    // Properties
    weak var userInfoObserver: RBUerInfoObserver?
    var userInfoState: RBUserInfoState = .idle {
        willSet(newState) {
            switch newState {
            case .idle:
                userInfoObserver?.userInfoIdle()
            case .processing:
                userInfoObserver?.userInfoInProcess()
            }
        }
    }
    
    func numberOfCells() -> Int {
        return 4
    }
    
    func userPersonalData(at index: Int) -> RBUserPersonalData {
        let mockPersonalData:[RBUserPersonalData]
        if let userData = RBApplicationDataManager.shared.userDataPersistanceStore.getUser() {
            mockPersonalData = userPersonalData(fromUser: userData)
        } else {
            mockPersonalData = [("",""),("",""),("",""),("","")]
        }
        return mockPersonalData[index]
    }
    
    func userPersonalData(fromUser user: RBRMUser) -> [RBUserPersonalData] {
        let userPersonalData: [RBUserPersonalData] = [("Name", user.name), ("Username", user.username), ("Email", user.email), ("Mobile",user.mobile)]
        return userPersonalData
    }
}

extension RBPersonalUserInfoViewModel {
    func getCurrentUserInfo() {        
        userInfoState = .processing
        RBApplicationDataManager.shared.getCurrentUserInfo { [weak self] (success, error, message) in
            self?.userInfoState = .idle
            if success {
                self?.userInfoObserver?.successfullyFetchedUserInfo()
            } else {
                if let error = error as? RBUserInfoError {
                    if error == .notAuthorized {
                        self?.getRefreshToken()
                    }
                }
                self?.userInfoObserver?.userInfoFetchedFailed()
            }
            
        }
    }
    
    func getRefreshToken() {
        userInfoState = .processing
        RBApplicationDataManager.shared.getRefreshToken { [weak self] (success, error, message) in
            self?.userInfoState = .idle
            if success {
                self?.getCurrentUserInfo()
            }
            
        }
    }
}
