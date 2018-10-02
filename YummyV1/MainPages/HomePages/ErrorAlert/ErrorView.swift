//
//  ErrorView.swift
//  YummyV1
//
//  Created by Brandon In on 9/4/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

protocol ErrorViewDelegate{
    func handleOkPressed();
}

class ErrorView: UIView{
    
    var delegate: ErrorViewDelegate?;
    
    lazy var titleLabel: NormalUILabel = {
        let titleLabel = NormalUILabel(textColor: .black, font: .montserratBold(fontSize: 14), textAlign: .center);
        titleLabel.backgroundColor = UIColor.appYellow;
        titleLabel.text = "Woops! :(";
        return titleLabel;
    }()
    
    lazy var messageLabel: NormalUILabel = {
        let messageLabel = NormalUILabel(textColor: .black, font: .montserratSemiBold(fontSize: 12), textAlign: .center);
        messageLabel.text = "There was a problem connecting!!! Please try again later...";
        messageLabel.numberOfLines = 0;
        return messageLabel;
    }()
    
    lazy var okButton: NormalUIButton = {
        let okButton = NormalUIButton(backgroundColor: .appYellow, title: "Ok", font: .montserratSemiBold(fontSize: 14), fontColor: .black);
        okButton.layer.cornerRadius = 0;
        return okButton;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.backgroundColor = UIColor.veryLightGray;
        self.layer.cornerRadius = 5;
        self.clipsToBounds = true;
        setupTitleLabel();
        setupMessageLabel();
        setupOkButton();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupTitleLabel(){
        self.addSubview(titleLabel);
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        titleLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true;
    }
    
    fileprivate func setupMessageLabel(){
        self.addSubview(messageLabel);
        messageLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true;
        messageLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true;
        messageLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10).isActive = true;
        messageLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true;
    }
    
    fileprivate func setupOkButton(){
        self.addSubview(okButton);
        okButton.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        okButton.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        okButton.heightAnchor.constraint(equalToConstant: 40).isActive = true;
        okButton.topAnchor.constraint(equalTo: self.messageLabel.bottomAnchor, constant: 10).isActive = true;
        okButton.addTarget(self, action: #selector(handleOkPress), for: .touchUpInside);
    }
    
}

extension ErrorView{
    @objc func handleOkPress(){
        self.delegate?.handleOkPressed();
    }
}
