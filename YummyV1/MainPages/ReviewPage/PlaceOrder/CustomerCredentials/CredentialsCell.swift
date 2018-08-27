//
//  CredentialsCell.swift
//  YummyV1
//
//  Created by Brandon In on 8/22/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

protocol CredentialsCellDelegate{
    func handleNextField(cellIndex: Int);
}

class CredentialsCell: UICollectionViewCell, UITextFieldDelegate{
    
    var cellIndex: Int?
    var credentialsCellDelegate: CredentialsCellDelegate?;
    
    lazy var credentialsTitleLabel: NormalUILabel = {
        let credentialsTitleLabel = NormalUILabel(textColor: .black, font: .montserratSemiBold(fontSize: 14), textAlign: .left);
        return credentialsTitleLabel;
    }()
    
    lazy var credentialsTextField: TextFieldPadded = {
        let credentialsTextField = TextFieldPadded();
        credentialsTextField.font = UIFont.systemFont(ofSize: 14);
        credentialsTextField.textAlignment = .left;
        credentialsTextField.textColor = UIColor.black;
        credentialsTextField.translatesAutoresizingMaskIntoConstraints = false;
        credentialsTextField.backgroundColor = UIColor.white;
        return credentialsTextField;
    }()
    
    var border:UIView = {
        let border = UIView();
        border.translatesAutoresizingMaskIntoConstraints = false;
        border.backgroundColor = UIColor.gray;
        return border;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        setupCredentialsTitleLabel();
        setupCredentialsTextField();
        setupBorder();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupCredentialsTitleLabel(){
        self.addSubview(credentialsTitleLabel);
        credentialsTitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true;
        credentialsTitleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        credentialsTitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        credentialsTitleLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true;
//        credentialsTitleLabel.backgroundColor = UIColor.red;
    }
    
    fileprivate func setupCredentialsTextField(){
        self.addSubview(credentialsTextField);
        credentialsTextField.leftAnchor.constraint(equalTo: self.credentialsTitleLabel.rightAnchor, constant: 5).isActive = true;
        credentialsTextField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true;
        credentialsTextField.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        credentialsTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        credentialsTextField.delegate = self;
    }
    
    fileprivate func setupBorder(){
        self.addSubview(border);
        border.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        border.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        border.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        border.heightAnchor.constraint(equalToConstant: 0.3).isActive = true;
    }
    
    func setupData(credentialsTitle: String, credentialsPlaceHolder: String){
        self.credentialsTitleLabel.text = "\(credentialsTitle):";
        self.credentialsTextField.placeholder = credentialsPlaceHolder;
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let cellIndex = self.cellIndex{
            credentialsCellDelegate?.handleNextField(cellIndex: cellIndex);
        }
        return true;
    }
}
