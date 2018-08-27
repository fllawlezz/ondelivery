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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(indexPath.section == 0){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseItemcell, for: indexPath) as! ReviewItemsCell;
//            cell.setItemData(itemName: "Fried Rice", itemQuantity: 2, itemTotalCost: 15.25);
            return cell;
        }else if(indexPath.section == 1){
            if(indexPath.item == 0){
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseDeliveryFeeCell, for: indexPath) as! DeliveryFeeCell;
                cell.setDeliveryFee(deliveryFee: 3.99);
                return cell;
            }else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseServiceFeeCell, for: indexPath) as! ServiceFeeCell;
                cell.setServiceFeePrice(taxAndFees: 3.99+2.21);
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
            return 1;//change to the amount of items in the mainItemArray
        }else if(section == 1){
            return 2;
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
    }
    

    
}
