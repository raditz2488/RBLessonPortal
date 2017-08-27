//
//  RBApplicationDataManager.swift
//  RBLessonPortal
//
//  Created by Rohan on 27/08/17.
//  Copyright © 2017 RB. All rights reserved.
//

import Foundation

protocol RBHttpClient {
    typealias RBRequestCompletionHandler = (HTTPURLResponse?, Any?, Error?) -> Void
    
    func postAccessToken(forUserName userName: String, password: String, completionHandler:@escaping RBRequestCompletionHandler)
    func getCurrentUser(fromAccessToken accessToken: String, completionHandler: @escaping RBRequestCompletionHandler)
    func getUserProfile(forID id: String, companyID: String, accessToken: String, completionHandler: @escaping RBRequestCompletionHandler)
    func postRefreshTokenRequest(withRefreshToken refreshToken: String, completionHandler: @escaping RBRequestCompletionHandler)
}

protocol RBTokenPersistanceStore {
    func tokens() -> RBUserTokens?
    func store(userTokens: RBUserTokens)
    func eraseUserTokens()
}

protocol RBUserDataPersistanceStore {
    func save(user: RBRMUser)
    func getUser() -> RBRMUser?
    
    func save(userProfile: RBRMUserProfile)
    func getUserProfile() -> RBRMUserProfile?
    func userLessonsCount() -> Int
    func userLesson(at index: Int) -> RBRMLesson
    func eraseUserData()
}

class RBApplicationDataManager {
    // MARK: Properties
    static let shared = RBApplicationDataManager()
    let httpClient: RBHttpClient = RBAlamofireClient()
    let tokenPersistanceStore: RBTokenPersistanceStore = RBTokenPersistanceManager()
    let userDataPersistanceStore: RBUserDataPersistanceStore = RBUserDataPersistanceManager()
    
    // MARK: Initializer
    private init() {
    }
    
    func eraseAllData() {
        tokenPersistanceStore.eraseUserTokens()
        userDataPersistanceStore.eraseUserData()
    }
}

extension RBApplicationDataManager: RBLoginManager {
    func login(withUserName username: String, password: String, completionHandler:@escaping RBLoginCompletionHandler) {
        httpClient.postAccessToken(forUserName: username, password: password) { [weak self] (response, value, error) in
            if let error = error {
                completionHandler(false, error, error.localizedDescription)
            } else {
                if let response = response {
                    if response.statusCode == 200 {
                        if let tokenDictionary = value as? [String: Any] {
                            let userTokens = RBUserTokens(withTokenDictionary: tokenDictionary)
                            self?.tokenPersistanceStore.store(userTokens: userTokens)
                            completionHandler(true, nil, "")
                            return
                        }
                    } else if response.statusCode == 401 {
                        if let value = value as? [String: Any] {
                            if let errorString = value[RBKeys.error] as? String {
                                completionHandler(false, RBLoginManagerError.notAuthorized, errorString)
                                return
                            }
                        }
                    }
                }
                completionHandler(false, error, "Sorry cannot login at the moment.")
            }
        }
    }
}

extension RBApplicationDataManager: RBUserInfoManager {
    func getCurrentUserInfo(_ completionHandler:@escaping RBUserInfoCompletionHandler) {
        if let userTokens = tokenPersistanceStore.tokens() {
            httpClient.getCurrentUser(fromAccessToken: userTokens.accessToken, completionHandler: { [weak self] (response, value, error) in
                if let response = response {
                    if response.statusCode == 200 {
                        if let value = value as? [String: Any], let userDictionary = value[RBKeys.user] as? [String: Any] {
                            let user = RBRMUser()
                            user.update(withUserDictionary: userDictionary)
                            self?.userDataPersistanceStore.save(user: user)
                            completionHandler(true, nil, "")
                        }
                    } else if response.statusCode == 401 {
                        if let value = value as? [String: Any] {
                            if let errorString = value[RBKeys.error] as? String {
                                completionHandler(false, RBUserInfoError.notAuthorized, errorString)
                                return
                            }
                        }
                    }
                }
                completionHandler(false, error, "Sorry cannot login at the moment.")
            })
        } else {
            completionHandler(false, RBUserInfoError.noTokensFound, "No user token found")
        }
    }
    
    func getRefreshToken(_ completionHandler: @escaping RBUserInfoCompletionHandler) {
        if let userTokens = tokenPersistanceStore.tokens() {
            httpClient.postRefreshTokenRequest(withRefreshToken: userTokens.refreshToken) { [weak self] (response, value, error) in
                if let error = error {
                    completionHandler(false, error, error.localizedDescription)
                } else {
                    if let response = response {
                        if response.statusCode == 200 {
                            if let tokenDictionary = value as? [String: Any] {
                                let userTokens = RBUserTokens(withTokenDictionary: tokenDictionary)
                                self?.tokenPersistanceStore.store(userTokens: userTokens)
                                completionHandler(true, nil, "")
                                return
                            }
                        } else if response.statusCode == 401 {
                            if let value = value as? [String: Any] {
                                if let errorString = value[RBKeys.error] as? String {
                                    completionHandler(false, RBLoginManagerError.notAuthorized, errorString)
                                    return
                                }
                            }
                        }
                    }
                    completionHandler(false, error, "Sorry cannot login at the moment.")
                }
            }
        }
    }
}

extension RBApplicationDataManager: RBUserLessonInfoManager {
    func getCurrentUserLessonInfo(_ completionHandler:@escaping RBUserLessonInfoCompletionHandler) {
        if let userTokens = tokenPersistanceStore.tokens(), let userInfo = userDataPersistanceStore.getUser(), let companyID = userInfo.companyIDs.first {
            httpClient.getUserProfile(forID: userInfo.id, companyID:companyID.id, accessToken: userTokens.accessToken, completionHandler: { [weak self] (response, value, error) in
                if let response = response {
                    if response.statusCode == 200 {
                        if let userProfileDictionary = value as? [String: Any] {
                            let userProfile = RBRMUserProfile()
                            userProfile.update(withUserProfileDictionary: userProfileDictionary)
                            self?.userDataPersistanceStore.save(userProfile:userProfile)
                            completionHandler(true, nil, "")
                        }
                    } else if response.statusCode == 401 {
                        if let value = value as? [String: Any] {
                            if let errorString = value[RBKeys.error] as? String {
                                completionHandler(false, RBUserLessonInfoError.notAuthorized, errorString)
                                return
                            }
                        }
                    }
                }
                completionHandler(false, error, "Sorry cannot login at the moment.")
            })
        } else {
            completionHandler(false, RBUserLessonInfoError.noTokensFound, "No user token found")
        }
    }
    
    func currentUserLessonCount() -> Int {
        return self.userDataPersistanceStore.userLessonsCount()
    }
    
    func userLesson(at index: Int) -> RBRMLesson {
        return self.userDataPersistanceStore.userLesson(at: index)
    }
}
