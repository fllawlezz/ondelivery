//
//  ChangePasswordPage1.swift
//  YummyV1
//
//  Created by Brandon In on 1/25/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import Foundation
import UIKit

class ChangePasswordPage1: UIViewController, UITextFieldDelegate{
    //TextField for password, label for title, next button, error message if password is wrong
    //MARK: Elements
    var passwordField: TextFieldPadded!;
    var titleLabel: UILabel!;
    var errorMessage: UILabel!;
    var nextButton: UIButton!;
    
    var password: String?
    
    override func viewDidLoad() {
        let backButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil);
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton;
        self.navigationItem.title = "Password"
        
        self.view.backgroundColor = UIColor.white;
        setup();
    }
    
    private func setup(){
        titleLabel = UILabel();
        titleLabel.translatesAutoresizingMaskIntoConstraints = false;
        titleLabel.text = "Enter your password";
        titleLabel.font = UIFont(name: "Montserrat-SemiBold", size: 18);
        titleLabel.textColor = UIColor.black;
        titleLabel.adjustsFontSizeToFitWidth = true;
        titleLabel.minimumScaleFactor = 0.1;
        titleLabel.numberOfLines = 1;
        titleLabel.textAlignment = .center;
        self.view.addSubview(titleLabel);
        titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true;
        titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive = true;
        titleLabel.widthAnchor.constraint(equalToConstant: (self.view.frame.size.width/3)*2).isActive = true;
        titleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true;
        
        passwordField = TextFieldPadded();
        passwordField.translatesAutoresizingMaskIntoConstraints = false;
        passwordField.placeholder = "Current Password";
        passwordField.isSecureTextEntry = true;
        passwordField.font = UIFont.systemFont(ofSize: 14);
        passwordField.textColor = UIColor.black;
        passwordField.borderStyle = .roundedRect;
        passwordField.backgroundColor = UIColor.veryLightGray;
        passwordField.textAlignment = .center;
        passwordField.delegate = self;
        self.view.addSubview(passwordField);
        passwordField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true;
        passwordField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true;
        passwordField.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10).isActive = true;
        passwordField.heightAnchor.constraint(equalToConstant: 30).isActive = true;
        passwordField.returnKeyType = .go;
        
        errorMessage = UILabel();
        errorMessage.translatesAutoresizingMaskIntoConstraints = false;
        errorMessage.text = "You enter your password wrong";
        errorMessage.textAlignment = .center;
        errorMessage.font = UIFont.italicSystemFont(ofSize: 10);
        errorMessage.numberOfLines = 1;
        errorMessage.adjustsFontSizeToFitWidth = true;
        errorMessage.minimumScaleFactor = 0.1;
        errorMessage.textColor = UIColor.red;
        self.view.addSubview(errorMessage);
        errorMessage.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true;
        errorMessage.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true;
        errorMessage.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 10).isActive = true;
        errorMessage.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        errorMessage.isHidden = true;
        
        nextButton = UIButton(type: .system);
        nextButton.translatesAutoresizingMaskIntoConstraints = false;
        nextButton.setTitle("Next", for: .normal);
        nextButton.setTitleColor(UIColor.black, for: .normal);
        nextButton.backgroundColor = UIColor.appYellow;
        nextButton.layer.cornerRadius = 5;
        nextButton.layer.borderColor = UIColor.lightGray.cgColor;
        nextButton.layer.borderWidth = 0.25;
        nextButton.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 16);
        self.view.addSubview(nextButton);
        nextButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true;
        nextButton.topAnchor.constraint(equalTo: errorMessage.bottomAnchor, constant: 10).isActive = true;
        nextButton.widthAnchor.constraint(equalToConstant: 200).isActive = true;
        nextButton.heightAnchor.constraint(equalToConstant: 40).isActive = true;
        nextButton.addTarget(self, action: #selector(self.tryNext), for: .touchUpInside);
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.tryNext();
        return true;
    }
    
    @objc private func tryNext(){
        if(self.passwordField.text! != password!){
            self.errorMessage.isHidden = false;
        }else{
            //go to nextPage
            let nextPasswordPage = ChangePasswordPage2();
            self.navigationController?.pushViewController(nextPasswordPage, animated: true);
        }
    }
}
