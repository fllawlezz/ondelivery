//
//  CreditCardCell.swift
//  YummyV1
//
//  Created by Brandon In on 7/6/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit
import Stripe

class CreditCardCell: UICollectionViewCell{
    //MARK: Elements
    var nickName: UILabel = {
        let nickName = UILabel();
        nickName.translatesAutoresizingMaskIntoConstraints = false;
        nickName.text = "NickName goes here";
        nickName.textColor = UIColor.black;
        nickName.minimumScaleFactor = 0.1;
        nickName.adjustsFontSizeToFitWidth = true;
        nickName.numberOfLines = 1;
        nickName.font = UIFont(name: "Montserrat-SemiBold", size: 14);
        return nickName;
    }()
    
    var last4Numbers: UILabel = {
        let last4Numbers = UILabel();
        last4Numbers.translatesAutoresizingMaskIntoConstraints = false;
        last4Numbers.text = "3421";
        last4Numbers.textColor = UIColor.black;
        last4Numbers.minimumScaleFactor = 0.1;
        last4Numbers.numberOfLines = 1;
        last4Numbers.adjustsFontSizeToFitWidth = true;
        last4Numbers.textColor = UIColor.black;
        last4Numbers.font = UIFont(name: "Montserrat-Regular", size: 14);
        return last4Numbers;
    }()
    var border: UIView = {
        let border = UIView();
        border.translatesAutoresizingMaskIntoConstraints = false;
        border.backgroundColor = UIColor.gray;
        return border;
    }()
    var addButton: UIButton = {
        let addButton = UIButton(type: .system);
        addButton.translatesAutoresizingMaskIntoConstraints = false;
        addButton.setTitle("+", for: .normal);
        addButton.setTitleColor(UIColor.black, for: .normal);
        addButton.backgroundColor = UIColor.appYellow;
        addButton.layer.cornerRadius = 5;
        return addButton;
    }()
    
