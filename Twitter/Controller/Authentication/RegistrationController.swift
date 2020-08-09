//
//  RegistrationController.swift
//  Twitter
//
//  Created by Ngo Dang tan on 7/30/20.
//  Copyright © 2020 Ngo Dang tan. All rights reserved.
//

import UIKit
import Firebase
class RegistrationController: UIViewController {
    //MARK: - Properties
    private let imagePicker = UIImagePickerController()
    private var profileImage: UIImage?
    private let plusPhotoButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleAddProfilePhoto), for: .touchUpInside)
        return button
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
    private lazy var fullnameContainerView: UIView = {
        let image = #imageLiteral(resourceName: "ic_mail_outline_white_2x-1")
        let view = Utilities().inputContainerView(withImage: image,textFeild: fullnameTextFeild)
        return view
    }()
    private lazy var usernameContainerView: UIView = {
        let image = #imageLiteral(resourceName: "ic_lock_outline_white_2x")
        let view = Utilities().inputContainerView(withImage: image, textFeild: usernameTextFeild)
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
    private let fullnameTextFeild: UITextField = {
        let tf = Utilities().textFeild(withPlaceholder: "Full Name")
        return tf
    }()
    private let usernameTextFeild: UITextField = {
        let tf = Utilities().textFeild(withPlaceholder: "User Name")
        return tf
    }()
    private let alreadyHaveAccountButton: UIButton = {
        let button = Utilities().attributedButton("Already have an account", " Log In")
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return button
    }()
    private let registrationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.twitterBlue, for: .normal)
        button.backgroundColor = .white
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleRegistration), for: .touchUpInside)
        return button
    }()
    
    //MARK : - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    //MARK: - Selectors
    @objc func handleAddProfilePhoto(){
        present(imagePicker, animated: true, completion: nil)
        
    }
    @objc func handleShowLogin(){
        navigationController?.popViewController(animated: true)
    }
    @objc func handleRegistration(){
        guard let profileImage = profileImage else {
            print("Please select profile image")
            return
        }
        guard let email = emailTextFeild.text else {return}
        guard let password = passwordTextFeild.text else {return}
        guard let fullname = fullnameTextFeild.text else {return}
        guard let username = usernameTextFeild.text else {return}

        let credentials = AuthCredentials(email: email, password: password, fullname: fullname, username: username, profileImage: profileImage)
        AuthService.shared.registerUser(credentials: credentials) { (err, ref) in
            print("DEBUG: Sign up successful...")
            print("DEBUG: Hand;e update user interface here ...")
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
    
    //MARR: - Helpers
    func configureUI(){
        view.backgroundColor = .twitterBlue
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        view.addSubview(plusPhotoButton)
        plusPhotoButton.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        plusPhotoButton.setDimensions(width: 128, height: 128)
        let stack = UIStackView(arrangedSubviews: [emailContainerView,passwordContainerView,fullnameContainerView,usernameContainerView,registrationButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        view.addSubview(stack)
        stack.anchor(top:plusPhotoButton.bottomAnchor, left: view.leftAnchor,right: view.rightAnchor,paddingTop: 32,paddingLeft: 32,paddingRight: 32)
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.anchor(left: view.leftAnchor,bottom: view.safeAreaLayoutGuide.bottomAnchor,right: view.rightAnchor,paddingLeft: 40,paddingRight: 40)
    }
}
extension RegistrationController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let profileImage = info[.editedImage] as? UIImage else {return}
        self.profileImage = profileImage
        self.plusPhotoButton.layer.cornerRadius = 128/2
        self.plusPhotoButton.layer.masksToBounds = true
        self.plusPhotoButton.imageView?.contentMode = .scaleAspectFill
        self.plusPhotoButton.imageView?.clipsToBounds = true
        self.plusPhotoButton.layer.borderColor = UIColor.white.cgColor
        self.plusPhotoButton.layer.borderWidth = 3
        self.plusPhotoButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        dismiss(animated: true, completion: nil)
    }
}
