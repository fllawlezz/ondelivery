//
//  LoginView.swift
//  YummyV1
//
//  Created by Brandon In on 7/14/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class LoginView: UIView, UITextFieldDelegate{
    
    var profileLoginPage: ProfileLogin?
    
    lazy var loginTelephoneField: ProfileLoginSignUpCell = {
        let loginTelephoneField = ProfileLoginSignUpCell();
        loginTelephoneField.translatesAutoresizingMaskIntoConstraints = false;
        loginTelephoneField.setTitle(titleString: "Telephone");
        loginTelephoneField.layer.borderWidth = 0.25;
        loginTelephoneField.layer.borderColor = UIColor.veryLightGray.cgColor;
        loginTelephoneField.textField.delegate = self;
        loginTelephoneField.textField.keyboardType = .numberPad;
        loginTelephoneField.textField.returnKeyType = .next;
        loginTelephoneField.textField.placeholder = "Telephone";
        loginTelephoneField.textField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        loginTelephoneField.backgroundColor = UIColor.white;
        return loginTelephoneField;
    }()
    
    lazy var loginPasswordField: ProfileLoginSignUpCell = {
        let loginPasswordField = ProfileLoginSignUpCell();
        loginPasswordField.translatesAutoresizingMaskIntoConstraints = false;
        loginPasswordField.setTitle(titleString: "Password");
        loginPasswordField.layer.borderWidth = 0.25;
        loginPasswordField.layer.borderColor = UIColor.veryLightGray.cgColor;
        loginPasswordField.textField.delegate = self;
        loginPasswordField.textField.isSecureTextEntry = true;
        loginPasswordField.textField.returnKeyType = .go;
        loginPasswordField.textField.placeholder = "Password";
        loginPasswordField.backgroundColor = UIColor.white;
        return loginPasswordField;
    }()
    
    lazy var forgotPassword: UIButton = {
        let forgotPassword = UIButton(type: .system);
        forgotPassword.translatesAutoresizingMaskIntoConstraints = false;
        forgotPassword.setTitle("Forgot Password", for: .normal);
        forgotPassword.setTitleColor(UIColor.blue, for: .normal);
        forgotPassword.titleLabel?.font = UIFont(name: "Montserrat-Italic", size: 12)
        forgotPassword.addTarget(self, action: #selector(self.forgotPasswordFunction), for: .touchUpInside);
        return forgotPassword;
    }()
    
    lazy var loginButton: UIButton = {
        let loginButton = UIButton(type: .system);
        loginButton.translatesAutoresizingMaskIntoConstraints = false;
        loginButton.setTitle("Login", for: .normal);
        loginButton.setTitleColor(UIColor.black, for: .normal);
        loginButton.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 16);
        loginButton.backgroundColor = UIColor.appYellow;
        loginButton.layer.cornerRadius = 3;
        loginButton.layer.borderColor = UIColor.gray.cgColor;
        loginButton.addTarget(self, action: #selector(loginAttempt), for: .touchUpInside);
        return loginButton;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.translatesAutoresizingMaskIntoConstraints = false;
        setup();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    func setup(){
        
        self.addSubview(loginTelephoneField);
        self.addSubview(loginPasswordField);
        
        loginTelephoneField.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        loginTelephoneField.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        loginTelephoneField.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true;
        loginTelephoneField.heightAnchor.constraint(equalToConstant: 45).isActive = true;
        
        loginPasswordField.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        loginPasswordField.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        loginPasswordField.topAnchor.constraint(equalTo: self.loginTelephoneField.bottomAnchor).isActive = true;
        loginPasswordField.heightAnchor.constraint(equalToConstant: 45).isActive = true;
        
        self.addSubview(forgotPassword);
        forgotPassword.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        forgotPassword.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        forgotPassword.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        forgotPassword.topAnchor.constraint(equalTo: self.loginPasswordField.bottomAnchor, constant: 10).isActive = true;
        
        self.addSubview(loginButton);
        loginButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 25).isActive = true;
        loginButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -25).isActive = true;
        loginButton.topAnchor.constraint(equalTo: self.forgotPassword.bottomAnchor, constant: 10).isActive = true;
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true;
        loginButton.addTarget(self, action: #selector(loginAttempt), for: .touchUpInside);
        self.isHidden = true;
    }
    
    @objc func loginAttempt(){
        if(self.loginTelephoneField.textField.text!.count < 5 || self.loginPasswordField.textField.text!.count < 7){
            let alert = UIAlertController(title: "Fill Out all Fields", message: "Fill Out All fields", preferredStyle: .alert);
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil));
            self.profileLoginPage?.present(alert, animated: true, completion: nil);
        }else{
            //send to server and get result... if result is true, then dismiss and set selectedIndex = 4;
            self.loginTelephoneField.textField.resignFirstResponder();
            self.loginPasswordField.textField.resignFirstResponder();
            self.profileLoginPage?.spinner.animating = true;
            self.profileLoginPage?.spinner.updateAnimation();
            UIView.animate(withDuration: 0.3, animations: {
                self.profileLoginPage?.darkView.alpha = 0.7;
            })
            self.profileLoginPage?.checkPassword(telephone: self.loginTelephoneField.textField.text!, password: self.loginPasswordField.textField.text!);
        }
    }
    
    @objc private func textDidChange(sender: TextFieldPadded){
        //get the text from numberField, analyze, and check the text
            var numberString = self.loginTelephoneField.textField.text!;
            var num = 0;
            
            //remove characters
            numberString = numberString.replacingOccurrences(of: "(", with: "");
            numberString = numberString.replacingOccurrences(of: ")", with: "");
            numberString = numberString.replacingOccurrences(of: "-", with: "");
            
            for _ in numberString{
                num+=1;
            }
            if(num > 10){
                numberString.remove(at: numberString.index(numberString.startIndex, offsetBy: 9));
            }
            
            if(num>3){
                numberString.insert("(", at: numberString.startIndex);
                numberString.insert(")", at: numberString.index(numberString.startIndex, offsetBy: 4));
                numberString.insert("-", at: numberString.index(numberString.startIndex, offsetBy: 5));
            }
            if(num>6){
                numberString.insert("-", at: numberString.index(numberString.startIndex, offsetBy: 9));
            }
            self.loginTelephoneField.textField.text = numberString;
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.loginTelephoneField.textField.resignFirstResponder();
        self.loginPasswordField.textField.resignFirstResponder();
        self.profileLoginPage?.spinner.animating = true;
        self.profileLoginPage?.spinner.updateAnimation();
        UIView.animate(withDuration: 0.3, animations: {
            self.profileLoginPage?.darkView.alpha = 0.7;
        })
        self.profileLoginPage?.checkPassword(telephone: self.loginTelephoneField.textField.text!, password: self.loginPasswordField.textField.text!);
        return true;
    }
    
    @objc func forgotPasswordFunction(){
        let forgotPasswordPage = LoginForgot();
        self.profileLoginPage?.navigationController?.pushViewController(forgotPasswordPage, animated: true);
    }
}
