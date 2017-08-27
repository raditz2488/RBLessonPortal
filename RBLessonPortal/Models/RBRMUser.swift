//
//  RBUser.swift
//  RBLessonPortal
//
//  Created by Rohan on 27/08/17.
//  Copyright © 2017 RB. All rights reserved.
//

import Foundation
import RealmSwift

class RBRMUser: Object {
    dynamic var id = ""
    let companyIDs = List<RBRMCompanyID>()
    dynamic var email = ""
    dynamic var mobile = ""
    dynamic var name = ""
    dynamic var username = ""
    
    func update(withUserDictionary userDictionary: [String: Any]) {
        guard let id = userDictionary[RBKeys.id] as? String, let companyIDs = userDictionary[RBKeys.companyids] as? [String] else { return }
        
        guard let email = userDictionary[RBKeys.email] as? String else { return }
        guard let mobile = userDictionary[RBKeys.mobile] as? String else { return }
        guard let username = userDictionary[RBKeys.username] as? String else { return }
        guard let name = userDictionary[RBKeys.name] as? String else { return }
        
        if self.id == "" || self.id == id {
            self.id = id
            self.companyIDs.removeAll()
            for companyID in companyIDs {
                let companyIDObject = RBRMCompanyID()
                companyIDObject.update(withCompanyID: companyID)
                self.companyIDs.append(companyIDObject)
            }
            
            self.email = email
            self.mobile = mobile
            self.username = username
            self.name = name
        }
    }
}


