//
//  PaymentCell.swift
//  YummyV1
//
//  Created by Brandon In on 8/22/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class PaymentCell: UICollectionViewCell{
    
    lazy var paymentTitleLabel: NormalUILabel = {
        let paymentTitleLabel = NormalUILabel(textColor: .black, font: .montserratSemiBold(fontSize: 14), textAlign: .left);
        return paymentTitleLabel;
    }()
    
    lazy var paymentDetailsLabel: NormalUILabel = {
        let paymentDetails = NormalUILabel(textColor: .darkGray, font: .montserratRegular(fontSize: 12), textAlign: .left);
        return paymentDetails;
    }()
    
    var border: UIView = {
        let border = UIView();
        border.translatesAutoresizingMaskIntoConstraints = false;
        border.backgroundColor = UIColor.gray;
        return border;
    }()
    
//    var paymentTitle: String?
//    var paymentDetails: String?
    
    var nickName: String?;
    var last4: String?;
    var cardNumber: String?;
    var cvc: String?;
    var cardID: String?;
    var expirationDate: String?;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = .white;
        setupPaymentTitle();
        setupPaymentDetails();
        setupBorder();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupPaymentTitle(){
        self.addSubview(paymentTitleLabel);
        paymentTitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true;
        paymentTitleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        paymentTitleLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        paymentTitleLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true;
    }
    
    fileprivate func setupPaymentDetails(){
        self.addSubview(paymentDetailsLabel);
        paymentDetailsLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true;
        paymentDetailsLabel.rightAnchor.constraint(equalTo :self.rightAnchor).isActive = true;
        paymentDetailsLabel.topAnchor.constraint(equalTo: self.paymentTitleLabel.bottomAnchor).isActive = true;
        paymentDetailsLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true;
    }
    
    fileprivate func setupBorder(){
        self.addSubview(border);
        border.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        border.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        border.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        border.heightAnchor.constraint(equalToConstant: 0.3).isActive = true;
    }
    
//    func setData(paymentTitle: String, paymentDetails: String){
//        self.paymentTitle = paymentTitle;
//        self.paymentDetails = paymentDetails;
//        self.paymentTitleLabel.text = paymentTitle;
//        self.paymentDetailsLabel.text = paymentDetails;
//    }
    
    func setData(cardNum: String, expirationDate: String, cvc: String, last4: String, nickName: String, cardID: String){
        self.paymentTitleLabel.text = nickName;
        self.paymentDetailsLabel.text = "...\(last4)";
        
        self.nickName = nickName;
        self.last4 = last4;
        self.cardID = cardID;
        
        self.cardNumber = cardNum;
        self.expirationDate = expirationDate;
        self.cvc = cvc;
    }
    
}
