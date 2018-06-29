//
//  SubscriptionUpgradePage.swift
//  YummyV1
//
/*
 Present user with the three options: standard, premium, executive
 When user presses to upgrade to one of the three, then the difference between the last subscription is added to freeOrders
 */
//  Created by Brandon In on 3/30/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit
import Stripe

class SubscriptionUpgradePage: UIViewController{
    
    var subscriptionPlan: String?;
    let standardText = "With the standard plan comes 4 deliveries of $20 or less. You also get 20% off delivery charges for all orders over $20 and any order after your 4 deliveries are used up."
    let premiumText = "With the premium plan comes 8 deliveries of $20 or less. You also get 30% off delivery charges for all orders over $20 and any order after your 8 deliveries are used up.";
    let executiveText = "With the executive plan comes 15 deliveries of $20 or less. You also get 40% off delivery charges for all orders over $20 and an yorder after your 15 deliveries are used up.";
    
    lazy var standardView: UIView = {
        let standardView = UIView();
        standardView.translatesAutoresizingMaskIntoConstraints = false;
        standardView.backgroundColor = UIColor.white;
        return standardView;
    }()
    
    lazy var standardLabel: UILabel = {
        let standardLabel = UILabel();
        standardLabel.translatesAutoresizingMaskIntoConstraints = false;
        standardLabel.font = UIFont(name: "Montserrat-SemiBold", size: 16);
        standardLabel.text = "Standard Plan";
        standardLabel.textAlignment = .center;
        standardLabel.textColor = UIColor.black;
        standardLabel.adjustsFontSizeToFitWidth = true;
        standardLabel.numberOfLines = 1;
        standardLabel.minimumScaleFactor = 0.1;
        return standardLabel;
    }()
    
