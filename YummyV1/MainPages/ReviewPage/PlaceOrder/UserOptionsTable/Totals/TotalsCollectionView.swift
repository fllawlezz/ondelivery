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
    
    var deliveryTotal: Double?;
    var taxTotal: Double?;
    var feeTotal: Double?;
    
    var orderTotal:Double?;
    var taxAndFees: Double?;
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        taxAndFees = 7.99
        deliveryTotal = 3.99;
        orderTotal = 21.00
        
        super.init(frame: frame, collectionViewLayout: layout);
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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseOne, for: indexPath) as! TotalsCollectionViewCell;
        cell.setDescription(description: descriptionTitles[indexPath.item])
        switch(indexPath.item){
        case 0: cell.setTotal(total: deliveryTotal!);break;
        case 1: cell.setTotal(total: taxAndFees!);break;
        case 2: cell.setTotal(total: orderTotal!);break;
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
    
    
    
    
}
