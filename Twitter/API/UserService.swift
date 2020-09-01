//
//  UserService.swift
//  Twitter
//
//  Created by Ngo Dang tan on 8/6/20.
//  Copyright © 2020 Ngo Dang tan. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
struct UserService {
    static let shared = UserService()
    func fetchUser(uid:String,completion: @escaping(User) -> Void){
        print("DEBUG: CURRENT USER UID IS \(uid)")
        REF_USERS.child(uid).observeSingleEvent(of: .value) { snapshot in
            guard let dictionary = snapshot.value as? [String:AnyObject] else {return}
           
            let user = User(uid: uid, dictionary: dictionary)
            completion(user)
         
        }
        
        
    }
    func fetchUsers(completion: @escaping([User]) -> Void){
        var users = [User]()
        REF_USERS.observe(.childAdded) { snapshot in
            let uid = snapshot.key
            guard let dictionary = snapshot.value as? [String:AnyObject] else { return }
            let user = User(uid: uid, dictionary: dictionary)
            users.append(user)
            completion(users)
        }
        
    }
}
