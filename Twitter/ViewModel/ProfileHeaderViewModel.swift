//
//  ProfileHeaderViewModel.swift
//  Twitter
//
//  Created by Ngo Dang tan on 8/31/20.
//  Copyright © 2020 Ngo Dang tan. All rights reserved.
//

import UIKit

enum ProfileFilterOptions: Int, CaseIterable {
    case tweets
    case replies
    case likes
    
    var desscription: String{
        switch self {
        case .tweets: return "Tweets"
        case .replies: return "Tweets & Replies"
        case .likes: return "Likes"
        }
    }
}
struct ProfileHeaderViewModel {
    private let user: User
    let usernameText:String
    var followersString: NSAttributedString? {
        return attributedText(withValue: user.stats?.followers ?? 0, text: "followers")
    }
    var followingString : NSAttributedString? {
        return attributedText(withValue: user.stats?.following ?? 0, text: "following")
    }
    var actionButtonTitle:String {
        if user.isCurrentUser{
            return "Edit Profile"
        }
        if !user.isFollowed && !user.isCurrentUser{
            return "Follow"
        }
        if user.isFollowed{
            return "Following"
        }
        return "Loading"
    }
    init(user: User) {
        self.user = user
        self.usernameText = "@" + user.username
    }
    fileprivate func attributedText(withValue value: Int,text: String) -> NSAttributedString{
        let attributedTitle = NSMutableAttributedString(string: "\(value)",
            attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedTitle.append(NSAttributedString(string: " \(text)",
            attributes: [.font: UIFont.systemFont(ofSize: 14),
                         .foregroundColor: UIColor.lightGray]))
        return attributedTitle
    }
}
