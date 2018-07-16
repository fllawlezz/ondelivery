//
//  TelephonePage.swift
//  YummyV1
//
//  Created by Brandon In on 1/5/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import Foundation
import UIKit

class TelephonePage: UIViewController{
    
    var telephoneLabel: UILabel!;
    var telephoneField: TextFieldPadded!;
    var messageLabel: UILabel!;
    
    override func viewDidLoad() {
        let button = UIBarButtonItem(title: "", style: .plain, target: self, action: nil);
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = button;
        self.navigationItem.title = "Your Number";
        
        setup();
    }
    
    func setup(){
        self.view.backgroundColor = UIColor.white;
        
        telephoneLabel = UILabel();
        telephoneLabel.translatesAutoresizingMaskIntoConstraints = false;
        telephoneLabel.text = "Telephone #: ";
        telephoneLabel.textColor = UIColor.black;
        telephoneLabel.font = UIFont(name: "Montserrat-Regular", size: 16);
        self.view.addSubview(telephoneLabel);
        //need x,y, width, height
        telephoneLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true;
        telephoneLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive = true;
        telephoneLabel.widthAnchor.constraint(equalToConstant: 125).isActive = true;
        telephoneLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true;
        
        telephoneField = TextFieldPadded();
        telephoneField.translatesAutoresizingMaskIntoConstraints = false;
        telephoneField.placeholder = "\(user!.telephone!)";
        telephoneField.textColor = UIColor.black;
        telephoneField.borderStyle = .roundedRect;
        telephoneField.textAlignment = .center;
        telephoneField.isUserInteractionEnabled = false;
        telephoneField.font = UIFont(name: "Montserrat-Regular", size: 14);
        self.view.addSubview(telephoneField);
        //need x,ywidth,height
        telephoneField.leftAnchor.constraint(equalTo: self.view.leftAnchor,constant: 5).isActive = true;
        telephoneField.topAnchor.constraint(equalTo: self.telephoneLabel.bottomAnchor, constant: 10).isActive = true;
        telephoneField.rightAnchor.constraint(equalTo: self.view.rightAnchor,constant: -5).isActive = true;
        telephoneField.heightAnchor.constraint(equalToConstant: 30).isActive = true;
        
        messageLabel = UILabel();
        messageLabel.translatesAutoresizingMaskIntoConstraints = false;
        messageLabel.text = "If you want to change your # contact customer support";
        messageLabel.font = UIFont(name: "Montserrat-Regular", size: 10);
        messageLabel.textColor = UIColor.black;
        messageLabel.textAlignment = .center;
        messageLabel.numberOfLines = 2;
//        messageLabel.adjustsFontSizeToFitWidth = true;
//        messageLabel.minimumScaleFactor = 0.1;
        self.view.addSubview(messageLabel);
        //need x,y,width,height
        messageLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true;
        messageLabel.topAnchor.constraint(equalTo: self.telephoneField.bottomAnchor,constant: 5).isActive = true;
        messageLabel.widthAnchor.constraint(equalToConstant: self.view.frame.size.width-20).isActive = true;
        messageLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true;
        
    }
}
