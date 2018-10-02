//
//  PaymentList.swift
//  YummyV1
//
//  Created by Brandon In on 8/22/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

protocol PaymentListDelegate{
//    func selectedPaymentOption(optionTitle: String);
    func selectedPaymentOption(cardNum: String, last4: String, cvc: String, expirationDate: String, nickName: String, cardID: String);
}

class PaymentList: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    var paymentListDelegate: PaymentListDelegate?
    
    let reusePaymentCell = "PaymentCell";
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout);
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = UIColor.white;
        self.register(PaymentCell.self, forCellWithReuseIdentifier: reusePaymentCell);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusePaymentCell, for: indexPath) as! PaymentCell;
//        cell.setData(paymentTitle: "My Main Card", paymentDetails: "...4646");
        if(indexPath.item < cCards.count){
            let cardTitle = cCards[indexPath.item].value(forKey: "nickName") as! String;
            let last4 = cCards[indexPath.item].value(forKey: "last4") as! String;
            let cardID = cCards[indexPath.item].value(forKey: "cardID") as! String;
            let cardNumber = cCards[indexPath.item].value(forKey: "cardNum") as! String;
            let expirationDate = cCards[indexPath.item].value(forKey: "expiration") as! String;
            let cvc = cCards[indexPath.item].value(forKey: "cvc") as! String;

            cell.setData(cardNum: cardNumber, expirationDate: expirationDate, cvc: cvc, last4: last4, nickName: cardTitle, cardID: cardID);
        }
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! PaymentCell;
        self.paymentListDelegate?.selectedPaymentOption(cardNum: cell.cardNumber!, last4: cell.last4!, cvc: cell.cvc!, expirationDate: cell.expirationDate!, nickName: cell.nickName!, cardID: cell.cardID!)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(cCards.count > 0){
            return cCards.count;
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.size.width, height: 50);
    }
    
}
