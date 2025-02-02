//
//  NotificationViewModel.swift
//  Twitter
//
//  Created by Ngo Dang tan on 9/9/20.
//  Copyright © 2020 Ngo Dang tan. All rights reserved.
//

import UIKit
struct NotificationViewMode {
    private let notification: Notification
    private let type:NotificationType
    private let user: User
    var timestampString: String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second,.minute,.hour,.day,.weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        let now = Date()
        return formatter.string(from: notification.timestamp, to: now) ?? "2m"
    }
    var notificationMessage:String {
        switch type{
            
     
        case .follow: return " started following you"
        
        case .like: return " liked your tweets"
            
        case .reply: return " replied to your tweet"
            
        case .retweet: return " retweeted your tweet"
        case .mention: return " mention you in a tweet"
            
        }
    }
    var notificationText: NSAttributedString? {
        guard let timestamp = timestampString else {return nil}
        let attributedText = NSMutableAttributedString(string: user.username,attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12)])
        attributedText.append(NSAttributedString(string: notificationMessage, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]))
        attributedText.append(NSAttributedString(string: " \(timestamp)",attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12),NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
        return attributedText
    }
    var profileImageUrl: URL?{
        return user.profileImageUrl
    }
    
    var shouldHideFollowButton: Bool {
        return type != .follow
    }
    var followButtonText: String{
        return user.isFollowed ? "Following" : "Follow"
    }
    
    init(notification: Notification){
        self.notification = notification
        self.type = notification.type
        self.user = notification.user
    }
}