    lazy var standardButton: UIButton = {
        let standardButton = UIButton(type: .system);
        standardButton.translatesAutoresizingMaskIntoConstraints = false;
        standardButton.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 12);
        standardButton.setTitle("$7.99 / Month", for: .normal);
        standardButton.setTitleColor(UIColor.black, for: .normal);
        standardButton.backgroundColor = UIColor.appYellow;
        standardButton.layer.cornerRadius = 3;
        return standardButton;
    }()
    
    lazy var premiumView: UIView = {
        let premiumView = UIView();
        premiumView.translatesAutoresizingMaskIntoConstraints = false;
        premiumView.backgroundColor = UIColor.white;
        return premiumView;
    }()
    
    lazy var premiumLabel: UILabel = {
        let premiumLabel = UILabel();
        premiumLabel.translatesAutoresizingMaskIntoConstraints = false;
        premiumLabel.font = UIFont(name: "Montserrat-SemiBold", size: 16);
        premiumLabel.text = "Premium Plan";
        premiumLabel.textColor = UIColor.black;
        premiumLabel.textAlignment = .center;
        premiumLabel.adjustsFontSizeToFitWidth = true;
        premiumLabel.numberOfLines = 1;
        premiumLabel.minimumScaleFactor = 0.1;
        return premiumLabel;
    }()
    
    lazy var premiumButton: UIButton = {
        let premiumButton = UIButton(type: .system);
        premiumButton.translatesAutoresizingMaskIntoConstraints = false;
        premiumButton.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 12);
        premiumButton.setTitle("$10.99 / Month", for: .normal);
        premiumButton.setTitleColor(UIColor.black, for: .normal);
        premiumButton.backgroundColor = UIColor.appYellow;
        premiumButton.layer.cornerRadius = 3;
        return premiumButton;
    }();
    
    lazy var executiveView: UIView = {
        let executiveView = UIView();
        executiveView.translatesAutoresizingMaskIntoConstraints = false;
        executiveView.backgroundColor = UIColor.white;
        return executiveView;
    }()
    
    lazy var executiveLabel: UILabel = {
        let executiveLabel = UILabel();
        executiveLabel.translatesAutoresizingMaskIntoConstraints = false;
        executiveLabel.font = UIFont(name: "Montserrat-SemiBold", size: 16);
        executiveLabel.text = "Executive Plan";
        executiveLabel.textAlignment = .center;
        executiveLabel.textColor = UIColor.black;
        executiveLabel.adjustsFontSizeToFitWidth = true;
        executiveLabel.numberOfLines = 1;
        executiveLabel.minimumScaleFactor = 0.1;
        return executiveLabel;
    }()
    
    lazy var executiveButton: UIButton = {
        let executiveButton = UIButton(type: .system);
        executiveButton.translatesAutoresizingMaskIntoConstraints = false;
        executiveButton.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 12);
        executiveButton.setTitle("$14.99 / Month", for: .normal);
        executiveButton.setTitleColor(UIColor.black, for: .normal);
        executiveButton.backgroundColor = UIColor.appYellow;
        executiveButton.layer.cornerRadius = 3;
        return executiveButton;
    }();
    
    
    override func viewDidLoad() {
        self.title = "Upgrade";
        
        let leftBarButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil);
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = leftBarButton;
        
        self.view.backgroundColor = UIColor.white;
        addStandardView();
        addPremiumView();
        addExecutiveView();
        setButtonText();
        
    }
    
    func setButtonText(){
        switch(subscriptionPlan!){
        case "Standard":
            standardButton.setTitle("Current", for: .normal);
            break;
        case "Premium":
            premiumButton.setTitle("Current", for: .normal);
            break;
        case "Executive":
            executiveButton.setTitle("Current", for: .normal);
            break;
            
        default:break;
        }
    }
    
    func addStandardView(){
        self.view.addSubview(standardView);
        standardView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        standardView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        standardView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive = true;
        standardView.heightAnchor.constraint(equalToConstant: 80).isActive = true;
        
        self.standardView.addSubview(standardLabel);
        standardLabel.leftAnchor.constraint(equalTo: self.standardView.leftAnchor).isActive = true;
        standardLabel.centerYAnchor.constraint(equalTo: self.standardView.centerYAnchor).isActive = true;
        standardLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width/2).isActive = true;
        standardLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true;
        
        self.standardView.addSubview(standardButton);
        self.standardButton.rightAnchor.constraint(equalTo: self.standardView.rightAnchor, constant: -25).isActive = true;
        self.standardButton.centerYAnchor.constraint(equalTo: self.standardView.centerYAnchor).isActive = true;
        self.standardButton.widthAnchor.constraint(equalToConstant: 100).isActive = true;
        self.standardButton.heightAnchor.constraint(equalToConstant: 40).isActive = true;
        standardButton.addTarget(self, action: #selector(selectUpgrade), for: .touchUpInside);
        
        let standardDescription = UILabel();
        standardDescription.translatesAutoresizingMaskIntoConstraints = false;
        standardDescription.font = UIFont(name: "Montserrat-Regular", size: 10);
        standardDescription.text = standardText;
        standardDescription.textColor = UIColor.gray;
        standardDescription.adjustsFontSizeToFitWidth = true;
        standardDescription.numberOfLines = 3;
        standardDescription.minimumScaleFactor = 0.1;
        self.standardView.addSubview(standardDescription);
        standardDescription.leftAnchor.constraint(equalTo: self.standardView.leftAnchor, constant: 20).isActive = true;
        standardDescription.rightAnchor.constraint(equalTo: self.standardButton.leftAnchor).isActive = true;
        standardDescription.topAnchor.constraint(equalTo: self.standardLabel.bottomAnchor).isActive = true;
        standardDescription.heightAnchor.constraint(equalToConstant: 30).isActive = true;
    }
    
    func addPremiumView(){
        self.view.addSubview(premiumView);
        premiumView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        premiumView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        premiumView.topAnchor.constraint(equalTo: self.standardView.bottomAnchor, constant: 20).isActive = true;
        premiumView.heightAnchor.constraint(equalToConstant: 80).isActive = true;
        
        self.premiumView.addSubview(premiumLabel);
        premiumLabel.leftAnchor.constraint(equalTo: self.premiumView.leftAnchor).isActive = true;
        premiumLabel.centerYAnchor.constraint(equalTo: self.premiumView.centerYAnchor).isActive = true;
        premiumLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width/2).isActive = true;
        premiumLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true;
        
        self.premiumView.addSubview(premiumButton);
        self.premiumButton.rightAnchor.constraint(equalTo: self.premiumView.rightAnchor, constant: -25).isActive = true;
        self.premiumButton.centerYAnchor.constraint(equalTo: self.premiumView.centerYAnchor).isActive = true;
        self.premiumButton.widthAnchor.constraint(equalToConstant: 100).isActive = true;
        self.premiumButton.heightAnchor.constraint(equalToConstant: 40).isActive = true;
        
        premiumButton.addTarget(self, action: #selector(selectUpgrade), for: .touchUpInside);
        
        let premiumDescription = UILabel();
        premiumDescription.translatesAutoresizingMaskIntoConstraints = false;
        premiumDescription.font = UIFont(name: "Montserrat-Regular", size: 10);
        premiumDescription.text = premiumText;
        premiumDescription.textColor = UIColor.gray;
        premiumDescription.adjustsFontSizeToFitWidth = true;
        premiumDescription.numberOfLines = 3;
        premiumDescription.minimumScaleFactor = 0.1;
        self.premiumView.addSubview(premiumDescription);
        premiumDescription.leftAnchor.constraint(equalTo: self.premiumView.leftAnchor, constant: 20).isActive = true;
        premiumDescription.rightAnchor.constraint(equalTo: self.premiumButton.leftAnchor).isActive = true;
        premiumDescription.topAnchor.constraint(equalTo: self.premiumLabel.bottomAnchor).isActive = true;
        premiumDescription.heightAnchor.constraint(equalToConstant: 30).isActive = true;
        
    }
    
    func addExecutiveView(){
        self.view.addSubview(executiveView);
        executiveView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        executiveView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        executiveView.topAnchor.constraint(equalTo: self.premiumView.bottomAnchor, constant: 20).isActive = true;
        executiveView.heightAnchor.constraint(equalToConstant: 80).isActive = true;
        
        self.executiveView.addSubview(executiveLabel);
        executiveLabel.leftAnchor.constraint(equalTo: self.executiveView.leftAnchor).isActive = true;
        executiveLabel.centerYAnchor.constraint(equalTo: self.executiveView.centerYAnchor).isActive = true;
        executiveLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width/2).isActive = true;
        executiveLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true;
        
        self.executiveView.addSubview(executiveButton);
        self.executiveButton.rightAnchor.constraint(equalTo: self.executiveView.rightAnchor, constant: -25).isActive = true;
        self.executiveButton.centerYAnchor.constraint(equalTo: self.executiveView.centerYAnchor).isActive = true;
        self.executiveButton.widthAnchor.constraint(equalToConstant: 100).isActive = true;
        self.executiveButton.heightAnchor.constraint(equalToConstant: 40).isActive = true;
        
        executiveButton.addTarget(self, action: #selector(selectUpgrade), for: .touchUpInside);
        
        let executiveDescription = UILabel();
        executiveDescription.translatesAutoresizingMaskIntoConstraints = false;
        executiveDescription.font = UIFont(name: "Montserrat-Regular", size: 10);
        executiveDescription.text = executiveText;
        executiveDescription.textColor = UIColor.gray;
        executiveDescription.adjustsFontSizeToFitWidth = true;
        executiveDescription.numberOfLines = 3;
        executiveDescription.minimumScaleFactor = 0.1;
        self.executiveView.addSubview(executiveDescription);
        executiveDescription.leftAnchor.constraint(equalTo: self.executiveView.leftAnchor, constant: 20).isActive = true;
        executiveDescription.rightAnchor.constraint(equalTo: self.executiveButton.leftAnchor).isActive = true;
        executiveDescription.topAnchor.constraint(equalTo: self.executiveLabel.bottomAnchor).isActive = true;
        executiveDescription.heightAnchor.constraint(equalToConstant: 30).isActive = true;
    }
    
