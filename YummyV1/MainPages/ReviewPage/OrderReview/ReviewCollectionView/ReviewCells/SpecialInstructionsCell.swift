//
//  SpecialInstructionsCell.swift
//  YummyV1
//
//  Created by Brandon In on 8/16/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

let specialInstructionsKeyboardUp = "specialInstructionsKeyboardUp";
let specialInstructionsKeyboardDown = "specialInstructionsKeyboardDown";

class SpecialInstructionsCell: UICollectionViewCell, UITextViewDelegate{
    
    var specialInstructionsLabel: NormalUILabel = {
        let specialInstructionsLabel = NormalUILabel(textColor: .black, font: .montserratSemiBold(fontSize: 16), textAlign: .center);
        specialInstructionsLabel.text = "Special Instructions";
        return specialInstructionsLabel;
        
    }()
    
    var instructionsField: UITextView = {
        let instructionsField = UITextView();
        instructionsField.translatesAutoresizingMaskIntoConstraints = false;
        instructionsField.font = .systemFont(ofSize: 14);
        instructionsField.textColor = UIColor.lightGray;
        instructionsField.layer.borderColor = UIColor.lightGray.cgColor;
        instructionsField.layer.borderWidth = 1;
        instructionsField.text = "Special Instructions";
        instructionsField.returnKeyType = .done;
        return instructionsField;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = .white;
        setupInstructionsLabel();
        setupInstructionsField();
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupInstructionsLabel(){
        self.addSubview(specialInstructionsLabel);
        specialInstructionsLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        specialInstructionsLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        specialInstructionsLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        specialInstructionsLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true;
    }
    
    fileprivate func setupInstructionsField(){
        self.addSubview(instructionsField);
        instructionsField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true;
        instructionsField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true;
        instructionsField.topAnchor.constraint(equalTo: self.specialInstructionsLabel.bottomAnchor, constant: 10).isActive = true;
        instructionsField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true;
        instructionsField.delegate = self;
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            self.instructionsField.resignFirstResponder();
            let keyboardDown = Notification.Name(rawValue: specialInstructionsKeyboardDown);
            NotificationCenter.default.post(name: keyboardDown, object: nil);
            return false
        }
        return true
    }
    // hides text fields
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (string == "\n") {
            self.instructionsField.resignFirstResponder();
            let keyboardDown = Notification.Name(rawValue: specialInstructionsKeyboardDown);
            NotificationCenter.default.post(name: keyboardDown, object: nil);
            return false
        }
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if(textView.text == "Special Instructions"){
            self.instructionsField.textColor = UIColor.black;
            self.instructionsField.text = "";
        }
        
        let name = Notification.Name(rawValue: specialInstructionsKeyboardUp);
        NotificationCenter.default.post(name: name, object: nil);
    }
}
