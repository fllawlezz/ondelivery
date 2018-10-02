//
//  TotalsCollectionView.swift
//  YummyV1
//
//  Created by Brandon In on 7/25/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class TotalsCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    let reuseOne = "one";
    let descriptionTitles = ["Delivery Fee", "Tax and Fees","Total"]
    
    var deliveryTotal: Double?
    var orderTotal:Double?
    var taxAndFees: Double?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        taxAndFees = 0;
        deliveryTotal = 0;
        orderTotal = 0;
        
        super.init(frame: frame, collectionViewLayout: layout);
        addObservers();
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = UIColor.white;
        self.showsVerticalScrollIndicator = false;
        self.showsHorizontalScrollIndicator = false;
        self.alwaysBounceVertical = false;
        self.register(TotalsCollectionViewCell.self, forCellWithReuseIdentifier: reuseOne);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self);
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseOne, for: indexPath) as! TotalsCollectionViewCell;
        cell.setDescription(description: descriptionTitles[indexPath.item])
        switch(indexPath.item){
        case 0:
            if let deliveryTotal = self.deliveryTotal{
                cell.setTotal(total: deliveryTotal);
            }
            break;
        case 1:
            if let taxAndFees = self.taxAndFees{
                cell.setTotal(total: taxAndFees);
            }
            break;
        case 2:
            if let orderTotal = self.orderTotal{
                cell.setTotal(total: orderTotal);
            }
            break;
        default: break;
        }
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3;
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: 25);
    }
    
    fileprivate func addObservers(){
        let notification = Notification.Name(rawValue: updateTipsValueNotification);
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateTotal(notification:)), name: notification, object: nil);
    }
    
    @objc fileprivate func updateTotal(notification: NSNotification){
        if let info = notification.userInfo{
            let tipTotal = info["tipTotal"] as! Double;
            //            self.totalSum += tipTotal;
            let newTotal = self.orderTotal! + tipTotal;
            setOrderTotal(orderTotal: newTotal);
            
        }
    }
    
}

extension TotalsCollectionView{
    fileprivate func setDeliveryFee(deliveryFee: Double){
        let cell = self.cellForItem(at: IndexPath(item: 0, section: 0)) as! TotalsCollectionViewCell;
        cell.setTotal(total: deliveryFee);
    }
    
    fileprivate func setTaxAndFees(taxAndFees:Double){
        let cell = self.cellForItem(at: IndexPath(item: 1, section: 0)) as! TotalsCollectionViewCell;
        cell.setTotal(total: taxAndFees);
    }
    
    fileprivate func setOrderTotal(orderTotal: Double){
        let cell = self.cellForItem(at: IndexPath(item: 2, section: 0)) as! TotalsCollectionViewCell;
        cell.setTotal(total: orderTotal);
    }
}
