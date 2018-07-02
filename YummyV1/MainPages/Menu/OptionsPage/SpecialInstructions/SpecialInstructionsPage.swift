//
//  SpecialInstructionsPage.swift
//  YummyV1
//
//  Created by Brandon In on 7/2/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class SpecialInstructionsPage: UIViewController, UITextViewDelegate{
    
    var specialOptionsPage: SpecialOptionsPage?
    
    var specialInstructionsField: UITextView = {
        let specialInstructionsField = UITextView();
        specialInstructionsField.translatesAutoresizingMaskIntoConstraints = false;
        specialInstructionsField.text = "Special Request?";
        specialInstructionsField.textColor = UIColor.gray;
        specialInstructionsField.font = UIFont.montserratRegular(fontSize: 12);
        specialInstructionsField.textAlignment = .left;
        specialInstructionsField.layer.borderWidth = 0.5
        specialInstructionsField.layer.borderColor = UIColor.gray.cgColor;
        specialInstructionsField.layer.cornerRadius = 4;
        specialInstructionsField.returnKeyType = .done;
        return specialInstructionsField;
    }()
    
    var titleDescription: NormalUILabel = {
        let titleDescription = NormalUILabel(textColor: UIColor.black, font: UIFont.montserratBold(fontSize: 18), textAlign: .center);
        return titleDescription;
    }()
    
    var addButton: NormalUIButton = {
        let addButton = NormalUIButton(backgroundColor: UIColor.appYellow, title: "Add Instructions", font: UIFont.montserratSemiBold(fontSize: 16), fontColor: UIColor.black);
        return addButton;
    }()
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white;
        setupTitle();
        setupTextView();
        setupAddButton();
    }
    
    fileprivate func setupTitle(){
        self.view.addSubview(titleDescription);
        titleDescription.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true;
        titleDescription.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true;
        titleDescription.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10).isActive = true;
        titleDescription.heightAnchor.constraint(equalToConstant: 35).isActive = true;
        
        titleDescription.text = "Special Instructions"
    }
    
    fileprivate func setupTextView(){
        self.view.addSubview(specialInstructionsField);
        specialInstructionsField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true;
        specialInstructionsField.rightAnchor.constraint(equalTo: self.view.rightAnchor,constant: -10).isActive = true;
        specialInstructionsField.topAnchor.constraint(equalTo: self.titleDescription.bottomAnchor, constant: 10).isActive = true;
        specialInstructionsField.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -70).isActive = true;
        
        specialInstructionsField.delegate = self;
        specialInstructionsField.text = "Special Instructions...";
        specialInstructionsField.textColor = UIColor.gray;
    }
    
    fileprivate func setupAddButton(){
        self.view.addSubview(addButton);
        addButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true;
        addButton.rightAnchor.constraint(equalTo: self.view.rightAnchor,constant: -10).isActive = true;
        addButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -10).isActive = true;
        addButton.heightAnchor.constraint(equalToConstant: 50).isActive = true;
        addButton.addTarget(self, action: #selector(self.handleAddInstruction), for: .touchUpInside);
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        specialInstructionsField.text = "";
        specialInstructionsField.textColor = UIColor.black;
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n"){
            self.specialInstructionsField.resignFirstResponder();
            return false;
        }
        
        return true;
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.specialInstructionsField.resignFirstResponder();
    }
    
    @objc func handleAddInstruction(){
        let instructions = self.specialInstructionsField.text;
        if(instructions!.count > 0 && instructions != "Special Instructions..."){
            self.specialOptionsPage?.specialOrderField.text = instructions!;
            self.navigationController?.popViewController(animated: true);
        }
    }
    
    
}
