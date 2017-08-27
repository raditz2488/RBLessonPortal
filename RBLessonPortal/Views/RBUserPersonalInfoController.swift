//
//  RBUserPersonalInfoController.swift
//  RBLessonPortal
//
//  Created by Rohan on 27/08/17.
//  Copyright © 2017 RB. All rights reserved.
//

import UIKit

protocol RBUserPersonalInfoControllerDelegate: class {
    func userInfoFetchSuccess()
}

class RBUserPersonalInfoController : UIViewController {
    // MARK: Properties
    let viewModel = RBPersonalUserInfoViewModel()
    @IBOutlet weak var userInfoTableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    weak var delegate: RBUserPersonalInfoControllerDelegate?
    
    // MARK: View lifecycle methods
    override func viewDidLoad() {
        userInfoTableView.layer.cornerRadius = 16
        userInfoTableView.layer.masksToBounds = true
        viewModel.userInfoObserver = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getCurrentUserInfo()
    }
}


extension RBUserPersonalInfoController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RBTableViewCellIdentifiers.uerPersonlInfoCell.rawValue, for: indexPath)
        let userPersonalData = viewModel.userPersonalData(at: indexPath.row)
        cell.textLabel?.text = userPersonalData.title
        cell.detailTextLabel?.text = userPersonalData.value
        return cell
    }
}

extension RBUserPersonalInfoController: RBUerInfoObserver {
    func successfullyFetchedUserInfo() {
        userInfoTableView.reloadData()
        delegate?.userInfoFetchSuccess()
    }
    
    func userInfoFetchedFailed() {
        
    }
    
    func userInfoInProcess() {
        activityIndicatorView.startAnimating()
    }
    
    func userInfoIdle() {
        activityIndicatorView.stopAnimating()
    }
}
