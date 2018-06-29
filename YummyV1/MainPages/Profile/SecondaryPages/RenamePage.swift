//
//  RenamePage.swift
//  YummyV1
//
//  Created by Brandon In on 1/4/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import Foundation
import UIKit

class RenamePage: UIViewController{
    
    var firstNameLabel: UILabel!;
    var lastNameLabel: UILabel!;
    var messageLabel: UILabel!;
    var firstNameBox: TextFieldPadded!;
    var lastNameBox: TextFieldPadded!;
    
    var firstName: String?
    var lastName: String?
    
    override func viewDidLoad() {
        let backButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil);
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton;
        
        self.navigationItem.title = "Your Name";
        self.view.backgroundColor = UIColor.white;
        setup();
    }
    
    private func setup(){
        //firstName label
        firstNameLabel = UILabel();
        firstNameLabel.translatesAutoresizingMaskIntoConstraints = false;
        firstNameLabel.text = "FirstName :";
        firstNameLabel.textColor = UIColor.black;
        firstNameLabel.font = UIFont(name: "Montserrat-SemiBold", size: 14);
        firstNameLabel.minimumScaleFactor = 0.1;
        firstNameLabel.numberOfLines = 1;
        firstNameLabel.adjustsFontSizeToFitWidth = true;
        self.view.addSubview(firstNameLabel);
        //firstname label needs x,y,width,height
        firstNameLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true;
        firstNameLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive = true;
        firstNameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true;
        firstNameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true;
        
        //firstName textBox
        firstNameBox = TextFieldPadded();
        firstNameBox.translatesAutoresizingMaskIntoConstraints = false;
        firstNameBox.borderStyle = .roundedRect;
        firstNameBox.text = "\(firstName!)";
        firstNameBox.textColor = UIColor.black;
        firstNameBox.font = UIFont(name: "Montserrat-Regular", size: 14);
        self.view.addSubview(firstNameBox);
        firstNameBox.leftAnchor.constraint(equalTo: self.firstNameLabel.rightAnchor, constant: 5).isActive = true;
        firstNameBox.centerYAnchor.constraint(equalTo: self.firstNameLabel.centerYAnchor).isActive = true;
        firstNameBox.rightAnchor.constraint(equalTo: self.view.rightAnchor,constant: -10).isActive = true;
        firstNameBox.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        firstNameBox.isUserInteractionEnabled = false;
        
        //lastName Label
        lastNameLabel = UILabel();
        lastNameLabel.translatesAutoresizingMaskIntoConstraints = false;
        lastNameLabel.textColor = UIColor.black;
        lastNameLabel.font = UIFont(name: "Montserrat-SemiBold", size: 14);
        lastNameLabel.text = "Last Name : ";
        self.view.addSubview(lastNameLabel);
        //need x,y,width,height
        lastNameLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true;
        lastNameLabel.topAnchor.constraint(equalTo: self.firstNameLabel.bottomAnchor, constant: 20).isActive = true;
        lastNameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true;
        lastNameLabel.heightAnchor.constraint(equalToConstant: 30)
        
        //lastName textBox
        lastNameBox = TextFieldPadded();
        lastNameBox.translatesAutoresizingMaskIntoConstraints = false;
        lastNameBox.textColor = UIColor.black;
        lastNameBox.borderStyle = .roundedRect;
        lastNameBox.text = "\(lastName!)";
        lastNameBox.font = UIFont(name: "Montserrat-Regular", size: 14);
        self.view.addSubview(lastNameBox);
        lastNameBox.leftAnchor.constraint(equalTo: self.lastNameLabel.rightAnchor, constant: 5).isActive = true;
        lastNameBox.centerYAnchor.constraint(equalTo: self.lastNameLabel.centerYAnchor).isActive = true;
        lastNameBox.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true;
        lastNameBox.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        lastNameBox.isUserInteractionEnabled = false;
        
        
        messageLabel = UILabel();
        messageLabel.translatesAutoresizingMaskIntoConstraints = false;
        messageLabel.textAlignment = .center;
        messageLabel.text = "To change your name email customer support at: ondeliveryllc@gmail.com";
        messageLabel.textColor = UIColor.black;
        messageLabel.font = UIFont.italicSystemFont(ofSize: 12);
//        messageLabel.minimumScaleFactor = 0.1;
        messageLabel.numberOfLines = 2;
//        messageLabel.adjustsFontSizeToFitWidth = true;
        self.view.addSubview(messageLabel);
        messageLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 15).isActive = true;
        messageLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -15).isActive = true;
        messageLabel.topAnchor.constraint(equalTo: self.lastNameBox.bottomAnchor, constant: 20).isActive = true;
        messageLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true;

        
        
        
    }
}
