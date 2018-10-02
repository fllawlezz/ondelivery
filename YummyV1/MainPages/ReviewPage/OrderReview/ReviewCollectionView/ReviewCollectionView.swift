//
//  ReviewCollectionView.swift
//  YummyV1
//
//  Created by Brandon In on 7/25/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class ReviewCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    let reuseItemcell = "itemCell";
    let reuseDeliveryFeeCell = "deliveryFeeCell";
    let reuseServiceFeeCell = "serviceFeeCell";
    let reuseInstructionsCell = "sepcialInstructionsCell";
    let reusePromoCode = "promoCodeCell";
    
    var menuItemArray: [MainItem]?;
    
    var totalSum: Double?;
    var deliveryCharge: Double?;
    var taxAndFees: Double?;
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout);
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.backgroundColor = UIColor.white;
        self.delegate = self;
        self.dataSource = self;
        self.register(ReviewItemsCell.self, forCellWithReuseIdentifier: reuseItemcell);
        self.register(DeliveryFeeCell.self, forCellWithReuseIdentifier: reuseDeliveryFeeCell);
        self.register(ServiceFeeCell.self, forCellWithReuseIdentifier: reuseServiceFeeCell);
        self.register(SpecialInstructionsCell.self, forCellWithReuseIdentifier: reuseInstructionsCell);
        self.register(PromoCodeCell.self, forCellWithReuseIdentifier: reusePromoCode);
//        print(menuItemArray!.count)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(indexPath.section == 0){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseItemcell, for: indexPath) as! ReviewItemsCell;
            cell.menuItemArray = self.menuItemArray;
            return cell;
        }else if(indexPath.section == 1){
            if(indexPath.item == 0){
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusePromoCode, for: indexPath) as! PromoCodeCell
                return cell;
                
            }else if (indexPath.item == 1){
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseDeliveryFeeCell, for: indexPath) as! DeliveryFeeCell;
//                cell.setDeliveryFee(deliveryFee: 3.99);
                if let deliveryCharge = self.deliveryCharge{
                    cell.setDeliveryFee(deliveryFee: deliveryCharge);
                }
                return cell;
            }else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseServiceFeeCell, for: indexPath) as! ServiceFeeCell;
//                cell.setServiceFeePrice(taxAndFees: 3.99+2.21);
                if let taxAndFees = self.taxAndFees{
                    cell.setServiceFeePrice(taxAndFees: taxAndFees);
                }
                return cell;
            }
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseInstructionsCell, for: indexPath) as! SpecialInstructionsCell;
            return cell;
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(section == 0){
//            if let itemArray = self.menuItemArray{
//                return itemArray.count;
//            }
            return 1;//change to the amount of items in the mainItemArray
        }else if(section == 1){
            return 3;
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
        if(section == 2){
            return UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0);
        }
        return UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(indexPath.section == 0){
            return CGSize(width: self.frame.size.width, height: 200);
        }else if(indexPath.section == 1){
            return CGSize(width: self.frame.size.width, height: 30);
        }else{
            return CGSize(width: self.frame.size.width, height: 100);
        }
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let indexPath = IndexPath(item: 0, section: 2);
        let cell = self.cellForItem(at: indexPath) as! SpecialInstructionsCell;
        if(cell.instructionsField.isFirstResponder){
            cell.instructionsField.resignFirstResponder();
            
            let keyboardDown = Notification.Name(rawValue: specialInstructionsKeyboardDown);
            NotificationCenter.default.post(name: keyboardDown, object: nil);
        }
        
        let name = Notification.Name(rawValue: resignPromoCodeNotification);
        NotificationCenter.default.post(name: name, object: nil);
    }
    

    
}
