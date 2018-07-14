//
//  SignUpView.swift
//  YummyV1
//
//  Created by Brandon In on 7/14/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class SignUpView: UIView, UITextFieldDelegate{
    
    var profileLoginPage: ProfileLogin?
    var mainView: UIView?;
    private let termsLink = "https://ondeliveryinc.com/terms.html";
    private let privacyLink = "https://ondeliveryinc.com/privacy.html";
    
    lazy var telephoneField: ProfileLoginSignUpCell = {
        let telephoneField = ProfileLoginSignUpCell();
        telephoneField.translatesAutoresizingMaskIntoConstraints = false;
        telephoneField.setTitle(titleString: "Telephone");
        telephoneField.layer.borderWidth = 0.3;
        telephoneField.layer.borderColor = UIColor.veryLightGray.cgColor;
        telephoneField.backgroundColor = UIColor.white;
        telephoneField.textField.delegate = self;
        telephoneField.textField.keyboardType = .phonePad;
        telephoneField.textField.addTarget(self, action: #selector(self.textDidChange(sender:)), for: .editingChanged);
        return telephoneField;
    }()
    
    lazy var emailField: ProfileLoginSignUpCell = {
        let emailField = ProfileLoginSignUpCell();
        emailField.translatesAutoresizingMaskIntoConstraints = false;
        emailField.setTitle(titleString: "Email");
        emailField.layer.borderWidth = 0.3;
        emailField.layer.borderColor = UIColor.veryLightGray.cgColor;
        emailField.backgroundColor = UIColor.white;
        emailField.textField.delegate = self;
        emailField.textField.keyboardType = .emailAddress;
        return emailField;
    }()
    
    lazy var firstNameField: ProfileLoginSignUpCell = {
        let firstNameField = ProfileLoginSignUpCell();
        firstNameField.translatesAutoresizingMaskIntoConstraints = false;
        firstNameField.setTitle(titleString: "First Name");
        firstNameField.layer.borderWidth = 0.3;
        firstNameField.layer.borderColor = UIColor.veryLightGray.cgColor;
        firstNameField.backgroundColor = UIColor.white;
        firstNameField.textField.delegate = self;
        return firstNameField;
    }()
    
    lazy var lastNameField: ProfileLoginSignUpCell = {
        let lastNameField = ProfileLoginSignUpCell();
        lastNameField.translatesAutoresizingMaskIntoConstraints = false;
        lastNameField.setTitle(titleString: "Last Name");
        lastNameField.layer.borderWidth = 0.3;
        lastNameField.layer.borderColor = UIColor.veryLightGray.cgColor;
        lastNameField.textField.delegate = self;
        lastNameField.backgroundColor = UIColor.white;
        return lastNameField;
    }()
    
    lazy var passwordField: ProfileLoginSignUpCell = {
        let passwordField = ProfileLoginSignUpCell();
        passwordField.translatesAutoresizingMaskIntoConstraints = false;
        passwordField.setTitle(titleString: "Password");
        passwordField.layer.borderWidth = 0.25;
        passwordField.layer.borderColor = UIColor.veryLightGray.cgColor;
        passwordField.textField.delegate = self;
        passwordField.textField.isSecureTextEntry = true;
        passwordField.textField.returnKeyType = .go;
        passwordField.textField.placeholder = "At least 7 characters";
        passwordField.backgroundColor = UIColor.white;
        return passwordField;
    }()
    
    lazy var signUpButton: UIButton = {
        let signUpButton = UIButton(type: .system);
        signUpButton.translatesAutoresizingMaskIntoConstraints = false;
        signUpButton.setTitle("Sign Up", for: .normal);
        signUpButton.setTitleColor(UIColor.black, for: .normal);
        signUpButton.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 16);
        signUpButton.backgroundColor = UIColor.appYellow;
        signUpButton.layer.cornerRadius = 3;
        signUpButton.layer.borderColor = UIColor.gray.cgColor;
        signUpButton.addTarget(self, action: #selector(submitFields), for: .touchUpInside);
        return signUpButton;
    }()
    
    lazy var termsAndConditions: UITextView = {
        let termsAndConditions = UITextView();
        termsAndConditions.translatesAutoresizingMaskIntoConstraints = false;
        termsAndConditions.textAlignment = .center;
        termsAndConditions.isEditable = false;
        termsAndConditions.isScrollEnabled = false;
        termsAndConditions.textColor = UIColor.gray;
        termsAndConditions.backgroundColor = UIColor.veryLightGray;
        termsAndConditions.font = UIFont.systemFont(ofSize: 12);
        termsAndConditions.text = "Hello World this is your manager speaking"
        return termsAndConditions;
    }()
    
//    override init(frame: CGRect) {
//        super.init(frame: frame);
//    }
    
    init(mainView: UIView){
        super.init(frame: .zero);
        self.mainView = mainView;
        self.translatesAutoresizingMaskIntoConstraints = false;
        setup();
        setupTerms();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    func setup(){
        
        self.addSubview(telephoneField);
        self.addSubview(emailField);
        self.addSubview(firstNameField);
        self.addSubview(lastNameField);
        self.addSubview(passwordField);
        self.addSubview(signUpButton);
        self.addSubview(termsAndConditions);
        
        telephoneField.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        telephoneField.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        telephoneField.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true;
        telephoneField.heightAnchor.constraint(equalToConstant: 45).isActive = true;
        
        emailField.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        emailField.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        emailField.topAnchor.constraint(equalTo: self.telephoneField.bottomAnchor).isActive = true;
        emailField.heightAnchor.constraint(equalToConstant: 45).isActive = true;
        
        firstNameField.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        firstNameField.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        firstNameField.topAnchor.constraint(equalTo: self.emailField.bottomAnchor).isActive = true;
        firstNameField.heightAnchor.constraint(equalToConstant: 45).isActive = true;
        
        lastNameField.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        lastNameField.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        lastNameField.topAnchor.constraint(equalTo: self.firstNameField.bottomAnchor).isActive = true;
        lastNameField.heightAnchor.constraint(equalToConstant: 45).isActive = true;
        
        passwordField.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        passwordField.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        passwordField.topAnchor.constraint(equalTo: self.lastNameField.bottomAnchor).isActive = true;
        passwordField.heightAnchor.constraint(equalToConstant: 45).isActive = true;
        
        termsAndConditions.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        termsAndConditions.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        termsAndConditions.topAnchor.constraint(equalTo: self.passwordField.bottomAnchor, constant: 10).isActive = true;
        termsAndConditions.heightAnchor.constraint(equalToConstant: 50).isActive = true;
//        termsAndConditions.backgroundColor = UIColor.black;
        
        signUpButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 25).isActive = true;
        signUpButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -25).isActive = true;
        signUpButton.topAnchor.constraint(equalTo: self.termsAndConditions.bottomAnchor, constant: 10).isActive = true;
        signUpButton.heightAnchor.constraint(equalToConstant: 50).isActive = true;
    }
    
    func setupTerms(){
        let originalText = "By completing the form, you are agreeing to our Terms Of Service and Privacy Policy";
        let attributedOriginalText = NSMutableAttributedString(string: originalText);
        let centerAlignment = NSMutableParagraphStyle();
        centerAlignment.alignment = .center;
        let termsLinkRange = attributedOriginalText.mutableString.range(of: "Terms Of Service");
        let privacyLinkRange = attributedOriginalText.mutableString.range(of: "Privacy Policy");
        attributedOriginalText.addAttribute(.link, value: termsLink, range: termsLinkRange);
        attributedOriginalText.addAttribute(.link, value: privacyLink, range: privacyLinkRange);
        attributedOriginalText.addAttribute(.paragraphStyle, value: centerAlignment, range: NSMakeRange(0, attributedOriginalText.length));
        attributedOriginalText.addAttribute(.foregroundColor, value: UIColor.gray, range: NSMakeRange(0, attributedOriginalText.length));
        attributedOriginalText.addAttribute(.font, value: UIFont(name: "Montserrat-Regular", size: 11)!, range: NSMakeRange(0, attributedOriginalText.length));
        
        self.termsAndConditions.attributedText = attributedOriginalText;
        self.termsAndConditions.linkTextAttributes = [NSAttributedStringKey.underlineStyle.rawValue : NSUnderlineStyle.styleSingle.rawValue]
    }
    
    @objc private func textDidChange(sender: TextFieldPadded){
        //get the text from numberField, analyze, and check the text
            var numberString = self.telephoneField.textField.text!;
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
            self.telephoneField.textField.text = numberString;
    }
    
    @objc func submitFields(){
        let telephoneTextField = self.telephoneField.textField;
        let emailTextField = self.emailField.textField;
        let firstNameTextField = self.firstNameField.textField;
        let lastnameTextField = self.lastNameField.textField;
        let passwordTextField = self.passwordField.textField;
        
        self.profileLoginPage?.skipButton.isEnabled = false;
        //        print(telephoneTextField.text);
        
        if(telephoneTextField.text!.count < 10 || emailTextField.text!.count < 4 || firstNameTextField.text!.count < 1 || lastnameTextField.text!.count < 1 || passwordTextField.text!.count < 7){
            //show error message
            let alert = UIAlertController(title: "Fill Out all Fields", message: "Fill Out All fields", preferredStyle: .alert);
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil));
            self.profileLoginPage?.present(alert, animated: true, completion: nil);
            self.profileLoginPage?.skipButton.isEnabled = true;
        }else{
            //send to server
            profileLoginPage?.sendToServer(telephoneSignUp: telephoneTextField.text!, emailSignUp: emailTextField.text!, firstNameSignUp: firstNameTextField.text!, lastNameSignUp: lastnameTextField.text!, passwordSignUp: passwordTextField.text!);
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.telephoneField.textField.resignFirstResponder();
        self.emailField.textField.resignFirstResponder();
        self.firstNameField.textField.resignFirstResponder();
        self.lastNameField.textField.resignFirstResponder();
        self.passwordField.textField.resignFirstResponder();
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch(textField){
        case self.telephoneField.textField: emailField.textField.becomeFirstResponder();break;
        case self.emailField.textField: firstNameField.textField.becomeFirstResponder();break;
        case self.firstNameField.textField: lastNameField.textField.becomeFirstResponder();break;
        case self.lastNameField.textField: passwordField.textField.becomeFirstResponder();break;
        case self.passwordField.textField: self.submitFields();break;
        default: break;
        }
        return true;
    }
}
