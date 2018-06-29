//
//  InfoCell.swift
//  YummyV1
//
//  Created by Brandon In on 4/11/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class ProfileLoginSignUpCell: UIView{
    
    var ProfileLogin: ProfileLogin?{
        didSet{
            
        }
    }
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel();
        titleLabel.translatesAutoresizingMaskIntoConstraints = false;
        titleLabel.text = "Text Goes here";
        titleLabel.font = UIFont(name: "Montserrat-SemiBold", size: 14);
        titleLabel.textColor = UIColor.black;
        titleLabel.textAlignment = .left;
        titleLabel.adjustsFontSizeToFitWidth = true;
        titleLabel.numberOfLines = 1;
        titleLabel.minimumScaleFactor = 0.1;
        return titleLabel;
    }();
    
    lazy var textField: TextFieldPadded = {
        let textField = TextFieldPadded();
        textField.translatesAutoresizingMaskIntoConstraints = false;
        textField.font = UIFont(name: "Montserrat-Regular", size: 14);
        textField.spellCheckingType = .no
        textField.autocorrectionType = .no;
        textField.textColor = UIColor.black;
        textField.textAlignment = .left;
        textField.backgroundColor = UIColor.white;
        textField.returnKeyType = .next;
        return textField;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        setup();
    }
    
    func setup(){
        self.addSubview(titleLabel);
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true;
        titleLabel.widthAnchor.constraint(equalToConstant: 75).isActive = true;
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        
        self.addSubview(textField);
        textField.leftAnchor.constraint(equalTo: titleLabel.rightAnchor).isActive = true;
        textField.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        textField.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        textField.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    func setTitle(titleString: String!){
        self.titleLabel.text = titleString;
    }
    
}
