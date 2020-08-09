//
//  FeedController.swift
//  Twitter
//
//  Created by Ngo Dang tan on 7/30/20.
//  Copyright © 2020 Ngo Dang tan. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
class FeedController: UIViewController{
    var user:User?{
        didSet{
            configureLeftBarButton()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    func configureUI(){
        view.backgroundColor = .white
        let imageView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        imageView.contentMode = .scaleAspectFit
        imageView.setDimensions(width: 44, height: 44)
        navigationItem.titleView = imageView
        

    }
    func configureLeftBarButton(){
        guard let user = user else {return}
        
        let profileImageView = UIImageView()
        profileImageView.setDimensions(width: 32, height: 32)
        profileImageView.layer.cornerRadius = 32/2
        profileImageView.layer.masksToBounds = true
        

        
        profileImageView.sd_setImage(with: user.profileImageUrl, completed: nil)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
        
        
    }
}
