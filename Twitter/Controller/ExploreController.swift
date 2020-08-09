//
//  ExploreController.swift
//  Twitter
//
//  Created by Ngo Dang tan on 7/30/20.
//  Copyright © 2020 Ngo Dang tan. All rights reserved.
//

import Foundation
import UIKit
class ExploreController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    func configureUI(){
           view.backgroundColor = .white
        navigationItem.title = "Explore"
       }
}
