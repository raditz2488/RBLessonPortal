//
//  RBUserLessonsInfoController.swift
//  RBLessonPortal
//
//  Created by Rohan on 27/08/17.
//  Copyright © 2017 RB. All rights reserved.
//

import Foundation

typealias RBUserLessonInfo = (title: String, status: String)
typealias RBUserLessonsInfoState = RBLoginState

enum RBUserLessonInfoError: Error {
    case noTokensFound
    case notAuthorized
}

protocol RBUserLessonsInfoObserver:class {
    func successfullyFetchedUserLessonInfo()
    func userLessonInfoFetchFailed()
    func userLessonInfoInProcess()
    func userLessonInfoIdle()
}

protocol RBUserLessonInfoManager {
    typealias RBUserLessonInfoCompletionHandler = (Bool, Error?, String) -> Void
    func getCurrentUserLessonInfo(_ completionHandler:@escaping RBUserLessonInfoCompletionHandler)
    func currentUserLessonCount() -> Int
    func userLesson(at index: Int) -> RBRMLesson
}

class RBUserLessonsInfoViewModel {
    // MARK: Properties
    weak var userLessonInfoObserver: RBUserLessonsInfoObserver?
    var userLessonsInfoState: RBUserLessonsInfoState = .idle {
        willSet(newState) {
            switch newState {
            case .idle:
                userLessonInfoObserver?.userLessonInfoIdle()
            case .processing:
                userLessonInfoObserver?.userLessonInfoInProcess()
            }
        }
    }
    
    func numberOfCells() -> Int {
        return RBApplicationDataManager.shared.currentUserLessonCount()
    }
    
    func userLesson(at index: Int) -> RBUserLessonInfo {
        let userLesson = RBApplicationDataManager.shared.userLesson(at:index)
        let userLessonInfo:RBUserLessonInfo = userLessonInfoTuple(fromUserLesson:userLesson)
        return userLessonInfo
    }
    
    func userLessonInfoTuple(fromUserLesson userLesson: RBRMLesson) -> RBUserLessonInfo {
        let userLessonInfo: RBUserLessonInfo = (userLesson.title, userLesson.status)
        return userLessonInfo
    }
}

extension RBUserLessonsInfoViewModel {
    func getCurrentUserLessonsInfo() {
        userLessonsInfoState = .processing
        RBApplicationDataManager.shared.getCurrentUserLessonInfo { [weak self] (success, error, message) in
            self?.userLessonsInfoState = .idle
            if success {
                self?.userLessonInfoObserver?.successfullyFetchedUserLessonInfo()
            } else {
                if let error = error as? RBUserLessonInfoError {
                    if error == .notAuthorized {
                        self?.getRefreshToken()
                    }
                }
                self?.userLessonInfoObserver?.userLessonInfoFetchFailed()
            }
        }
    }
    
    func getRefreshToken() {
        userLessonsInfoState = .processing
        RBApplicationDataManager.shared.getRefreshToken { [weak self] (success, error, message) in
            self?.userLessonsInfoState = .idle
            if success {
                self?.getCurrentUserLessonsInfo()
            }
        }
    }
}
