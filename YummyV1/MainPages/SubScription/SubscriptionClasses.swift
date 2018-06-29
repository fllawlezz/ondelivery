//
//  SubscriptionClasses.swift
//  YummyV1
//
//  Created by Brandon In on 3/18/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import Foundation
import UIKit

extension SubscriptionPage{
    class SubscriptionChargePage: UICollectionViewCell{
        
        var chargeTitle: UILabel!;
        var chargeDescription: UILabel!;
        var chargeButton: UIButton!;
        var subscriptionPlan:Int!;
        let standardText = "With the standard plan comes 4 deliveries of $20 or less. You also get 20% off delivery charges for all orders over $20 and any order after your 4 deliveries are used up."
        let premiumText = "With the premium plan comes 8 deliveries of $20 or less. You also get 30% off delivery charges for all orders over $20 and any order after your 8 deliveries are used up.";
        let executiveText = "With the executive plan comes 15 deliveries of $20 or less. You also get 40% off delivery charges for all orders over $20 and an yorder after your 15 deliveries are used up.";
        
        let standardCharge = 7.99;
        let premiumCharge = 10.99;
        let executiveCharge = 14.99;
        
        var buttonCallback: (()->())?
        
        override init(frame: CGRect) {
            super.init(frame: frame);
            setupView();
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError();
        }
        
        func setupView(){
            chargeDescription = UILabel();
            chargeDescription.translatesAutoresizingMaskIntoConstraints = false;
            chargeDescription.text = "Text Goes here";
            chargeDescription.font = UIFont(name: "Montserrat-Regular", size: 12);
            chargeDescription.textAlignment = .center;
            chargeDescription.textColor = UIColor.black;
            chargeDescription.numberOfLines = 3;
            chargeDescription.adjustsFontSizeToFitWidth = true;
            chargeDescription.minimumScaleFactor = 0.1;
            self.addSubview(chargeDescription);
            chargeDescription.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true;
//            chargeDescription.topAnchor.constraint(equalTo: self.chargeTitle.bottomAnchor, constant: 10).isActive = true;
            chargeDescription.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
            chargeDescription.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true;
            chargeDescription.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true;
            chargeDescription.heightAnchor.constraint(equalToConstant: 60).isActive = true;
            
            chargeTitle = UILabel();
            chargeTitle.translatesAutoresizingMaskIntoConstraints = false;
            chargeTitle.text = "Standard";
            chargeTitle.textAlignment = .center;
            chargeTitle.font = UIFont(name: "Montserrat-SemiBold", size: 18);
            chargeTitle.textColor = UIColor.gray;
            self.addSubview(chargeTitle);
            chargeTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true;
//            chargeTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
            chargeTitle.bottomAnchor.constraint(equalTo: self.chargeDescription.topAnchor, constant: -10).isActive = true;
            chargeTitle.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true;
            chargeTitle.heightAnchor.constraint(equalToConstant: 30).isActive = true;
            
            chargeButton = UIButton(type: .system);
            chargeButton.translatesAutoresizingMaskIntoConstraints = false;
            chargeButton.setTitle("$7.99 / Month", for: .normal);
            chargeButton.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 12);
            chargeButton.backgroundColor = UIColor.appYellow;
            chargeButton.setTitleColor(UIColor.black, for: .normal);
            chargeButton.layer.cornerRadius = 2;
            self.addSubview(chargeButton);
            chargeButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true;
            chargeButton.topAnchor.constraint(equalTo: self.chargeDescription.bottomAnchor, constant: 10).isActive = true;
            chargeButton.widthAnchor.constraint(equalToConstant: 150).isActive = true;
            chargeButton.heightAnchor.constraint(equalToConstant: 40).isActive = true;
            chargeButton.addTarget(self, action: #selector(clickChargeButton), for: .touchUpInside);
        }
        
        func setupText(subscriptionPlan: Int){
            
            self.subscriptionPlan = subscriptionPlan;
            
            switch(subscriptionPlan){
            case 0: setupStandardText();break;
            case 1: setupPremiumText();break;
            case 2: setupExecutiveText();break;
            default: break;
            }
        }
        
        func setupStandardText(){
            chargeTitle.text = "Standard";
            chargeDescription.text = standardText;
            let doubleFormat = String(format: "%.2f",standardCharge);
            chargeButton.setTitle("$\(doubleFormat) / Month", for: .normal);
        }
        
        func setupPremiumText(){
            chargeTitle.text = "Premium";
            chargeDescription.text = premiumText;
            let doubleFormat = String(format: "%.2f", premiumCharge);
            chargeButton.setTitle("$\(doubleFormat) / Month", for: .normal);
        }
        
        func setupExecutiveText(){
            chargeTitle.text = "Executive";
            chargeDescription.text = executiveText;
            let doubleFormat = String(format: "%.2f", executiveCharge);
            chargeButton.setTitle("$\(doubleFormat) / Month", for: .normal);
        }
        
        @objc func clickChargeButton(){
            buttonCallback?()
        }
    }
}