    var upgradeSubscriptionPage:SubscriptionUpgradePage?
    var subscriptionPlan: String?
    var subscriptionCharge: Double?
    var paymentCard = PaymentCard();
    var selectPaymentPage: SelectPaymentPage?
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        setup();
    }
    
    private func setup(){
        setupNickName();
        setupLast4();
        setupAddButton();
        setupBorder();
        
    }
    
    fileprivate func setupNickName(){
        self.addSubview(nickName);
        //x,y,width,height
        nickName.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 5).isActive = true;
        nickName.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        nickName.widthAnchor.constraint(equalToConstant: 75).isActive = true;
        nickName.heightAnchor.constraint(equalToConstant: 25).isActive = true;
    }
    
    fileprivate func setupLast4(){
        self.addSubview(last4Numbers);
        //x,y,width,height
        last4Numbers.leftAnchor.constraint(equalTo: self.nickName.rightAnchor, constant: 15).isActive = true;
        last4Numbers.centerYAnchor.constraint(equalTo: self.nickName.centerYAnchor).isActive = true;
        last4Numbers.widthAnchor.constraint(equalToConstant: 200).isActive = true;
        last4Numbers.heightAnchor.constraint(equalToConstant: 25).isActive = true;
    }
    
    fileprivate func setupAddButton(){
        self.addSubview(addButton);
        addButton.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -15).isActive = true;
        addButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        addButton.widthAnchor.constraint(equalToConstant: 30).isActive = true;
        addButton.heightAnchor.constraint(equalToConstant: 30).isActive = true;
        addButton.addTarget(self, action: #selector(self.selectCard), for: .touchUpInside);
    }
    
    fileprivate func setupBorder(){
        self.addSubview(border);
        border.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        border.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        border.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        border.heightAnchor.constraint(equalToConstant: 0.5).isActive = true;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    @objc func selectCard(){
        if(upgradeSubscriptionPage != nil){
            upgradeSubscription();
        }else{
            let reviewPage  = self.selectPaymentPage!.reviewPage;
            reviewPage?.paymentCard = self.paymentCard;
            reviewPage?.tableView.handleReloadTable();
            self.selectPaymentPage?.navigationController?.popViewController(animated: true);
        }
    }
    
    func setNickname(name: String!){
        paymentCard.nickName = name;
        self.nickName.text = name;
    }
    
    func setLast4(digits: String!){
        paymentCard.last4 = digits;
        self.last4Numbers.text = digits;
    }
    
    func setCardNum(cardNum: String){
        paymentCard.cardNumber = cardNum;
    }
    
    func setCardExpiration(expiration: String){
        paymentCard.expirationDate = expiration;
    }
    
    func setCvcNumber(cvc: String){
        paymentCard.cvcNumber = cvc;
    }
    
    func hideBorder(){
        self.border.isHidden = true;
    }
    
    func hideButton(){
        self.addButton.isHidden = true;
    }
    
    fileprivate func upgradeSubscription(){
        let alert = UIAlertController(title: "Upgrade", message: "Upgrade to \(self.subscriptionPlan!)? We will charge this card \(self.subscriptionCharge!).", preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (result) in
            //send to server to update and then simeutaenously update subPlan and FreeOrders
            
            //toselect card
//            print(self.subscriptionPlan!);
            switch(self.subscriptionPlan!){
            case "Standard":
                self.upgradeStandard();
                break;
            case "Premium":
                self.upgradePremium();
                break;
            case "Executive":
                self.upgradeExecutive();
                break;
            default: break;
            }
        }))
        alert.addAction(UIAlertAction(title: "No", style: .destructive, handler: { (result) in
            self.selectPaymentPage?.navigationController?.popToRootViewController(animated: true);
        }))
        self.upgradeSubscriptionPage?.present(alert, animated: true, completion: nil);
    }
    
    private func upgradeStandard(){
        //upgrade to standard
        let total = 7.99;
        
        user!.subscriptionPlan = "Standard";
        user!.freeOrders = user!.freeOrders! + 5;
        saveDefaults(defaults: defaults!);
        
        updateSubscriptionServers(total: total);
        alertConfirmation()
    }
    
    private func upgradePremium(){
        let total = 10.99;
        
        user!.subscriptionPlan = "Premium";
        user!.freeOrders = user!.freeOrders! + 10;
        saveDefaults(defaults: defaults!);
        
        updateSubscriptionServers(total: total);
        
        alertConfirmation()
    }
    
    private func upgradeExecutive(){
        let total = 14.99;
        
        user!.subscriptionPlan = "Executive";
        user!.freeOrders = user!.freeOrders! + 15;
        saveDefaults(defaults: defaults!);
        updateSubscriptionServers(total: total);
        alertConfirmation()
    }
    
    private func updateSubscriptionServers(total: Double){
        let cardParams = STPCardParams();
        let expirationString = self.paymentCard.expirationDate?.components(separatedBy: "/");
        let expirationMonth = expirationString![0];
        let expirationYear = expirationString![1];
        cardParams.number = self.paymentCard.cardNumber!
        cardParams.expMonth = UInt((expirationMonth as NSString).integerValue);
        cardParams.expYear = UInt((expirationYear as NSString).integerValue);
        cardParams.cvc = self.paymentCard.cvcNumber;
        
        STPAPIClient.shared().createToken(withCard: cardParams) { (token: STPToken?, error: Error?) in
            guard let token = token, error == nil else {
                // Present error to user...
                return
            }
//            print(token);
            let conn = Conn();
            let postBody = "UserID=\(user!.userID!)&subPlan=\(user!.subscriptionPlan!)&freeOrders=\(user!.freeOrders!)&email=\(user!.email!)&stripeToken=\(token)&total=\(total)"
//            print(postBody);
            conn.connect(fileName: "updateSubscription.php", postString: postBody) { (result) in
            }
        }
        
    }
    
    private func alertConfirmation(){
        let alert = UIAlertController(title: "Finalized!", message: "You have been upgraded to \(user!.subscriptionPlan!) plan. Orders have been added and your card has been charged.", preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Ok!", style: .default, handler: { (result) in
            
            self.upgradeSubscriptionPage?.navigationController?.popToRootViewController(animated: true);
        }))
        self.selectPaymentPage?.present(alert, animated: true, completion: nil);
    }
    
}//collectionview cell 
