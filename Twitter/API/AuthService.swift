//
//  AuthService.swift
//  Twitter
//
//  Created by Ngo Dang tan on 8/4/20.
//  Copyright © 2020 Ngo Dang tan. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
struct AuthCredentials {
    let email:String
    let password:String
    let fullname:String
    let username:String
    let profileImage: UIImage
}

struct AuthService {
    static let shared = AuthService()
    func logUserIn(withEmail email:String, password:String,completion: AuthDataResultCallback?){
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    func registerUser(credentials: AuthCredentials,completion: @escaping(Error?, DatabaseReference)->Void){
        let email = credentials.email
        let password = credentials.password
        let username = credentials.username
        let fullname = credentials.fullname
        
        guard let imageData = credentials.profileImage.jpegData(compressionQuality: 0.3) else {return}
        let filename =  NSUUID().uuidString
        let storageRef = STORAGE_PROFILE_IMAGES.child(filename)
        storageRef.putData(imageData, metadata: nil) { (meta, error) in
            storageRef.downloadURL { (url, error) in
                guard let profileImageUrl = url?.absoluteString else {return}
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    if let error = error{
                        print("DEBUG Error is \(error.localizedDescription)")
                        return
                    }
                    guard let uid = result?.user.uid else {return}
                    let values = ["email":email,
                                  "username":username,
                                  "fullname":fullname,
                                  "profileImageUrl":profileImageUrl] as [String : Any]
                    
                    REF_USERS.child(uid).updateChildValues(values,withCompletionBlock: completion)
                    
                    
                }
                
            }
        }
    }
}
