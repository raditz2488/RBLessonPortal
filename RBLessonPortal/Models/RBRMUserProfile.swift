//
//  RBRMUserProfile.swift
//  RBLessonPortal
//
//  Created by Rohan on 27/08/17.
//  Copyright © 2017 RB. All rights reserved.
//

import Foundation
import RealmSwift

class RBRMUserProfile: Object {
    dynamic var id = ""
    dynamic var userID = ""
    let lessons = List<RBRMLesson>()
    
    func update(withUserProfileDictionary userProfileDictionary: [String: Any]) {
        
        guard let userProfile = userProfileDictionary[RBKeys.userprofile] as? [String: Any] else { return }
        guard let id = userProfile[RBKeys.id] as? String else { return }
        guard let userDocument = userProfile[RBKeys.userdocument] as? [String: Any] else { return }
        guard let userID = userDocument[RBKeys.id] as? String else { return }
        guard let userLessons = userProfile[RBKeys.userlessons] as? [[String: Any]] else { return }
        
        self.id = id
        self.userID = userID
        
        self.lessons.removeAll()
        for userLessonDictionary in userLessons {
            let userLesson = RBRMLesson()
            userLesson.update(withLessonDictionary: userLessonDictionary)
            self.lessons.append(userLesson)
        }
    }
}
