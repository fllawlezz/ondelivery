//
//  FiltersSectionTwoCell.swift
//  YummyV1
//
//  Created by Brandon In on 6/28/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import Foundation
import UIKit

class FiltersSectionTwoCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    var filtersPage: FiltersPage?
    
    var priceCollectionView: UICollectionView!
    
    var pricesArray = [Int]();
    var reuseOne = "one";
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        setup();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setup(){
        self.backgroundColor = UIColor.white;
        
        let layout = UICollectionViewFlowLayout();
        priceCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout);
        priceCollectionView.backgroundColor = UIColor.white;
        priceCollectionView.translatesAutoresizingMaskIntoConstraints = false;
        priceCollectionView.register(PriceCollectionViewCell.self, forCellWithReuseIdentifier: reuseOne);
        priceCollectionView.dataSource = self;
        priceCollectionView.delegate = self;
        self.addSubview(priceCollectionView);
        priceCollectionView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true;
        priceCollectionView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true;
        priceCollectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        priceCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseOne, for: indexPath) as! PriceCollectionViewCell;
        cell.filtersSectionTwo = self;
        switch(indexPath.item){
            case 0:
                cell.setPriceTitle(price: "$", cellPrice: 1);
                break;
            case 1: cell.setPriceTitle(price: "$$", cellPrice: 2);break;
            case 2: cell.setPriceTitle(price: "$$$", cellPrice: 3);break;
            default: break;
        }
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((self.filtersPage?.view.frame.width)!/3)-10, height: 50);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func handleSendPriceArray()->[Int]{
        return pricesArray;
    }
}
