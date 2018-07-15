//
//  SubscriptionCell.swift
//  YummyV1
//
//  Created by Brandon In on 7/14/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class SubscriptionCell: UICollectionViewCell{
    
    var subscriptionCollectionView: SubscriptionCollectionView?
    var subscriptionUpgradePage: SubscriptionUpgradePage?
    
    var subscriptionTitle:NormalUILabel = {
        let subscriptionTitle = NormalUILabel(textColor: UIColor.black, font: UIFont.montserratSemiBold(fontSize: 18), textAlign: .center);
        return subscriptionTitle;
    }()
    
    var subscriptionDescription: NormalUILabel = {
        let subscriptionDescription = NormalUILabel(textColor: UIColor.black, font: UIFont.montserratRegular(fontSize: 14), textAlign: .center);
        subscriptionDescription.numberOfLines = 4;
        return subscriptionDescription;
    }()
    
    var upgradeButton:NormalUIButton = {
        let upgradeButton = NormalUIButton(backgroundColor: UIColor.appYellow, title: "button", font: UIFont.montserratSemiBold(fontSize: 16), fontColor: UIColor.black);
        return upgradeButton;
    }()
    
    var subTitle:String?
    var subDescription: String?
    var upgradeTitle: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        setup();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    func setup(){
        self.addSubview(subscriptionTitle);
        self.addSubview(subscriptionDescription);
        self.addSubview(upgradeButton);
        
        subscriptionDescription.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        subscriptionDescription.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true;
        subscriptionDescription.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true;
        subscriptionDescription.heightAnchor.constraint(equalToConstant: 50).isActive = true;
        
        subscriptionTitle.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        subscriptionTitle.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        subscriptionTitle.bottomAnchor.constraint(equalTo: self.subscriptionDescription.topAnchor, constant: -10).isActive = true;
        subscriptionTitle.heightAnchor.constraint(equalToConstant: 30).isActive = true;
        
        upgradeButton.topAnchor.constraint(equalTo: self.subscriptionDescription.bottomAnchor, constant: 10).isActive = true;
        upgradeButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 40).isActive = true;
        upgradeButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -40).isActive = true;
        upgradeButton.heightAnchor.constraint(equalToConstant: 40).isActive = true;
        upgradeButton.addTarget(self, action: #selector(self.handleUpgrade), for: .touchUpInside);
    }
    
    func setButtonTitle(buttonTitle: String){
        
        if(buttonTitle != user!.subscriptionPlan!){
            self.upgradeTitle = buttonTitle;
            self.upgradeButton.setTitle(buttonTitle, for: .normal);
        }else{
            self.upgradeTitle = "Current";
            self.upgradeButton.setTitle("Current", for: .normal);
        }
    }
    
    func setSubDescription(description: String){
        self.subDescription = description;
        self.subscriptionDescription.text = description;
    }
    
    func setTitle(title: String){
        self.subTitle = title;
        self.subscriptionTitle.text = title;
    }
    
    @objc func handleUpgrade(){
        print(subTitle!);
        print(user!.subscriptionPlan!);
        
            //to select your card
        let subscriptionPlan: String = subTitle!;
        let subscriptionCharge: Double = Double(self.upgradeTitle!)!;
        if(subscriptionPlan != user!.subscriptionPlan! && self.upgradeTitle != "Current"){
            let selectPayment = SelectPaymentPage();
            selectPayment.upgradeSubscriptionPage = self.subscriptionUpgradePage;
            selectPayment.subscriptionPlan = subscriptionPlan;
            selectPayment.subscriptionCharge = subscriptionCharge;
            self.subscriptionUpgradePage?.navigationController?.pushViewController(selectPayment, animated: true);
        }
        
    }
    
}
