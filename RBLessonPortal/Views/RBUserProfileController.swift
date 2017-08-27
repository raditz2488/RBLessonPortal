//
//  RBUserProfileController.swift
//  RBLessonPortal
//
//  Created by Rohan on 27/08/17.
//  Copyright © 2017 RB. All rights reserved.
//

import UIKit

class RBUserProfileController: UIViewController {
    
    // MARK: Properties
    private(set) var userInfoController: RBUserPersonalInfoController?
    private(set) var userLessonController: RBUserLessonsInfoController?
    
    // MARK: View lifecycle methods
    override func viewDidLoad() {
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        
        guard let userInfoController = childViewControllers.last as? RBUserPersonalInfoController else { fatalError("Wrong view controller") }
        guard let userLessonController = childViewControllers.first as? RBUserLessonsInfoController else { fatalError("Wrong view controller") }
        self.userInfoController = userInfoController
        self.userLessonController = userLessonController
        userInfoController.delegate = self
    }
    
    // MARK: IBActions
    @IBAction func logoutNavButtonAction(_ sender: UIBarButtonItem) {
        if let viewControllers = self.navigationController?.viewControllers {
            RBApplicationDataManager.shared.eraseAllData()
            if viewControllers.count == 2 {
                self.navigationController?.popViewController(animated: true)
            } else if viewControllers.count == 1 {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: RBStoryboardIdentifier.loginControllerNavCtrl.rawValue)
                UIApplication.shared.delegate?.window??.rootViewController = viewController
            } else {
                fatalError("viewController counts not handled in RBUserProfileController.logoutNavButtonAction(:)")
            }
        }
    }
    
}

extension RBUserProfileController: RBUserPersonalInfoControllerDelegate {
    func userInfoFetchSuccess() {
        self.userLessonController?.userInfoFetched()
    }
}
