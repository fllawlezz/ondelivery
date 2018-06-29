//
//  ChangePasswordPage2.swift
//  YummyV1
//
//  Created by Brandon In on 1/26/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import Foundation
import UIKit

class ChangePasswordPage2: UIViewController, UITextFieldDelegate{
    //need 2 textFields, 3 UIlabels, 1 Button
    //MARK: Elements
    var telephone: String?
    var password: String?
    //MARK: Elements
    var passwordField: TextFieldPadded!;
    var confirmField: TextFieldPadded!;
    var submitButton: UIButton!;
    var titleLabel: UILabel!;
    var errorMessage: UILabel!;
    
    override func viewDidLoad() {
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backButtonWhite"), style: .plain, target: self, action: #selector(self.backAllTheWay));
        self.navigationItem.setLeftBarButton(backButton, animated: true);
        self.navigationItem.title = "New Password";
        
        self.view.backgroundColor = UIColor.white;
        setup();
    }
    
    private func setup(){
        
        titleLabel = UILabel();
        titleLabel.translatesAutoresizingMaskIntoConstraints = false;
        titleLabel.text = "Enter your new Password";
        titleLabel.textAlignment = .center;
        titleLabel.textColor = UIColor.black;
        titleLabel.font = UIFont(name: "Montserrat-SemiBold", size: 20);
        titleLabel.adjustsFontSizeToFitWidth = true;
        titleLabel.minimumScaleFactor = 0.1;
        titleLabel.numberOfLines = 1;
        self.view.addSubview(titleLabel);
        titleLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        titleLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive = true;
        titleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true;
        
        passwordField = TextFieldPadded();
        passwordField.translatesAutoresizingMaskIntoConstraints = false;
        passwordField.backgroundColor = UIColor.veryLightGray;
        passwordField.placeholder = "New Password";
        passwordField.borderStyle = .roundedRect;
        passwordField.textAlignment = .center;
        passwordField.font = UIFont.systemFont(ofSize: 15);
        passwordField.textColor = UIColor.black;
        passwordField.spellCheckingType = .no;
        passwordField.autocorrectionType = .no;
        passwordField.isSecureTextEntry = true;
        passwordField.returnKeyType = .next;
        passwordField.delegate = self;
        self.view.addSubview(passwordField);
        passwordField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true;
        passwordField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -15).isActive = true;
        passwordField.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 20).isActive = true;
        passwordField.heightAnchor.constraint(equalToConstant: 30).isActive = true;
        
        confirmField = TextFieldPadded();
        confirmField.translatesAutoresizingMaskIntoConstraints = false;
        confirmField.backgroundColor = UIColor.veryLightGray;
        confirmField.placeholder = "Confirm Password";
        confirmField.borderStyle = .roundedRect;
        confirmField.textAlignment = .center;
        confirmField.font = UIFont.systemFont(ofSize: 15);
        confirmField.spellCheckingType = .no;
        confirmField.autocorrectionType = .no;
        confirmField.returnKeyType = .go;
        confirmField.isSecureTextEntry = true;
        confirmField.delegate = self;
        self.view.addSubview(confirmField);
        confirmField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true;
        confirmField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true;
        confirmField.topAnchor.constraint(equalTo: self.passwordField.bottomAnchor, constant: 15).isActive = true;
        confirmField.heightAnchor.constraint(equalToConstant: 30).isActive = true;
        
        errorMessage = UILabel();
        errorMessage.translatesAutoresizingMaskIntoConstraints = false;
        errorMessage.text = "Passwords do not Match";
        errorMessage.font = UIFont.italicSystemFont(ofSize: 10);
        errorMessage.textColor = UIColor.red;
        errorMessage.textAlignment = .center;
        self.view.addSubview(errorMessage);
        errorMessage.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true;
        errorMessage.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true;
        errorMessage.topAnchor.constraint(equalTo: self.confirmField.bottomAnchor, constant: 10).isActive = true;
        errorMessage.heightAnchor.constraint(equalToConstant: 30).isActive = true;
        errorMessage.isHidden = true;
        
        submitButton = UIButton(type: .system);
        submitButton.translatesAutoresizingMaskIntoConstraints = false;
        submitButton.backgroundColor = UIColor.appYellow;
        submitButton.setTitle("Finish", for: .normal);
        submitButton.setTitleColor(UIColor.black, for: .normal);
        submitButton.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 16);
        submitButton.layer.cornerRadius = 5;
        self.view.addSubview(submitButton);
        submitButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true;
        submitButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true;
        submitButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true;
        submitButton.heightAnchor.constraint(equalToConstant: 40).isActive = true;
        submitButton.addTarget(self, action: #selector(self.finish), for: .touchUpInside);
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField == passwordField){
            confirmField.becomeFirstResponder();
        }else if(textField == confirmField){
            finish();
        }
        return true;
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        confirmField.resignFirstResponder();
        passwordField.resignFirstResponder();
    }
    
    
    //MARK: Button Functions
    @objc private func finish(){
        //        print("finish");
        //        print(passwordField.text!);
        if(passwordField.text!.count < 6){
            self.errorMessage.isHidden = false;
            self.errorMessage.text = "Password must be more than 6 characters"
        }else if(passwordField.text! != confirmField.text!){
            self.errorMessage.isHidden = false;
            self.errorMessage.text = "Passwords don't match";
        }else{
            //change passwords
            let conn = Conn();
            let postBody = "Telephone=\(telephone!)&Password=\(self.passwordField.text!)";
            print(postBody);
            conn.connect(fileName: "ChangePassword.php", postString: postBody, completion: { (re) in
                let result = re as String;
                if(result == "complete"){
                    DispatchQueue.main.async {
                        self.password = self.passwordField.text!
                        defaults.removeObject(forKey: "password");
                        defaults.set(self.password, forKey: "password");
                        self.backAllTheWay();
                    }
                }
            })
        }
    }
    
    @objc private func backAllTheWay(){
        self.navigationController?.popToRootViewController(animated: true);
    }
}
