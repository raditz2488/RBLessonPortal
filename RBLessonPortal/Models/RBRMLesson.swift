//
//  RBRMLessons.swift
//  RBLessonPortal
//
//  Created by Rohan on 27/08/17.
//  Copyright © 2017 RB. All rights reserved.
//

import Foundation
import RealmSwift

class RBRMLesson: Object {
    dynamic var id = ""
    dynamic var status = ""
    dynamic var title = ""
    
    func update(withLessonDictionary lessonDictionary: [String: Any]) {
        guard let id = lessonDictionary[RBKeys.lessonid] as? String, let status = lessonDictionary[RBKeys.status] as? String, let titleDictionary = lessonDictionary[RBKeys.lesson] as? [String: Any], let title = titleDictionary[RBKeys.title] as? String else { return }
        self.id = id
        self.status = status
        self.title = title
    }
}