//    @objc func selectUpgrade(sender: Any){
//        let button = sender as! UIButton;
//        if( button.titleLabel!.text != "Current"){
//            let alert = UIAlertController(title: "Upgrade", message: "", preferredStyle: .alert);
//            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (result) in
//                //send to server to update and then simeutaenously update subPlan and FreeOrders
//
//                //toselect card
//
//                switch(button.titleLabel!.text!){
//                case "$7.99 / Month":
//                    self.upgradeStandard();
//                    break;
//                case "$10.99 / Month":
//                    self.upgradePremium();
//                    break;
//                case "$14.99 / Month":
//                    self.upgradeExecutive();
//                    break;
//                default: break;
//                }
//            }))
//            alert.addAction(UIAlertAction(title: "No", style: .destructive, handler: { (result) in
//
//            }))
//            self.present(alert, animated: true, completion: nil);
//        }
//    }
    
    @objc func selectUpgrade(sender: Any){
        //to select your card
        let button = sender as! UIButton;
        var subscriptionPlan: String!;
        var subscriptionCharge: Double!;
        switch(button.titleLabel!.text!){
        case "$7.99 / Month":
            subscriptionPlan = "Standard";
            subscriptionCharge = 7.99;
            break;
        case "$10.99 / Month":
            subscriptionPlan = "Premium";
            subscriptionCharge = 10.99;
            break;
        case "$14.99 / Month":
            subscriptionPlan = "Executive";
            subscriptionCharge = 14.99;
            break;
        default: break;
        }
        
        if(button.titleLabel?.text != "Current"){
            let selectPayment = SelectPaymentPage();
            selectPayment.fromUpgradeSubscriptionpage = true;
            selectPayment.subscriptionPlan = subscriptionPlan;
            selectPayment.subscriptionCharge = subscriptionCharge;
            self.navigationController?.pushViewController(selectPayment, animated: true);
        }
        
    }
    
