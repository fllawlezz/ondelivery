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
        setupNavBar();
        getData();
        setup();
    }
    
    fileprivate func setupNavBar(){
        self.navigationItem.title = "Select Credit Card";
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil);
        self.view.backgroundColor = UIColor.white;
        
        let addCardButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(handleAddPaymentMethod));
        self.navigationItem.rightBarButtonItem = addCardButton;
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
    }
    
    @objc private func handleAddPaymentMethod(){
        let addCard = AddPaymentPage();
        addCard.selectPaymentPage = self;
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
//        let currentCard = cCards[indexPath.item];
//        print(indexPath.item);
//        print(cell.setNickname(name: currentCard.value(forKey: "nickName") as! String));
//        cell.setNickname(name: currentCard.value(forKey: "nickName") as! String);
//        cell.setNickname(name: "new card");
//        cell.setLast4(digits: currentCard.value(forKey: "last4") as! String);
//        cell.setCardNum(cardNum: currentCard.value(forKey: "cardNum") as! String);
//        cell.setCardExpiration(expiration: currentCard.value(forKey: "expiration") as! String);
        
//        cell.setNickname(name: currentCard.nickName!);
//        cell.setLast4(digits: currentCard.last4!);
//        cell.setCardNum(cardNum: currentCard.cardNumber!);
//        cell.setCardExpiration(expiration: currentCard.expirationDate!);
        
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
        
        return cell;
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cCards.count;
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
    
    
}
