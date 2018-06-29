//
//  SelectPayment.swift
//  YummyV1
//
//  Created by Brandon In on 12/24/17.
//  Copyright © 2017 Rendered Co.RaftPod. All rights reserved.
//

import Foundation
import UIKit
import Stripe


class SelectPaymentPage: UIViewController,UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource{
    
    var fromProfilePage = false;
    var fromUpgradeSubscriptionpage = false;
    var subscriptionPlan: String?;
    var subscriptionCharge: Double?;
    
    var subPlan: String?
    var freeOrders: Int?
    var userID: String?
    var email: String?
    
    //DATA Elements
    var cards: [PaymentCard]?
    var selectedCard: PaymentCard?
    
    //MARK: Elements
    var creditCardTable: UICollectionView!
    var addNewCardButton: UIButton!;
    var nickNames = ["first","second","third","fourth","fifth"];
    var digits = ["1234","4455","2222","8888","4444"];
    let reuse = "one";
    
    var cardArray = [String]();
    var nickNameArray = [String]();
    var mainArray = [String]();
    var cvcArray = [String]();
    var expirationArray = [String]();
    var cardFull = [String]();
    
    override func viewDidLoad() {
        self.navigationItem.title = "Select Credit Card";
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil);
        self.view.backgroundColor = UIColor.white;
        getData();
        setup();
    }
    
    private func getData(){
        for card in cCards{
            //card is an object
            self.cardArray.append(card.value(forKey: "last4") as! String);
            self.nickNameArray.append(card.value(forKey: "nickName") as! String);
            self.mainArray.append(card.value(forKey: "mainCard") as! String);//get if the card is main or not
            self.cvcArray.append(card.value(forKey: "cvc") as! String);
            self.expirationArray.append(card.value(forKey: "expiration") as! String);
            self.cardFull.append(card.value(forKey: "cardNum") as! String);
        }
    }
    
    private func setup(){
        let layout = UICollectionViewFlowLayout();
        creditCardTable = UICollectionView(frame: .zero, collectionViewLayout: layout);
        creditCardTable.delegate = self;
        creditCardTable.dataSource = self;
        creditCardTable.translatesAutoresizingMaskIntoConstraints = false;
        creditCardTable.register(CreditCardCell.self, forCellWithReuseIdentifier: reuse);
        creditCardTable.backgroundColor = UIColor.white;
        self.view.addSubview(creditCardTable);
        creditCardTable.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true;
        creditCardTable.topAnchor.constraint(equalTo: self.view.topAnchor,constant: 5).isActive = true;
        creditCardTable.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        creditCardTable.heightAnchor.constraint(equalToConstant: self.view.frame.height/2).isActive = true;
//        print(self.view.frame.height/3)
//        creditCardTable.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true;
        
        //addNewCardButton
        addNewCardButton = UIButton(type: .system);
        addNewCardButton.translatesAutoresizingMaskIntoConstraints = false;
        addNewCardButton.setTitle("Add Card", for: .normal);
        addNewCardButton.setTitleColor(UIColor.black, for: .normal);
        addNewCardButton.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 12);
        addNewCardButton.backgroundColor = UIColor.appYellow;
        addNewCardButton.layer.borderColor = UIColor.black.cgColor;
        addNewCardButton.layer.borderWidth = 0.25;
        addNewCardButton.layer.cornerRadius = 5;
        self.view.addSubview(addNewCardButton);
        //need x,y,with,height
        addNewCardButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true;
        addNewCardButton.topAnchor.constraint(equalTo: self.creditCardTable.bottomAnchor, constant: 5).isActive = true;
        addNewCardButton.widthAnchor.constraint(equalToConstant: 90).isActive = true;
        addNewCardButton.heightAnchor.constraint(equalToConstant: 40).isActive = true;
        addNewCardButton.addTarget(self, action: #selector(handleAddPaymentMethod), for: .touchUpInside);
    }
    
    @objc private func handleAddPaymentMethod(){
        let addCard = AddPaymentPage();
        self.navigationController?.pushViewController(addCard, animated: true);
    }
    
    func addCardViewControllerDidCancel(_ addCardViewController: STPAddCardViewController) {
        self.navigationController?.popViewController(animated: true);
    }
    
    func addCardViewController(_ addCardViewController: STPAddCardViewController, didCreateToken token: STPToken, completion: @escaping STPErrorBlock) {
        dismiss(animated: true, completion: nil);
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuse, for: indexPath) as! CreditCardCell
        let currentCard = cards![indexPath.item];
        cell.setNickname(name: currentCard.nickName!);
        cell.setLast4(digits: currentCard.last4!);
        if(indexPath.item == cards!.count){
            cell.hideBorder();
        }else{
            cell.border.isHidden = false;
        }
        
        if(fromProfilePage){
            cell.hideButton();
        }else{
            cell.addButton.isHidden = false;
        }
        
        cell.btnTapped = {
            self.selectedCard = self.cards![indexPath.item]//getting cards
            
            
            if(self.fromUpgradeSubscriptionpage){
                let alert = UIAlertController(title: "Upgrade", message: "Upgrade to \(self.subscriptionPlan!)? We will charge this card \(self.subscriptionCharge!).", preferredStyle: .alert);
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (result) in
                    //send to server to update and then simeutaenously update subPlan and FreeOrders
                    
                    //toselect card
                    
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
                    
                }))
                self.present(alert, animated: true, completion: nil);
            }else{
                self.navigationController?.popViewController(animated: true);
            }
        }
        
        return cell;
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if(cCards.count>0){
//            return cCards.count;
//        }else{
//            return 0;
//        }
        if(cards!.count>0){
            return cards!.count;
        }else{
            return 0;
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 50);
    }
    
    
    
    private class CreditCardCell: UICollectionViewCell{
        //MARK: Elements
        var nickName: UILabel!;
        var last4Numbers: UILabel!;
        var border: UIView!;
        var addButton: UIButton!;
        var btnTapped: (()->())?
        
        override init(frame: CGRect) {
            super.init(frame: frame);
            self.backgroundColor = UIColor.white;
            setup();
        }
        
        private func setup(){
            //nickName
            nickName = UILabel();
            nickName.translatesAutoresizingMaskIntoConstraints = false;
            nickName.text = "NickName goes here";
            nickName.textColor = UIColor.black;
            nickName.minimumScaleFactor = 0.1;
            nickName.adjustsFontSizeToFitWidth = true;
            nickName.numberOfLines = 1;
            nickName.font = UIFont(name: "Montserrat-SemiBold", size: 14);
            self.addSubview(nickName);
            //x,y,width,height
            nickName.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 5).isActive = true;
            nickName.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
            nickName.widthAnchor.constraint(equalToConstant: 75).isActive = true;
            nickName.heightAnchor.constraint(equalToConstant: 25).isActive = true;
            
            //last 4 numbers
            last4Numbers = UILabel();
            last4Numbers.translatesAutoresizingMaskIntoConstraints = false;
            last4Numbers.text = "3421";
            last4Numbers.textColor = UIColor.black;
            last4Numbers.minimumScaleFactor = 0.1;
            last4Numbers.numberOfLines = 1;
            last4Numbers.adjustsFontSizeToFitWidth = true;
            last4Numbers.textColor = UIColor.black;
            last4Numbers.font = UIFont(name: "Montserrat-Regular", size: 14);
            self.addSubview(last4Numbers);
            //x,y,width,height
            last4Numbers.leftAnchor.constraint(equalTo: self.nickName.rightAnchor, constant: 15).isActive = true;
            last4Numbers.centerYAnchor.constraint(equalTo: self.nickName.centerYAnchor).isActive = true;
            last4Numbers.widthAnchor.constraint(equalToConstant: 200).isActive = true;
            last4Numbers.heightAnchor.constraint(equalToConstant: 25).isActive = true;
            
            addButton = UIButton(type: .system);
            addButton.translatesAutoresizingMaskIntoConstraints = false;
            addButton.setTitle("+", for: .normal);
            addButton.setTitleColor(UIColor.black, for: .normal);
            addButton.backgroundColor = UIColor.appYellow;
            addButton.layer.cornerRadius = 5;
            self.addSubview(addButton);
            addButton.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -15).isActive = true;
            addButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
            addButton.widthAnchor.constraint(equalToConstant: 30).isActive = true;
            addButton.heightAnchor.constraint(equalToConstant: 30).isActive = true;
            addButton.addTarget(self, action: #selector(self.selectCard), for: .touchUpInside);
            
            border = UIView();
            border.translatesAutoresizingMaskIntoConstraints = false;
            border.backgroundColor = UIColor.gray;
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
            btnTapped?()
        }
        
        func setNickname(name: String!){
            self.nickName.text = name;
        }
        
        func setLast4(digits: String!){
            self.last4Numbers.text = digits;
        }
        func hideBorder(){
            self.border.isHidden = true;
        }
        
        func hideButton(){
            self.addButton.isHidden = true;
        }
    }//collectionview cell end
    
    private func upgradeStandard(){
        //upgrade to standard
        let total = 7.99;
        updateSubscriptionServers(total: total);
        
        subPlan = "Standard";
        freeOrders = freeOrders! + 5;
        saveSubscription(defaults: defaults!, subscriptionPlan: subPlan!, freeOrders: freeOrders!);
        alertConfirmation()
    }
    
    private func upgradePremium(){
        let total = 10.99;
        updateSubscriptionServers(total: total);
        
        subPlan = "Premium";
        freeOrders = freeOrders! + 10;
        saveSubscription(defaults: defaults!, subscriptionPlan: subPlan!, freeOrders: freeOrders!);
        alertConfirmation()
    }
    
    private func upgradeExecutive(){
        let total = 14.99;
        updateSubscriptionServers(total: total);
        
        subPlan = "Executive";
        freeOrders = freeOrders! + 15;
        saveSubscription(defaults: defaults!, subscriptionPlan: subPlan!, freeOrders: freeOrders!);
        alertConfirmation()
    }
    
    private func updateSubscriptionServers(total: Double){
        let cardParams = STPCardParams();
        let expirationString = self.selectedCard!.expirationDate!.components(separatedBy: "/");
        let expirationMonth = expirationString[0];
        let expirationYear = expirationString[1];
        cardParams.number = self.selectedCard!.cardNumber!
        cardParams.expMonth = UInt((expirationMonth as NSString).integerValue);
        cardParams.expYear = UInt((expirationYear as NSString).integerValue);
        cardParams.cvc = self.selectedCard!.cvcNumber!;
        
//        cardParams.number = paymentFullCard!;
//        cardParams.expMonth = UInt((cardExpMonth! as NSString).integerValue);
//        cardParams.expYear = UInt((cardExpYear! as NSString).integerValue);
//        cardParams.cvc = cardCvc!;
        
        STPAPIClient.shared().createToken(withCard: cardParams) { (token: STPToken?, error: Error?) in
            guard let token = token, error == nil else {
                // Present error to user...
                return
            }
            let conn = Conn();
            let postBody = "UserID=\(self.userID!)&subPlan=\(self.subPlan!)&freeOrders=\(self.freeOrders!)&email=\(self.email!)&stripeToken=\(token)&total=\(total)"
//            print(postBody);
            conn.connect(fileName: "updateSubscription.php", postString: postBody) { (result) in
            }
        }
        
    }
    
    private func alertConfirmation(){
        let alert = UIAlertController(title: "Finalized!", message: "You have been upgraded to \(self.subscriptionPlan!) plan. Orders have been added and your card has been charged.", preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Ok!", style: .default, handler: { (result) in
            self.navigationController?.popToRootViewController(animated: true);
        }))
        self.present(alert, animated: true, completion: nil);
    }
    
    
}
