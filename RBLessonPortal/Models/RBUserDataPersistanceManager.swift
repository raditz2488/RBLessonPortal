//
//  RBUserDataPersistanceManager.swift
//  RBLessonPortal
//
//  Created by Rohan on 27/08/17.
//  Copyright © 2017 RB. All rights reserved.
//

import Foundation
import RealmSwift

class RBUserDataPersistanceManager {
    var user: RBRMUser?
    var userProfile: RBRMUserProfile?
    var realm = try! Realm()
}

extension RBUserDataPersistanceManager: RBUserDataPersistanceStore {
    func save(user: RBRMUser) {
        if let oldUser = getUser() {
            try! realm.write {
                realm.delete(oldUser)
            }
        }
        try! realm.write {
            realm.add(user)
        }
    }
    
    func getUser() -> RBRMUser? {
        let users = realm.objects(RBRMUser.self)
        return users.first
    }
    
    func save(userProfile: RBRMUserProfile) {
        if let oldUserProfile = getUserProfile() {
            try! realm.write {
                realm.delete(oldUserProfile)
            }
        }
        
        try! realm.write {
            realm.add(userProfile)
        }
    }
    
    func getUserProfile() -> RBRMUserProfile? {
        let userProfile = realm.objects(RBRMUserProfile.self).first
        return userProfile
    }
    
    func userLessonsCount() -> Int {
        if let userProfile = getUserProfile() {
            return userProfile.lessons.count
        }
        return 0
    }
    
    func userLesson(at index: Int) -> RBRMLesson {
        guard let userProfile = getUserProfile() else { fatalError("Lesson count and lesson objects mismatch") }
        return userProfile.lessons[index]
    }
    
    func eraseUserData() {
        if let oldUser = getUser() {
            try! realm.write {
                realm.delete(oldUser)
            }
        }
        
        if let oldUserProfile = getUserProfile() {
            try! realm.write {
                realm.delete(oldUserProfile)
            }
        }
    }
}
