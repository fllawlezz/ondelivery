//
//  UserOptionsTable.swift
//  YummyV1
//
//  Created by Brandon In on 7/24/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit
import Foundation

protocol UserOptionsTableDelegate{
    func toAddressPage();
    func toDeliveryTimePage();
    func toPaymentPage();
    func toCredentialsPage();
    func setAddress(userAddress: UserAddress);
    func setDeliveryTime(deliveryTime: String);
    func setPaymentCard(paymentCard: PaymentCard);
}

class UserOptionsTable: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UserAddressPageDelegate, DeliveryTimePageDelegate, PaymentPageDelegate, CustomerCredentialsPageDelegate{

    var userOptionsDelegate: UserOptionsTableDelegate?;
    
    let reuseOne = "one";
    let reuseTwo = "two";
    let reuseThree = "three";
    let reuseHeader = "header";
    
    let tableTitles = ["Address","Delivery Time","Payment","Name","Telephone","Email"];
    let tableImages = ["home","clock","creditCard","profile","phone","email"];
    
    let sectionTitles = ["Your Info","Tip","Totals"];
    
    var userAddress: UserAddress?{
        didSet{
            self.setAddress();
        }
    }
    var deliveryTime: String?{
        didSet{
            self.setDeliveryTime();
        }
    }
    var paymentCard: PaymentCard?{
        didSet{
            self.setPaymentCard();
        }
    }
    
    var customer: Customer?;
    
    var orderTotal: Double?;
    var deliveryCharge: Double?;
    var taxesAndFees: Double?;
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout);
        if(user == nil){
            customer = Customer();
            customer?.customerID = "1";
        }
        
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.dataSource = self;
        self.delegate = self;
        self.showsVerticalScrollIndicator = false;
        self.register(UserOptionCell.self, forCellWithReuseIdentifier: reuseOne);
        self.register(TipsCell.self, forCellWithReuseIdentifier: reuseTwo);
        self.register(UserOptionTotalsCell.self, forCellWithReuseIdentifier: reuseThree);
        self.register(UserOptionHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: reuseHeader);
        self.backgroundColor = UIColor.white;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(indexPath.section == 0){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseOne, for: indexPath) as! UserOptionCell;
            cell.setOptionTitle(optionTitle: tableTitles[indexPath.item]);
            cell.setOptionImage(optionImageName: tableImages[indexPath.item]);
            
            if(indexPath.item == 0 && self.userAddress != nil){
                cell.setOption(option: self.userAddress!.address!);
            }else if(indexPath.item == 1 && self.deliveryTime != nil){
                cell.setOption(option: self.deliveryTime!);
            }else if(indexPath.item == 2 && self.paymentCard != nil){
                cell.setOption(option: self.paymentCard!.cardNumber!);
            }else if(indexPath.item == 3){
                if(customer!.customerName != nil){
                    cell.setOption(option: "\(customer!.customerName!)")
                }
            }else if(indexPath.row == 4){
                if(customer!.customerPhone != nil){
                    cell.setOption(option: "\(customer!.customerPhone!)")
                }
            }else if(indexPath.row == 5){
                if(customer!.customerEmail != nil){
                    cell.setOption(option: "\(customer!.customerEmail!)");
                }
            }
            
            return cell;
        }else if (indexPath.section == 1){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseTwo, for: indexPath) as! TipsCell;
            cell.totalSum = self.orderTotal!;
            return cell;
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseThree, for: indexPath) as! UserOptionTotalsCell;
            cell.totalSum = self.orderTotal!+self.deliveryCharge!+self.taxesAndFees!;
            cell.deliveryCharge = self.deliveryCharge;
            cell.taxAndFees = self.taxesAndFees;
            return cell;
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.frame.width, height: 60);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(indexPath.section == 0){
            return CGSize(width: self.frame.width, height: 50);
        }else if(indexPath.section == 1){
            return CGSize(width: self.frame.width, height: 80);
        }else{
            return CGSize(width: self.frame.width, height: 160);
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reuseHeader, for: indexPath) as! UserOptionHeader;
        header.setSectionTitle(titleString: self.sectionTitles[indexPath.section]);
        return header;
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(section == 0){
            if(user != nil){
                return 3;
            }else{
                return 6;
            }
        }else{
            return 1;
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 25, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch(indexPath.item){
        case 0: selectAddress();break;
        case 1: selectDeliveryTime();break;
        case 2: selectPayment();break;
        case 3: enterCredentials();break;
        case 4: enterCredentials();break;
        case 5: enterCredentials();break;
        default: break;
        }
    }
    
    func selectAddress(){
        userOptionsDelegate?.toAddressPage();
    }
    
    func selectDeliveryTime(){
        userOptionsDelegate?.toDeliveryTimePage();
    }
    
    func selectPayment(){
        userOptionsDelegate?.toPaymentPage();
    }
    
    func enterCredentials(){
        userOptionsDelegate?.toCredentialsPage();
    }
    
}

extension UserOptionsTable{
    func didSelectAddress(selectedAddress: UserAddress) {
        let cell = self.cellForItem(at: IndexPath(item: 0, section: 0)) as! UserOptionCell;
        cell.setOption(option: selectedAddress.address!);
        
        let address = UserAddress();
        address.address = selectedAddress.address;
        address.city = selectedAddress.city;
        address.zipcode = selectedAddress.zipcode;
        address.state = selectedAddress.state;
        
        self.userAddress = address;
    }
    
    
    func handleSubmitTime(deliveryTime: String) {
        let cell = self.cellForItem(at: IndexPath(item: 1, section: 0)) as! UserOptionCell;
        cell.setOption(option: deliveryTime);
        
        self.deliveryTime = deliveryTime;
    }
    
    func selectedPayment(cardNum: String, last4: String, cvc: String, expirationDate: String, nickName: String, cardID: String) {
        let cell = self.cellForItem(at: IndexPath(item: 2, section: 0)) as! UserOptionCell;
        cell.setOption(option: "...\(last4)");
        
        let paymentCard = PaymentCard();
        paymentCard.cardID = cardID;
        paymentCard.cardNumber = cardNum;
        paymentCard.expirationDate = expirationDate;
        paymentCard.cvcNumber = cvc;
        paymentCard.nickName = nickName;
        paymentCard.last4 = last4;
        
        self.paymentCard = paymentCard;
    }
    


    func handleSaveCustomerInfo(customerName: String, customerPhone: String, customerEmail: String) {
        self.customer?.customerName = customerName;
        self.customer?.customerPhone = customerPhone;
        self.customer?.customerEmail = customerEmail;
        
        var count = 3;
        
        while(count<6){
            let cellIndexPath = IndexPath(item: count, section: 0);
            let cell = self.cellForItem(at: cellIndexPath) as! UserOptionCell;
            switch(count){
            case 3:cell.setOption(option: customerName);break;
            case 4: cell.setOption(option: customerPhone);break;
            case 5: cell.setOption(option: customerEmail);break;
                
            default: break;
            }
            count+=1;
        }
    }
    
    fileprivate func setAddress(){
        if let delegate = self.userOptionsDelegate{
            delegate.setAddress(userAddress: self.userAddress!);
        }
        
    }
    
    fileprivate func setDeliveryTime(){
        if let delegate = self.userOptionsDelegate{
            delegate.setDeliveryTime(deliveryTime: self.deliveryTime!);
        }
    }
    
    fileprivate func setPaymentCard(){
        if let delegate = self.userOptionsDelegate{
            delegate.setPaymentCard(paymentCard: self.paymentCard!);
        }
    }
    
}
