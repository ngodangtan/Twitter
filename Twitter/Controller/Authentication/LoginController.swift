//
//  LoginController.swift
//  Twitter
//
//  Created by Ngo Dang tan on 7/30/20.
//  Copyright © 2020 Ngo Dang tan. All rights reserved.
//

import UIKit
class LoginController: UIViewController {
    //MARK - Properties
    private let logoImageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = #imageLiteral(resourceName: "TwitterLogo")
        return iv
    }()
    private lazy var emailContainerView: UIView = {
        let image = #imageLiteral(resourceName: "ic_mail_outline_white_2x-1")
        let view = Utilities().inputContainerView(withImage: image,textFeild: emailTextFeild)
        return view
    }()
    private lazy var passwordContainerView: UIView = {
        let image = #imageLiteral(resourceName: "ic_lock_outline_white_2x")
        let view = Utilities().inputContainerView(withImage: image, textFeild: passwordTextFeild)
        return view
    }()
    private let emailTextFeild: UITextField = {
        let tf = Utilities().textFeild(withPlaceholder: "Email")
        return tf
    }()
    private let passwordTextFeild: UITextField = {
        let tf = Utilities().textFeild(withPlaceholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.twitterBlue, for: .normal)
        button.backgroundColor = .white
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    private let dontHaveAccountButton: UIButton = {
        let button = Utilities().attributedButton("Don't have an account", " Sign Up")
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    //MARK: - Selectors
    @objc func handleLogin(){
        guard let email = emailTextFeild.text else {
            return
        }
        guard let password = passwordTextFeild.text else {
            return
        }
        AuthService.shared.logUserIn(withEmail: email, password: password) { (result, error) in
            if let error = error{
                print(error.localizedDescription)
            }
            print("Debug successful log in ...")
            guard let window = UIApplication.shared.windows.first(where: {$0.isKeyWindow}) else {
                return
            }
            guard let tab = window.rootViewController as? MainTabController else {
                return
            }
            tab.authenticateUserAndConfigureUI()
            self.dismiss(animated: true, completion: nil)
        }

  
    }
    
    @objc func handleShowSignUp(){
        let controller = RegistrationController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    //MARK: - Helpers
    
    func configureUI(){
        view.backgroundColor = .twitterBlue
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(logoImageView)
        logoImageView.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        logoImageView.setDimensions(width: 150, height: 150)
        let stack = UIStackView(arrangedSubviews: [emailContainerView,passwordContainerView,loginButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        view.addSubview(stack)
        stack.anchor(top:logoImageView.bottomAnchor, left: view.leftAnchor,right: view.rightAnchor,paddingLeft: 32,paddingRight: 32)
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.anchor(left: view.leftAnchor,bottom: view.safeAreaLayoutGuide.bottomAnchor,right: view.rightAnchor,paddingLeft: 40,paddingRight: 40)
        
    }
}
