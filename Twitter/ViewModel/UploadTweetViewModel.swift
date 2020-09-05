//
//  UploadTweetViewModel.swift
//  Twitter
//
//  Created by Ngo Dang tan on 9/4/20.
//  Copyright © 2020 Ngo Dang tan. All rights reserved.
//

import UIKit
enum UploadTweetConfiguration{
    case tweet
    case reply(Tweet)
}
struct UploadTweetViewModel {
    
    let actionButtonTitle: String
    let placeholderText: String
    var shoudShowReplyLabel: Bool
    var replyText:String?
    
    init(config: UploadTweetConfiguration){
        switch config{
        case .tweet:
            actionButtonTitle = "Tweet"
            placeholderText = "What's happening?"
            shoudShowReplyLabel = false
        case .reply(let tweet):
            actionButtonTitle = "Reply"
            placeholderText = "Tweet your reply"
            shoudShowReplyLabel = true
            replyText = "Replying to @\(tweet.user.username)"
        }
    }
}
