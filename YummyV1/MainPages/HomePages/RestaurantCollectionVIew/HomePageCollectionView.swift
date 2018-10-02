//
//  File.swift
//  YummyV1
//
//  Created by Brandon In on 9/3/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

protocol HomePageCollectionViewDelegate{
    func didSelectItem(restaurant: Restaurant, restaurantID: String);
}

class HomePageCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    private let cellReusueIdentifier = "restCell";
    private let cellReusueIdentifier2 = "noCell";
    
    var homePageCollectionViewDelegate: HomePageCollectionViewDelegate?
    
    var restaurants: [Restaurant]?
//    var restaurants = [Restaurant]();
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout);
        setupCollectionView();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupCollectionView(){
        self.backgroundColor = UIColor.white;
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = UIColor.white;
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.register(MainPageListCell.self, forCellWithReuseIdentifier: cellReusueIdentifier);
        self.register(NoRestaurantsCell.self, forCellWithReuseIdentifier: cellReusueIdentifier2);
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let restaurantList = restaurants{
            if(restaurantList.count > 0){
                
                let cell = self.dequeueReusableCell(withReuseIdentifier: self.cellReusueIdentifier, for: indexPath) as! MainPageListCell;
                let restaurant = restaurantList[indexPath.item];
                cell.setNameAndAddress(name: restaurant.restaurantTitle!, address: restaurant.restaurantAddress!);
                cell.setPrice(price: 3.99);
                cell.cellImage.image = restaurant.restaurantBuildingImage;
                cell.setDistance(dist: restaurant.restaurantDistance!);
                return cell;
                }
        }
        
        let cell = self.dequeueReusableCell(withReuseIdentifier: self.cellReusueIdentifier2, for: indexPath) as! NoRestaurantsCell;
        return cell;
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let restaurantList = self.restaurants{
            return restaurantList.count;
        }
//        if(self.restaurants.count > 0){
//            return self.restaurants.count;
//        }else{
        return 1;
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;//only one section, resturaunts
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let restaurantList = self.restaurants{
            if(restaurantList.count > 0){
                return CGSize(width: self.frame.width, height: 105);
            }
        }
//        if(self.restaurants.count > 0){
//            return CGSize(width: self.frame.width, height: 105);
//        }else{
            return CGSize(width: self.frame.width, height: 130);
//        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let restaurantList = self.restaurants{
            if(restaurantList.count > 0){
//                loadMenu(index: indexPath.item, advertised: false);
                let restaurant = restaurantList[indexPath.item];
                let restaurantID = restaurant.restaurantID!;
                
                if let delegate = homePageCollectionViewDelegate{
                    delegate.didSelectItem(restaurant: restaurant, restaurantID: restaurantID);
                }
            }
        }
    }
    
//    fileprivate func loadMenu(index: Int, advertised: Bool){
//        if let delegate = homePageCollectionViewDelegate{
//            delegate.didSelectItem();
//        }
//    }
}
