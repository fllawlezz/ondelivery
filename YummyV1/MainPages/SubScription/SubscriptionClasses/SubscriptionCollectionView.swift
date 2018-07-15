//
//  SubscriptionCollectionView.swift
//  YummyV1
//
//  Created by Brandon In on 7/14/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class SubscriptionCollectionView:UICollectionView,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    var subscriptionUpgradePage: SubscriptionUpgradePage?
    
    let reuse = "one";
    
    let pageTitles = ["Standard","Premium","Executive"];
    let descriptions = ["With the standard plan comes 4 deliveries of $20 or less. You also get 20% off delivery charges for all orders over $20 and any order after your 4 deliveries are used up.","With the premium plan comes 8 deliveries of $20 or less. You also get 30% off delivery charges for all orders over $20 and any order after your 8 deliveries are used up.","With the executive plan comes 15 deliveries of $20 or less. You also get 40% off delivery charges for all orders over $20 and an yorder after your 15 deliveries are used up."]
    let prices = ["8.99","10.99","14.99"];
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout);
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.alwaysBounceVertical = false;
        self.showsVerticalScrollIndicator = false;
        self.isPagingEnabled = true;
        self.register(SubscriptionCell.self, forCellWithReuseIdentifier: reuse);
        self.backgroundColor = UIColor.white;
        self.delegate = self;
        self.dataSource = self;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.dequeueReusableCell(withReuseIdentifier: reuse, for: indexPath) as! SubscriptionCell;
        cell.setButtonTitle(buttonTitle: prices[indexPath.item]);
        cell.setTitle(title: pageTitles[indexPath.item]);
        cell.setSubDescription(description: descriptions[indexPath.item]);
        cell.subscriptionCollectionView = self;
        cell.subscriptionUpgradePage = self.subscriptionUpgradePage;
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: self.mainView!.frame.width, height: self.mainView!.frame.height);
        return CGSize(width: self.frame.width, height: self.frame.height);
    }
    
    
    
}
