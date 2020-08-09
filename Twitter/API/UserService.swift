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
    func fetchUser(completion: @escaping(User) -> Void){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        print("DEBUG: CURRENT USER UID IS \(uid)")
        REF_USERS.child(uid).observeSingleEvent(of: .value) { snapshot in
            guard let dictionary = snapshot.value as? [String:AnyObject] else {return}
           
            let user = User(uid: uid, dictionary: dictionary)
            completion(user)
         
        }
        
        
    }
}
