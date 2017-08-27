//
//  AppDelegate.swift
//  RBLessonPortal
//
//  Created by Rohan on 26/08/17.
//  Copyright © 2017 RB. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if RBApplicationDataManager.shared.tokenPersistanceStore.tokens() != nil {
            let viewController = storyboard.instantiateViewController(withIdentifier: RBStoryboardIdentifier.userProfileController.rawValue)
            let navCtrl = UINavigationController(rootViewController: viewController)
            self.window?.rootViewController = navCtrl
        } else {
            let viewController = storyboard.instantiateViewController(withIdentifier: RBStoryboardIdentifier.loginControllerNavCtrl.rawValue)
            self.window?.rootViewController = viewController
        }
        
        self.window?.makeKeyAndVisible()
        return true
    }
}

