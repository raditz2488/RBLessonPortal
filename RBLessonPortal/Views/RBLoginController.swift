//
//  RBLoginController.swift
//  RBLessonPortal
//
//  Created by Rohan on 27/08/17.
//  Copyright © 2017 RB. All rights reserved.
//

import UIKit

class RBLoginController: UIViewController {
    // MARK: Properties
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    let loginViewModel = RBLoginViewModel()
    
    // MARK: View lifecycle methods
    override func viewDidLoad() {
        loginViewModel.loginObserver = self
        guard let userCredentials = loginViewModel.lastLoggedInUserCredentials() else { return }
        usernameTextField.text = userCredentials.username
        passwordTextField.text = userCredentials.password
    }
    
    // MARK: IBActions
    @IBAction func loginButtonAction(_ sender: Any) {
        guard let usernameText = usernameTextField.text, let passwordText = passwordTextField.text else { return }
        do {
            try loginViewModel.loginTapped(withUserCredentials: (usernameText, passwordText))
        } catch let error {
            handle(loginError: error as! RBCredentialValidationError)
        }
    }
}

extension RBLoginController {
    func handle(loginError: RBCredentialValidationError) {
        let title = "Alert!!!"
        let message: String
        switch loginError {
        case .usernameEmpty:
            message = "Username is empty"
        case .passwordEmpty:
            message = "Password is empty"
        case .usernameInvalid:
            message = "Invalid username"
        case .passwordInvalid: 
            message = "Invalid password"
        }
        messageAlert(title: title, message: message)
    }
    
    func messageAlert(title: String?, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}

extension RBLoginController: RBLoginObserver {
    func userLoggedIn() {
        self.performSegue(withIdentifier: RBSegueIdentifiers.showUserProfile.rawValue, sender: nil)
    }
    
    func userLogInFailed(withError error: Error?, message: String) {
        messageAlert(title: "Alert", message: message)
    }
    
    func userLoginInProcess() {
        activityIndicatorView.startAnimating()
    }
    
    func userLoginIdle() {
        activityIndicatorView.stopAnimating()
    }
}
