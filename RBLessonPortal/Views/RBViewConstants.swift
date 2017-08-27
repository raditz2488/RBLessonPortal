//
//  RBViewConstants.swift
//  RBLessonPortal
//
//  Created by Rohan on 27/08/17.
//  Copyright © 2017 RB. All rights reserved.
//

import Foundation

enum RBStoryboardIdentifier: String {
    case loginControllerNavCtrl = "RBLoginControllerNavCtrl"
    case loginController = "RBLoginController"
    case userProfileController = "RBUserProfileController"
    case userPersonalInfoController = "RBUserPersonalInfoController"
    case userLessonsInfoController = "RBUserLessonsInfoController"
}

enum RBCredentialKeys: String {
    case lastLoginUserName = "RB_LAST_LOGIN_USERNAME"
    case lastLoginUserPassword = "RB_LAST_LOGIN_PASSWORD"
}

enum RBSegueIdentifiers: String {
    case showUserProfile = "RB_SHOW_USER_PROFILE"
}

enum RBTableViewCellIdentifiers: String {
    case uerPersonlInfoCell = "RB_USER_PERSONAL_INFO_CELL"
    case userLessonInfoCell = "RB_USER_LESSON_INFO_CELL"
}
