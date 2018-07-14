//
//  StartingNavigationPage.swift
//  YummyV1
//
/*
    logo and double button on the bottom
 */
//  Created by Brandon In on 4/17/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class StartingNavigationPage: UIViewController{
    
    lazy var logoImage: UIImageView = {
        let logoImage = UIImageView();
        logoImage.translatesAutoresizingMaskIntoConstraints = false;
        logoImage.image = #imageLiteral(resourceName: "OnDeliveryLogo");
        return logoImage;
    }()
    
    lazy var onDeliveryTitle: UILabel = {
        let onDeliveryTitle = UILabel();
        onDeliveryTitle.translatesAutoresizingMaskIntoConstraints = false;
        onDeliveryTitle.text = "OnDelivery";
        onDeliveryTitle.font = UIFont(name: "Montserrat-SemiBold", size: 25);
        onDeliveryTitle.adjustsFontForContentSizeCategory = true;
        onDeliveryTitle.numberOfLines = 1;
        onDeliveryTitle.minimumScaleFactor = 0.5;
        onDeliveryTitle.textColor = UIColor.black;
        onDeliveryTitle.textAlignment = .center;
        return onDeliveryTitle;
    }()
    
    lazy var loginButton: UIButton = {
        let loginButton = UIButton(type: .system);
        loginButton.translatesAutoresizingMaskIntoConstraints = false;
        loginButton.setTitle("Log In", for: .normal);
        loginButton.setTitleColor(UIColor.black, for: .normal);
        loginButton.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 18);
        loginButton.layer.borderColor = UIColor.black.cgColor;
        loginButton.layer.borderWidth = 1;
        loginButton.backgroundColor = UIColor.appYellow;
        loginButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10);
        loginButton.addTarget(self, action: #selector(self.toLoginPage), for: .touchUpInside);
        return loginButton;
    }()
    
    lazy var signUpButton: UIButton = {
        let signUpButton = UIButton(type: .system);
        signUpButton.translatesAutoresizingMaskIntoConstraints = false;
        signUpButton.setTitle("Sign Up", for: .normal);
        signUpButton.setTitleColor(UIColor.appYellow, for: .normal);
        signUpButton.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 18);
        signUpButton.layer.borderWidth = 1;
        signUpButton.backgroundColor = UIColor.black;
        signUpButton.addTarget(self, action: #selector(self.toSignUpPage), for: .touchUpInside);
        return signUpButton;
    }()
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.appYellow;
        
        self.view.addSubview(logoImage);
        self.logoImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true;
        self.logoImage.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true;
        self.logoImage.widthAnchor.constraint(equalToConstant: 150).isActive = true;
        self.logoImage.heightAnchor.constraint(equalToConstant: 150).isActive = true;
        
        self.view.addSubview(onDeliveryTitle);
        self.onDeliveryTitle.topAnchor.constraint(equalTo: self.logoImage.bottomAnchor, constant: 10).isActive = true;
        self.onDeliveryTitle.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 25).isActive = true;
        self.onDeliveryTitle.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -25).isActive = true;
        self.onDeliveryTitle.heightAnchor.constraint(equalToConstant: 35).isActive = true;
        
        self.view.addSubview(signUpButton);
        signUpButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        signUpButton.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        signUpButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true;
        signUpButton.heightAnchor.constraint(equalToConstant: 50).isActive = true;
        
        self.view.addSubview(loginButton);
        loginButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        loginButton.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        loginButton.bottomAnchor.constraint(equalTo: self.signUpButton.topAnchor).isActive = true;
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true;
    }
    
    @objc func toLoginPage(){
        let loginPage = ProfileLogin();
        loginPage.fromStartUpPage = true;
        loginPage.loginBoolean = true;
        loginPage.skipButton.isEnabled = false;
        let navigationController = UINavigationController(rootViewController: loginPage);
        navigationController.navigationBar.barTintColor = UIColor.black;
        navigationController.navigationBar.isTranslucent = false;
        self.present(navigationController, animated: true, completion: nil);
    }
    
    @objc func toSignUpPage(){
        let signUpPage = ProfileLogin();
        signUpPage.fromStartUpPage = true;
        let navigationController = UINavigationController(rootViewController: signUpPage);
        navigationController.navigationBar.barTintColor = UIColor.black;
        navigationController.navigationBar.isTranslucent = false;
        self.present(navigationController, animated: true, completion: nil);
    }
    
}
