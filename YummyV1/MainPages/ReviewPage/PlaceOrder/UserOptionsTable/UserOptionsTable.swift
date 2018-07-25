//
//  UserOptionsTable.swift
//  YummyV1
//
//  Created by Brandon In on 7/24/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit


class UserOptionsTable: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    var placeOrderPage: PlaceOrderPage?;
    
    let reuseOne = "one";
    let reuseTwo = "two";
    let reuseHeader = "header";
    
    let tableTitles = ["Address","Delivery Time","Payment","Name","Telephone","Email"];
    let tableImages = ["home","clock","creditCard","profile","phone","email"];
    
    let sectionTitles = ["Your Info","Tip"];
    
    var userAddress: UserAddress?;
    var deliveryTime: String?;
    var paymentCard: PaymentCard?;
    
    var customer: Customer?;
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout);
//        user = nil;
//        customer = Customer();
//        customer?.customerEmail = "hi";
//        customer?.customerName = "what";
//        customer?.customerPhone = "555555";
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.dataSource = self;
        self.delegate = self;
        self.register(UserOptionCell.self, forCellWithReuseIdentifier: reuseOne);
        self.register(TipsCell.self, forCellWithReuseIdentifier: reuseTwo);
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
                cell.setOption(option: "\(customer!.customerName!)")
            }else if(indexPath.row == 4){
                cell.setOption(option: "\(customer!.customerPhone!)")
            }else if(indexPath.row == 5){
                cell.setOption(option: "\(customer!.customerEmail!)");
            }
            
            return cell;
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseTwo, for: indexPath) as! TipsCell;
            return cell;
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.frame.width, height: 60);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(indexPath.section == 0){
            return CGSize(width: self.frame.width, height: 50);
        }else{
            return CGSize(width: self.frame.width, height: 80);
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reuseHeader, for: indexPath) as! UserOptionHeader;
        header.setSectionTitle(titleString: self.sectionTitles[indexPath.section]);
        return header;
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2;
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
//        let selectAddress = SelectAddress();
    }
    
    func selectDeliveryTime(){
        
    }
    
    func selectPayment(){
        
    }
    
    func enterCredentials(){
        
    }
    
}
