//
//  Utilities.swift
//  Twitter
//
//  Created by Ngo Dang tan on 7/31/20.
//  Copyright © 2020 Ngo Dang tan. All rights reserved.
//

import UIKit
class Utilities{
    
    func inputContainerView(withImage image:UIImage,textFeild: UITextField) -> UIView{
        let view = UIView()
        let iv = UIImageView()
        iv.image = image
        view.addSubview(iv)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        iv.anchor(left:view.leftAnchor,bottom: view.bottomAnchor,paddingLeft: 8,paddingBottom: 8)
        iv.setDimensions(width: 24, height: 24)
        view.addSubview(textFeild)
        textFeild.anchor(left: iv.rightAnchor,bottom: view.bottomAnchor,right: view.rightAnchor,paddingLeft: 8,paddingBottom: 8)
        
        let dividerView = UIView()
        dividerView.backgroundColor = .white
        view.addSubview(dividerView)
        dividerView.anchor(left:view.leftAnchor,bottom: view.bottomAnchor,right: view.rightAnchor,paddingLeft: 8,height: 0.75)
        
        return view
    }
    func textFeild(withPlaceholder placeholder:String) -> UITextField {
        let tf = UITextField()
        tf.placeholder = placeholder
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.textColor = .white
        tf.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        return tf
    }
    func attributedButton(_ firstPart:String, _ secondPart:String) -> UIButton{
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: firstPart, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),NSAttributedString.Key.foregroundColor: UIColor.white])
        attributedTitle.append(NSAttributedString(string: secondPart, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16),NSAttributedString.Key.foregroundColor: UIColor.white]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }
}
