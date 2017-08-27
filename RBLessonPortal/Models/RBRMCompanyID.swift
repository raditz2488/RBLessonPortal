//
//  RBRMCompanyID.swift
//  RBLessonPortal
//
//  Created by Rohan on 27/08/17.
//  Copyright © 2017 RB. All rights reserved.
//

import Foundation
import RealmSwift

class RBRMCompanyID: Object {
    dynamic var id = ""
    
    func update(withCompanyID companyID: String) {
        self.id = companyID
    }
}
