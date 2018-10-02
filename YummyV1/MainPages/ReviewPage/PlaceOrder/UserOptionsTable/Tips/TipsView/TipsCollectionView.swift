//
//  TipsCollectionView.swift
//  YummyV1
//
//  Created by Brandon In on 7/25/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

let updateTipsValueNotification = "updateTipsValueNotification"
let showTipsAlert = "showTipsAlert";

class TipsCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, TipsCollectionViewCellDelegate{
    
    var placeOrderPage: PlaceOrderPage?
    var totalSum: Double?;
    let percentageArray = [10.0,15.0,20.0,0];
    let reuseOne = "one";
    let reuseTwo = "two";
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout);
        setupCollectionView();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupCollectionView(){
        self.backgroundColor = UIColor.white;
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.delegate = self;
        self.dataSource = self;
        self.showsVerticalScrollIndicator = false;
        self.showsHorizontalScrollIndicator = false;
        self.register(TipsCollectionViewCell.self, forCellWithReuseIdentifier: reuseOne);
        self.register(TipsShowTotalCell.self, forCellWithReuseIdentifier: reuseTwo);
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(indexPath.item != 4){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseOne, for: indexPath) as! TipsCollectionViewCell;
            cell.setButtonTitle(percentage: percentageArray[indexPath.item]);
            cell.cellIndex = indexPath.item;
            cell.delegate = self;

            return cell;
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseTwo, for: indexPath) as! TipsShowTotalCell;
            return cell;
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 5;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(indexPath.item != 4){
            return CGSize(width: self.frame.width/4, height: 50);
        }else{
            return CGSize(width: self.frame.width, height: 25);
        }
    }
    
}

extension TipsCollectionView{
    func handleSelectedTip(cellIndex: Int, percentage: Double) {
        deselectAllCells()
        
        let indexPath = IndexPath(item: cellIndex, section: 0);
        let cell = self.cellForItem(at: indexPath) as! TipsCollectionViewCell;
        cell.selectButton();
        
        if(cellIndex == 3){
            //present tip alert
            let name = Notification.Name(rawValue: showTipsAlert);
            NotificationCenter.default.post(name: name, object: nil);
            return;
        }
        
        if let totalSum = self.totalSum{
            let tipTotal = totalSum * percentage;
            let name = Notification.Name(rawValue: updateTipsValueNotification);
            let userInfo = ["tipTotal":tipTotal]
            NotificationCenter.default.post(name: name, object: nil, userInfo: userInfo);
        }
    }
    
    fileprivate func deselectAllCells(){
        var count = 0;
        while(count < percentageArray.count){
            let indexPath = IndexPath(item: count, section: 0);
            let cell = self.cellForItem(at: indexPath) as! TipsCollectionViewCell;
            cell.unselectButton();
            count+=1;
        }
    }
}
