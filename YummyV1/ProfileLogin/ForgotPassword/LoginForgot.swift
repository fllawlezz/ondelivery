//
//  LoginForgot.swift
//  YummyV1
//
//  Created by Brandon In on 4/18/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class LoginForgot: UIViewController, UITextFieldDelegate{
    
    var code: String?
    var telephone: String?
    
    lazy var fieldView: UIView = {
        let fieldView = UIView();
        fieldView.translatesAutoresizingMaskIntoConstraints = false;
        fieldView.backgroundColor = UIColor.white;
        return fieldView;
    }()
    
    lazy var descriptionLabel: UILabel = {
        let description = UILabel();
        description.translatesAutoresizingMaskIntoConstraints = false;
        description.text = "Telephone Number";
        description.font = UIFont(name: "Montserrat-Regular", size: 12);
        description.textColor = UIColor.black;
        description.adjustsFontForContentSizeCategory = true;
        description.numberOfLines = 1;
        description.minimumScaleFactor = 0.1;
        description.textAlignment = .left;
        return description;
    }();
    
    lazy var textField: TextFieldPadded = {
        let textField = TextFieldPadded();
        textField.translatesAutoresizingMaskIntoConstraints = false;
        textField.placeholder = "Telephone";
        textField.keyboardType = .numberPad;
        textField.font = UIFont(name: "Montserrat-Regular", size: 14);
        textField.delegate = self;
        textField.returnKeyType = .go;
        textField.addTarget(self, action: #selector(self.textDidChange(sender:)), for: .editingChanged);
        return textField;
    }()
    
    lazy var sendCodeButton: UIButton = {
        let sendCodeButton = UIButton(type: .system);
        sendCodeButton.translatesAutoresizingMaskIntoConstraints = false;
        sendCodeButton.setTitle("Send Code", for: .normal);
        sendCodeButton.setTitleColor(UIColor.black, for: .normal);
        sendCodeButton.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 12);
        sendCodeButton.backgroundColor = UIColor.appYellow;
        sendCodeButton.addTarget(self, action: #selector(sendCode), for: .touchUpInside);
        return sendCodeButton;
    }()
    
    override func viewDidLoad() {
        let backButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil);
//        self.navigationItem.hidesBackButton = true;
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton;
//        self.navigationItem.backBarButtonItem = backButton;
        self.title = "Forgot Password";
        
        self.view.backgroundColor = UIColor.veryLightGray;
        
        self.view.addSubview(fieldView);
        fieldView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true;
        fieldView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 40).isActive = true;
        fieldView.widthAnchor.constraint(equalToConstant: (self.view.frame.width/3)*2).isActive = true;
        fieldView.heightAnchor.constraint(equalToConstant: 70).isActive = true;
        
        self.fieldView.addSubview(descriptionLabel);
        descriptionLabel.leftAnchor.constraint(equalTo: self.fieldView.leftAnchor, constant: 5).isActive = true;
        descriptionLabel.topAnchor.constraint(equalTo: self.fieldView.topAnchor, constant: 5).isActive = true;
        descriptionLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true;
        descriptionLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        
        self.fieldView.addSubview(textField);
        textField.leftAnchor.constraint(equalTo: self.fieldView.leftAnchor).isActive = true;
        textField.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor).isActive = true;
        textField.rightAnchor.constraint(equalTo: self.fieldView.rightAnchor).isActive = true;
        textField.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        
        self.view.addSubview(sendCodeButton);
        sendCodeButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true;
        sendCodeButton.widthAnchor.constraint(equalToConstant: (self.view.frame.width/4)*2).isActive = true;
        sendCodeButton.heightAnchor.constraint(equalToConstant: 40).isActive = true;
        sendCodeButton.topAnchor.constraint(equalTo: fieldView.bottomAnchor, constant: 20).isActive = true;
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField == self.textField){
            //send data function
            if(textField.text!.count >= 6){
                sendCode();
            }
        }
        return true;
    }
    
    @objc private func textDidChange(sender: TextFieldPadded){
        //get the text from numberField, analyze, and check the text
            var numberString = self.textField.text!;
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
            //        print(numberString);
            self.textField.text = numberString;
    }
    
    @objc private func sendCode(){
        let conn = Conn();
        let postString = "telephone=\(self.textField.text!)";
        conn.connect(fileName: "SendCode.php", postString: postString) { (re) in
            let result = re as String;
            self.code = result;
            DispatchQueue.main.async {
                //code saved
                self.telephone = self.textField.text!;
                let forgotPass = ForgotPasswordPage1();
                self.navigationController?.pushViewController(forgotPass, animated: true);
//                self.present(forgotPass, animated: true, completion: nil);
            }
        }
    }
}
