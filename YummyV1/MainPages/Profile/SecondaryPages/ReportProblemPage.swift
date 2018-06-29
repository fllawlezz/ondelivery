//
//  ReportProblemPage.swift
//  YummyV1
//
//  Created by Brandon In on 1/5/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import Foundation
import UIKit

class ReportProblem: UIViewController, UITextViewDelegate{
    
    //MARK: Elements
    var descriptionLabel: UILabel!;
    var problemField: UITextView!;
    var submitButton: UIButton!;
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white;
        navbarSetup();
        setup();
    }
    
    private func navbarSetup(){
        self.navigationItem.title = "Report a problem";
        let leftBarButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil);
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = leftBarButton;
    }
    
    private func setup(){
        //descriptionLabel
        descriptionLabel = UILabel();
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false;
        descriptionLabel.text = "Describe your problem";
        descriptionLabel.textColor = UIColor.black;
        descriptionLabel.font = UIFont(name: "Montserrat-SemiBold", size: 15);
        descriptionLabel.numberOfLines = 1;
        descriptionLabel.minimumScaleFactor = 0.1;
        descriptionLabel.adjustsFontSizeToFitWidth = true;
        descriptionLabel.textAlignment = .center;
        self.view.addSubview(descriptionLabel);
        //x,y,width,height
        descriptionLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true;
        descriptionLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true;
        descriptionLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive = true;
        descriptionLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true;
        
        //problemField
        problemField = UITextView();
        problemField.translatesAutoresizingMaskIntoConstraints = false;
        problemField.delegate = self;
        problemField.text = "Describe your problem";
        problemField.font = UIFont(name: "Montserrat-Regular", size: 14);
        problemField.textColor = UIColor.lightGray;
        problemField.layer.borderColor = UIColor.black.cgColor;
        problemField.layer.borderWidth = 0.5;
        problemField.layer.cornerRadius = 5;
        self.view.addSubview(problemField);
        //x,y,width,height
        problemField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true;
        problemField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true;
        problemField.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor,constant: 5).isActive = true;
        if(UIScreenHeight > 568){
            problemField.heightAnchor.constraint(equalToConstant: 300).isActive = true;
        }else{
            problemField.heightAnchor.constraint(equalToConstant: 180).isActive = true;
        }
        
        //submit Button
        submitButton = UIButton(type: .system);
        submitButton.translatesAutoresizingMaskIntoConstraints = false;
        submitButton.setTitle("Submit", for: .normal);
        submitButton.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 18);
        submitButton.setTitleColor(UIColor.black, for: .normal);
        submitButton.backgroundColor = UIColor.appYellow;
        self.view.addSubview(submitButton);
        submitButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        submitButton.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        submitButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true;
        submitButton.heightAnchor.constraint(equalToConstant: 60).isActive = true;
        submitButton.addTarget(self, action: #selector(self.submit), for: .touchUpInside);
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        problemField.text = "";
        problemField.textColor = UIColor.black;
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        problemField.resignFirstResponder();
    }
    
    //MARK: Button Funcs
    @objc private func submit(){
        self.navigationController?.popViewController(animated: true);
    }
}
