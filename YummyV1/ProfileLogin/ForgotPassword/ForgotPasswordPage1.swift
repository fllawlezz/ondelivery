//
//  ForgotPasswordPage1.swift
//  YummyV1
//
//  Created by Brandon In on 6/26/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class ForgotPasswordPage1: UIViewController{
    //MARK: Elements
    //imageView, backgroundView, backButton, title, codeField, nextButton
//    var imageView: UIImageView!;
    var backgroundView: UIView!;
    var titleField: UILabel!;
    var backButton: UIButton!;
    var codeField: TextFieldPadded!;
    var errorMessage: UILabel!;
    var nextButton: UIButton!;
    
    var code: String?
    
    override func viewDidLoad() {
        setup();
    }
    
    @objc private func backToRoot(){
        self.navigationController?.popToRootViewController(animated: true);
    }
    
    private func setup(){
        let backNavButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backButtonWhite"), style: .plain, target: self, action: #selector(self.backToRoot));
        self.navigationItem.leftBarButtonItem = backNavButton;
        
        self.view.backgroundColor = UIColor.white;
        //        self.navigationController?.navigationBar.isHidden = true;
        
//        imageView = UIImageView();
//        imageView.translatesAutoresizingMaskIntoConstraints = false;
//        imageView.image = #imageLiteral(resourceName: "spaghetti");
//        self.view.addSubview(imageView);
//        //need x,y,width,height
//        imageView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
//        imageView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
//        imageView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true;
//        imageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true;
        
        backgroundView = UIView();
        backgroundView.translatesAutoresizingMaskIntoConstraints = false;
        backgroundView.backgroundColor = UIColor.white;
        backgroundView.layer.cornerRadius = 5;
        self.view.addSubview(backgroundView);
        backgroundView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true;
        backgroundView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true;
        backgroundView.widthAnchor.constraint(equalToConstant: (self.view.frame.size.width/4)*3).isActive = true;
        backgroundView.heightAnchor.constraint(equalToConstant: (self.view.frame.size.height/3)*2).isActive = true;
        
        //title field
        titleField = UILabel();
        titleField.translatesAutoresizingMaskIntoConstraints = false;
        titleField.text = "Enter the code sent to your phone";
        titleField.font = UIFont(name: "Montserrat-SemiBold", size: 18);
        titleField.textColor = UIColor.black;
        titleField.textAlignment = .center;
        titleField.adjustsFontSizeToFitWidth = true;
        titleField.numberOfLines = 1;
        titleField.minimumScaleFactor = 0.1;
        self.view.addSubview(titleField);
        titleField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true;
        titleField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true;
        titleField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60).isActive = true;
        titleField.heightAnchor.constraint(equalToConstant: 30).isActive = true;
        
        //backButton
        backButton = UIButton(type: .system);
        backButton.setBackgroundImage(#imageLiteral(resourceName: "clear"), for: .normal);
        backButton.translatesAutoresizingMaskIntoConstraints = false;
        self.view.addSubview(backButton);
        backButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true;
        backButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 35).isActive = true;
        backButton.widthAnchor.constraint(equalToConstant: 20).isActive = true;
        backButton.heightAnchor.constraint(equalToConstant: 20).isActive = true;
        backButton.addTarget(self, action: #selector(self.back), for: .touchUpInside);
        backButton.isHidden = true;
        addBackground();
    }
    
    private func addBackground(){
        codeField = TextFieldPadded();
        codeField.translatesAutoresizingMaskIntoConstraints = false;
        codeField.backgroundColor = UIColor.veryLightGray;
        codeField.placeholder = "Enter your code here"
        codeField.textAlignment = .center;
        codeField.borderStyle = .roundedRect;
        codeField.font = UIFont(name: "Montserrat-Regular", size: 14);
        codeField.keyboardType = .numberPad;
        self.backgroundView.addSubview(codeField);
        codeField.leftAnchor.constraint(equalTo: self.backgroundView.leftAnchor, constant: 15).isActive = true;
        codeField.rightAnchor.constraint(equalTo: self.backgroundView.rightAnchor, constant: -15).isActive = true;
        codeField.topAnchor.constraint(equalTo: self.backgroundView.topAnchor, constant: 20).isActive = true;
        codeField.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        
        errorMessage = UILabel();
        errorMessage.translatesAutoresizingMaskIntoConstraints = false;
        errorMessage.text = "The code does not match";
        errorMessage.minimumScaleFactor = 0.1;
        errorMessage.adjustsFontSizeToFitWidth = true;
        errorMessage.numberOfLines = 1;
        errorMessage.font = UIFont.italicSystemFont(ofSize: 10);
        errorMessage.textColor = UIColor.red;
        errorMessage.textAlignment = .center;
        self.backgroundView.addSubview(errorMessage);
        errorMessage.leftAnchor.constraint(equalTo: self.backgroundView.leftAnchor, constant: 10).isActive = true;
        errorMessage.rightAnchor.constraint(equalTo: self.backgroundView.rightAnchor, constant: -10).isActive = true;
        errorMessage.topAnchor.constraint(equalTo: self.codeField.bottomAnchor, constant: 10).isActive = true;
        errorMessage.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        errorMessage.isHidden = true;
        
        nextButton = UIButton(type: .system);
        nextButton.translatesAutoresizingMaskIntoConstraints = false;
        nextButton.backgroundColor = UIColor.appYellow;
        nextButton.setTitle("Next", for: .normal);
        nextButton.setTitleColor(UIColor.black, for: .normal);
        nextButton.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 18);
        nextButton.layer.cornerRadius = 5;
        self.backgroundView.addSubview(nextButton);
        nextButton.leftAnchor.constraint(equalTo: self.backgroundView.leftAnchor, constant: 15).isActive = true;
        nextButton.rightAnchor.constraint(equalTo: self.backgroundView.rightAnchor, constant: -15).isActive = true;
        nextButton.centerYAnchor.constraint(equalTo: self.backgroundView.centerYAnchor).isActive = true;
        nextButton.heightAnchor.constraint(equalToConstant: 40).isActive = true;
        nextButton.addTarget(self, action: #selector(self.nextField), for: .touchUpInside);
        
    }
    
    //MARK: Button Fncs
    @objc private func back(){
        self.navigationController?.navigationBar.isHidden = false;
        self.navigationController?.popToRootViewController(animated: true);
    }
    
    @objc private func nextField(){
        //check to see if the code matches
        if(codeField.text! != code){
            codeField.text = "";
            errorMessage.isHidden = false;
        }else{
            let forgotPage2 = Forgotpasswordpage2();
            self.navigationController?.pushViewController(forgotPage2, animated: true);
        }
    }
}
