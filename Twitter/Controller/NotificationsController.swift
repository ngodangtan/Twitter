//
//  NotificationsController.swift
//  Twitter
//
//  Created by Ngo Dang tan on 7/30/20.
//  Copyright © 2020 Ngo Dang tan. All rights reserved.
//

import Foundation
import UIKit
private let reuseIdentifier = "NotificationCell"

class NotificationsController: UITableViewController{
    // MARK: - Properties
    private var notifications = [Notification]()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    // MARK: - Helpers
    func configureUI(){
        view.backgroundColor = .white
        navigationItem.title = "Notifications"
        tableView.register(NotificationCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 60
        tableView.separatorStyle = .none
    }
}
extension NotificationsController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! NotificationCell
      
        return cell
    }
}
