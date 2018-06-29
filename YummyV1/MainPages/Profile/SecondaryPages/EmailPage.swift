//
//  EmailPage.swift
//  YummyV1
//
//  Created by Brandon In on 1/25/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import Foundation
import UIKit

class EmailPage: UIViewController, UITextFieldDelegate{
    //need: TextFieldPadded, 2 UILabels, submit
    //MARK: Elements
    
    var titleLabel: UILabel!;
    var emailField: TextFieldPadded!;
    var submitButton: UIButton!;
    var errorMessage: UILabel!;
    
    var email:String?
    var password: String?
    var userID: String?
    
    override func viewDidLoad() {
        let backButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil);
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton;
        self.navigationItem.title = "Email";
        self.view.backgroundColor = UIColor.white;
        setup();
    }
    
    private func setup(){
//        print(userID);
        titleLabel = UILabel();
        titleLabel.translatesAutoresizingMaskIntoConstraints = false;
        titleLabel.text = "Email: ";
        titleLabel.font = UIFont(name: "Montserrat-SemiBold", size: 16);
        titleLabel.textAlignment = .center;
        titleLabel.textColor = UIColor.black;
        self.view.addSubview(titleLabel);
        titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true;
        titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive = true;
        titleLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true;
        titleLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        
        emailField = TextFieldPadded();
        emailField.translatesAutoresizingMaskIntoConstraints = false;
        emailField.placeholder = "\(email!)";
        emailField.font = UIFont.systemFont(ofSize: 14);
        emailField.keyboardType = .emailAddress;
        emailField.autocorrectionType = .no;
        emailField.spellCheckingType = .no;
        emailField.delegate = self;
//        emailField.isUserInteractionEnabled = false;
        emailField.borderStyle = .roundedRect;
        emailField.backgroundColor = UIColor.veryLightGray;
        self.view.addSubview(emailField);
        emailField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true;
        emailField.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 15).isActive = true;
        emailField.widthAnchor.constraint(equalToConstant: (self.view.frame.width/4)*3).isActive = true;
        emailField.heightAnchor.constraint(equalToConstant: 30).isActive = true;
        
        errorMessage = UILabel();
        errorMessage.translatesAutoresizingMaskIntoConstraints = false;
        errorMessage.text = "You did not enter your password correctly";
        errorMessage.textColor = UIColor.red;
        errorMessage.textAlignment = .center;
        errorMessage.font = UIFont.italicSystemFont(ofSize: 10);
        self.view.addSubview(errorMessage);
        errorMessage.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true;
        errorMessage.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true;
        errorMessage.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 5).isActive = true;
        errorMessage.heightAnchor.constraint(equalToConstant: 20).isActive = true;
        errorMessage.isHidden = true;
        
        
        submitButton = UIButton(type: .system);
        submitButton.translatesAutoresizingMaskIntoConstraints = false;
        submitButton.setTitle("Submit", for: .normal);
        submitButton.backgroundColor = UIColor.appYellow;
        submitButton.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 18);
        submitButton.setTitleColor(UIColor.black, for: .normal);
        submitButton.layer.cornerRadius = 5;
        self.view.addSubview(submitButton);
        submitButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true;
        submitButton.topAnchor.constraint(equalTo: self.errorMessage.bottomAnchor, constant: 20).isActive = true;
        submitButton.widthAnchor.constraint(equalToConstant: 200).isActive = true;
        submitButton.heightAnchor.constraint(equalToConstant: 40).isActive = true;
        submitButton.addTarget(self, action: #selector(self.submit), for: .touchUpInside);
        
    }
    
    @objc private func submit(){
        let alerts = UIAlertController(title: "Enter password", message: "Enter your password to submit", preferredStyle: .alert);
        alerts.addTextField { (textField) in
            textField.placeholder = "your password";
            textField.isSecureTextEntry = true;
        }
        alerts.addAction(UIAlertAction(title: "Submit", style: .default, handler: { (alert) in
            let textField = alerts.textFields![0];
            if(textField.text! != self.password!){
                textField.text = "";
                textField.placeholder = "Wrong password";
                self.errorMessage.isHidden = false;
            }else{
                self.submitEmailToServer();
            }
        }))
        self.present(alerts, animated: true, completion: nil);
        
    }
    
    private func submitEmailToServer(){
        let conn = Conn();
        let postBody = "UserID=\(userID!)&Email=\(emailField.text!)"
        conn.connect(fileName: "ChangeEmail.php", postString: postBody) { (re) in
            DispatchQueue.main.async {
                self.email = self.emailField.text!
                defaults.removeObject(forKey: "email");
                defaults.set(self.emailField.text!, forKey: "email");
                self.navigationController?.popViewController(animated: true);
            }
        }
    }
}
