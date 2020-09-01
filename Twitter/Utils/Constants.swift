//
//  Constants.swift
//  Twitter
//
//  Created by Ngo Dang tan on 8/4/20.
//  Copyright © 2020 Ngo Dang tan. All rights reserved.
//

import Firebase
import FirebaseStorage
import FirebaseDatabase
let STORAGE_REF = Storage.storage().reference()
let STORAGE_PROFILE_IMAGES = STORAGE_REF.child("profile_images")

let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child("users")
let REF_TWEETS = DB_REF.child("tweets")
let REF_USER_TWEETS = DB_REF.child("user-tweets")