//    private func upgradeStandard(){
//        //upgrade to standard
//        let total = 7.99;
//
//        subPlan = "Standard";
//        freeOrders = freeOrders + 5;
//        updateSubscriptionServers(total: total);
//
//    }
//
//    private func upgradePremium(){
//        let total = 10.99;
//        updateSubscriptionServers(total: total);
//
//        subPlan = "Premium";
//        freeOrders = freeOrders + 10;
//    }
//
//    private func upgradeExecutive(){
//        let total = 14.99;
//        updateSubscriptionServers(total: total);
//
//        subPlan = "Executive";
//        freeOrders = freeOrders + 15;
//    }
//
//    private func updateSubscriptionServers(total: Double){
//        let cardParams = STPCardParams();
//        cardParams.number = paymentFullCard!;
//        cardParams.expMonth = UInt((cardExpMonth! as NSString).integerValue);
//        cardParams.expYear = UInt((cardExpYear! as NSString).integerValue);
//        cardParams.cvc = cardCvc!;
//
//        STPAPIClient.shared().createToken(withCard: cardParams) { (token: STPToken?, error: Error?) in
//            guard let token = token, error == nil else {
//                // Present error to user...
//                return
//            }
//            let conn = Conn();
//            let postBody = "UserID=\(userID!)&subPlan=\(subPlan!)&freeOrders=\(freeOrders!)&email=\(email!)&stripeToken=\(token)&total=\(total)"
//            conn.connect(fileName: "updateSubscription.php", postString: postBody) { (result) in
//            }
//        }
//
//    }
}
