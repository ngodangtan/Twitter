//
//  Tweet.swift
//  Twitter
//
//  Created by Ngo Dang tan on 8/10/20.
//  Copyright © 2020 Ngo Dang tan. All rights reserved.
//

import Foundation
struct Tweet {
    let caption:String
    let tweetID:String
 
    var likes:Int
    var timestamp:Date!
    let retweetCount:Int
    var user: User
    var didLike = false
    var replyingTo: String?
    
    var isReply: Bool {return replyingTo != nil}
    
    init(user:User,tweetID:String, dictionary: [String:Any]) {
        self.tweetID = tweetID
        self.user = user
        self.caption = dictionary["caption"] as? String ?? ""
    
        self.likes = dictionary["likes"] as? Int ?? 0
        self.retweetCount = dictionary["retweets"] as? Int ?? 0
        if let timestamp = dictionary["timestamp"] as? Double{
            self.timestamp = Date(timeIntervalSince1970: timestamp)
        }
        if let replyingTo = dictionary["replyingTo"] as? String {
            self.replyingTo = replyingTo
        }
    }
}
