//
//  ForgotPasswordPage2.swift
//  YummyV1
//
//  Created by Brandon In on 6/26/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class Forgotpasswordpage2: UIViewController, UITextFieldDelegate{
    /*
     Needs: Password Field, PasswordFieldConfirm, BackgroundView, backgroundImageView, Clear Button/BackButton, Submit button, title
     */
    //MARK: Elements
    var passwordField: TextFieldPadded!;
    var confirmField: TextFieldPadded!;
    var backgroundImageView: UIImageView!;
    var backgroundView: UIView!;
    var clearButton: UIButton!;
    var submitButton: UIButton!;
    var titleLabel: UILabel!;
    var errorMessage: UILabel!;
    
    var telephone: String?
    
    @objc private func backToRoot(){
        self.navigationController?.popToRootViewController(animated: true);
    }
    
    override func viewDidLoad() {
        let backNavButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backButtonWhite"), style: .plain, target: self, action: #selector(self.backToRoot));
        self.navigationItem.leftBarButtonItem = backNavButton;
        setup();
    }
    
    private func setup(){
        
        backgroundImageView = UIImageView();
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false;
        backgroundImageView.image = #imageLiteral(resourceName: "spaghetti");
        self.view.addSubview(backgroundImageView);
        backgroundImageView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        backgroundImageView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        backgroundImageView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true;
        backgroundImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true;
        
        //backgroundView
        backgroundView = UIView();
        backgroundView.translatesAutoresizingMaskIntoConstraints = false;
        backgroundView.backgroundColor = UIColor.white;
        backgroundView.layer.cornerRadius = 5;
        self.view.addSubview(backgroundView);
        backgroundView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true;
        backgroundView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true;
        backgroundView.widthAnchor.constraint(equalToConstant: (self.view.frame.size.width/4)*3).isActive = true;
        backgroundView.heightAnchor.constraint(equalToConstant: (self.view.frame.size.height/3)*2).isActive = true;
        
        titleLabel = UILabel();
        titleLabel.translatesAutoresizingMaskIntoConstraints = false;
        titleLabel.text = "Enter your new Password";
        titleLabel.textAlignment = .center;
        titleLabel.textColor = UIColor.black;
        titleLabel.font = UIFont(name: "Copperplate", size: 20);
        titleLabel.adjustsFontSizeToFitWidth = true;
        titleLabel.minimumScaleFactor = 0.1;
        titleLabel.numberOfLines = 1;
        self.view.addSubview(titleLabel);
        titleLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        titleLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 45).isActive = true;
        titleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true;
        
        clearButton = UIButton(type: .system);
        clearButton.translatesAutoresizingMaskIntoConstraints = false;
        clearButton.setBackgroundImage(#imageLiteral(resourceName: "clear"), for: .normal);
        self.view.addSubview(clearButton);
        clearButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true;
        clearButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 25).isActive = true;
        clearButton.widthAnchor.constraint(equalToConstant: 20).isActive = true;
        clearButton.heightAnchor.constraint(equalToConstant: 20).isActive = true;
        clearButton.addTarget(self, action: #selector(self.clear), for: .touchUpInside);
        clearButton.isHidden = true;
        
        addBackground();
    }
    
    private func addBackground(){
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
        self.backgroundView.addSubview(passwordField);
        passwordField.leftAnchor.constraint(equalTo: self.backgroundView.leftAnchor, constant: 10).isActive = true;
        passwordField.rightAnchor.constraint(equalTo: self.backgroundView.rightAnchor, constant: -15).isActive = true;
        passwordField.topAnchor.constraint(equalTo: self.backgroundView.topAnchor, constant: 20).isActive = true;
        passwordField.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        
        confirmField = TextFieldPadded();
        confirmField.translatesAutoresizingMaskIntoConstraints = false;
        confirmField.backgroundColor = UIColor.veryLightGray;
        confirmField.placeholder = "Confirm Password";
        confirmField.borderStyle = .roundedRect;
        confirmField.textAlignment = .center;
        confirmField.font = UIFont.systemFont(ofSize: 15);
        confirmField.spellCheckingType = .no;
        confirmField.autocorrectionType = .no;
        confirmField.isSecureTextEntry = true;
        confirmField.delegate = self;
        self.backgroundView.addSubview(confirmField);
        confirmField.leftAnchor.constraint(equalTo: self.backgroundView.leftAnchor, constant: 10).isActive = true;
        confirmField.rightAnchor.constraint(equalTo: self.backgroundView.rightAnchor, constant: -10).isActive = true;
        confirmField.topAnchor.constraint(equalTo: self.passwordField.bottomAnchor, constant: 15).isActive = true;
        confirmField.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        
        errorMessage = UILabel();
        errorMessage.translatesAutoresizingMaskIntoConstraints = false;
        errorMessage.text = "Passwords do not Match";
        errorMessage.font = UIFont.italicSystemFont(ofSize: 10);
        errorMessage.textColor = UIColor.red;
        errorMessage.textAlignment = .center;
        self.backgroundView.addSubview(errorMessage);
        errorMessage.leftAnchor.constraint(equalTo: self.backgroundView.leftAnchor, constant: 10).isActive = true;
        errorMessage.rightAnchor.constraint(equalTo: self.backgroundView.rightAnchor, constant: -10).isActive = true;
        errorMessage.topAnchor.constraint(equalTo: self.confirmField.bottomAnchor, constant: 10).isActive = true;
        errorMessage.heightAnchor.constraint(equalToConstant: 20).isActive = true;
        errorMessage.isHidden = true;
        
        submitButton = UIButton(type: .system);
        submitButton.translatesAutoresizingMaskIntoConstraints = false;
        submitButton.backgroundColor = UIColor.appYellow;
        submitButton.setTitle("Finish", for: .normal);
        submitButton.setTitleColor(UIColor.black, for: .normal);
        submitButton.titleLabel?.font = UIFont(name: "Copperplate", size: 18);
        submitButton.layer.cornerRadius = 5;
        self.backgroundView.addSubview(submitButton);
        submitButton.leftAnchor.constraint(equalTo: self.backgroundView.leftAnchor, constant: 10).isActive = true;
        submitButton.rightAnchor.constraint(equalTo: self.backgroundView.rightAnchor, constant: -10).isActive = true;
        submitButton.centerYAnchor.constraint(equalTo: self.backgroundView.centerYAnchor).isActive = true;
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
                        self.clear();
                    }
                }
            })
        }
    }
    
    @objc private func clear(){
        //        let passwordPage = PasswordPage();
        telephone = nil;
        //        self.navigationController?.navigationBar.isHidden = false;
        self.navigationController?.popToRootViewController(animated: true);
    }
}
