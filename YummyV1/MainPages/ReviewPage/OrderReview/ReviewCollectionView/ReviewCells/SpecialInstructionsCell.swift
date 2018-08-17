//
//  SpecialInstructionsCell.swift
//  YummyV1
//
//  Created by Brandon In on 8/16/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class SpecialInstructionsCell: UICollectionViewCell{
    
    var specialInstructionsLabel: NormalUILabel = {
        let specialInstructionsLabel = NormalUILabel(textColor: .black, font: .montserratSemiBold(fontSize: 16), textAlign: .center);
        return specialInstructionsLabel;
        
    }()
    
    var instructionsField: UITextView = {
        let instructionsField = UITextView();
        instructionsField.translatesAutoresizingMaskIntoConstraints = false;
        instructionsField.font = .systemFont(ofSize: 14);
        instructionsField.textColor = UIColor.black;
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
        instructionsField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 10).isActive = true;
        instructionsField.topAnchor.constraint(equalTo: self.specialInstructionsLabel.bottomAnchor, constant: 10).isActive = true;
        instructionsField.heightAnchor.constraint(equalToConstant: 25).isActive = true;
    }
    
}
