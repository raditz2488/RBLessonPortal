//
//  RBUserLessonsInfoController.swift
//  RBLessonPortal
//
//  Created by Rohan on 27/08/17.
//  Copyright © 2017 RB. All rights reserved.
//

import UIKit

class RBUserLessonsInfoController: UIViewController {
    // MARK: Properties
    let viewModel = RBUserLessonsInfoViewModel()
    @IBOutlet weak var lessonsInfoTableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    // MARK: View lifecycle methods
    override func viewDidLoad() {
        viewModel.userLessonInfoObserver = self
        lessonsInfoTableView.layer.cornerRadius = 16
        lessonsInfoTableView.layer.masksToBounds = true
    }
}

extension RBUserLessonsInfoController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RBTableViewCellIdentifiers.userLessonInfoCell.rawValue, for: indexPath)
        let userLessonInfo = viewModel.userLesson(at: indexPath.row)
        cell.textLabel?.text = userLessonInfo.title
        cell.detailTextLabel?.text = userLessonInfo.status
        return cell
    }
}

extension RBUserLessonsInfoController {
    func userInfoFetched() {
        viewModel.getCurrentUserLessonsInfo()
    }
}

extension RBUserLessonsInfoController: RBUserLessonsInfoObserver {
    func successfullyFetchedUserLessonInfo() {
        lessonsInfoTableView.reloadData()
    }
    
    func userLessonInfoFetchFailed() {
        
    }
    
    func userLessonInfoInProcess() {
        activityIndicatorView.startAnimating()
    }
    
    func userLessonInfoIdle() {
        activityIndicatorView.stopAnimating()
    }
}
