//
//  ReviewItemsCollectionView.swift
//  YummyV1
//
//  Created by Brandon In on 8/20/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class ReviewItemsCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    let reuseItem = "reuseItem";
    var menuItemArray: [MainItem]?{
        didSet{
            self.reloadData();
        }
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout);
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.backgroundColor = UIColor.white;
        self.register(ReviewItemCell.self, forCellWithReuseIdentifier: reuseItem);
        self.delegate = self;
        self.dataSource = self;
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseItem, for: indexPath) as! ReviewItemCell;
        
        if let itemArray = self.menuItemArray{
            let foodItem = itemArray[indexPath.item];
            let name = foodItem.name!;
            let quantity = foodItem.quantity!;
            let totalCost = foodItem.itemTotals!;
            cell.setItemData(itemName: name, itemQuantity: quantity, itemTotalCost: totalCost);
        }
        
        return cell;
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let itemArray = self.menuItemArray{
            return itemArray.count;
        }
        
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.size.width, height: 50);
    }
    
}
