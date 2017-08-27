//
//  RBWebServices.swift
//  RBLessonPortal
//
//  Created by Rohan on 26/08/17.
//  Copyright © 2017 RB. All rights reserved.
//

enum RBWebServices {
    case accessToken
    case currentUser
    case userProfile(userID: String, companyID: String)
    var url : String {
        switch self {
        case .accessToken:
            return "https://api.es-q.co/oauth/token.json"
        case .currentUser:
            return "https://api.es-q.co/users/current.json"
        case .userProfile(let userID, let companyID):
            return "https://api.es-q.co/companies/\(companyID)/sq/users/\(userID)/user_profile?include[user_lessons][only][]=status&include[user_lessons][include][lesson][only]=title&include[user_lessons][only][]=lesson_id&select[]=_id&select[]=user_document"
        }
    }
}
