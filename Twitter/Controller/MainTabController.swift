//
//  MainTabController.swift
//  Twitter
//
//  Created by Ngo Dang tan on 7/30/20.
//  Copyright © 2020 Ngo Dang tan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
enum ActionButtonConfiguration{
    case tweet
    case message
}
class MainTabController: UITabBarController {
    
    // MARK: - Properties
    private var buttonConfig: ActionButtonConfiguration = .tweet
    
    var user:User?{
        didSet{
            guard let nav = viewControllers?[0] as? UINavigationController else {
                return
            }
            guard let feed = nav.viewControllers.first as? FeedController else {
                return
            }
            feed.user = user
        }
    }
    let actionButton:UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = .twitterBlue
        button.setImage(UIImage(named: "new_tweet"), for: .normal)
        button.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        return button
    }()
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //logUserOut()
        view.backgroundColor = .twitterBlue
        authenticateUserAndConfigureUI()
      
    }
    //MARK: - API
    func fetchUser(){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        UserService.shared.fetchUser(uid: uid) { user in
            self.user = user
        }
    }
    func authenticateUserAndConfigureUI(){
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        }else{
            configureViewControllers()
            configureUI()
            fetchUser()
        }
    }
  
    
    //MARK: - Selectors
    @objc func actionButtonTapped(){
        
        let controller: UIViewController
        
        switch buttonConfig{
        case .message:
            controller = SearchController(config: .messages)
        case .tweet:
            guard let user = user else {
                return
            }
            controller = UploadTweetController(user: user, config: .tweet)
        }

        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav,animated: true,completion: nil)
    }
    //MARK: Helpers
    func configureUI(){
        self.delegate = self
        
        view.addSubview(actionButton)
        actionButton.anchor( bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor,paddingBottom: 64, paddingRight: 16, width: 56, height: 56)
        actionButton.layer.cornerRadius = 56/2
    }
    
    func configureViewControllers(){
        let feed = FeedController(collectionViewLayout: UICollectionViewFlowLayout())
        let nav1 = templateNavigationController(image:  UIImage(named: "home_unselected"), rootViewController: feed)
        
        let explore = SearchController(config: .userSearch)
        let nav2 = templateNavigationController(image: UIImage(named:"search_unselected"), rootViewController: explore)
        
        let notifications = NotificationsController()
        let nav3 = templateNavigationController(image: UIImage(named:"like_unselected"), rootViewController: notifications)
        
        
        let conversations = ConversationsController()
     
        let nav4 = templateNavigationController(image: UIImage(named:"ic_mail_outline_white_2x-1"), rootViewController: conversations)
        
        viewControllers = [nav1,nav2,nav3,nav4]
    }
    func templateNavigationController(image:UIImage?,rootViewController:UIViewController) -> UINavigationController{
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
        nav.navigationBar.barTintColor = .white
        return nav
        
    }
    
}

extension MainTabController: UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let index = viewControllers?.firstIndex(of: viewController)
        let image = index == 3 ? #imageLiteral(resourceName: "mail") : #imageLiteral(resourceName: "new_tweet")
        actionButton.setImage(image, for: .normal)
        buttonConfig = index == 3 ? .message : .tweet
        
   
        
    }
}
