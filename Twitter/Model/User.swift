//
//  User.swift
//  Twitter
//
//  Created by Ngo Dang tan on 8/6/20.
//  Copyright © 2020 Ngo Dang tan. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
struct User {
    let fullname:String
    let email:String
    let username:String
    var profileImageUrl:URL?
    let uid:String
    var isFollowed = false
    var stats: UserRelationStats?
    
    var isCurrentUser: Bool {return Auth.auth().currentUser?.uid == uid}
    
    init(uid:String, dictionary: [String:AnyObject]) {
        self.uid = uid
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        if let profileImageUrlString = dictionary["profileImageUrl"] as? String {
            guard let url = URL(string: profileImageUrlString) else {
                return
            }
            self.profileImageUrl = url
        }
    
    }
}
struct UserRelationStats {
    let followers: Int
    var following: Int
}
