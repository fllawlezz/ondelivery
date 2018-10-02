//
//  TipsCell.swift
//  YummyV1
//
//  Created by Brandon In on 7/25/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class TipsCell: UICollectionViewCell{
    
    var placeOrderPage: PlaceOrderPage?
    var totalSum: Double?{
        didSet{
            tipsCollectionView.totalSum = self.totalSum;
        }
    }
    
    lazy var tipsCollectionView: TipsCollectionView = {
        let layout = UICollectionViewFlowLayout();
        let tipsCollectionView = TipsCollectionView(frame: .zero, collectionViewLayout: layout);
        tipsCollectionView.placeOrderPage = self.placeOrderPage;
        tipsCollectionView.totalSum = self.totalSum;
        return tipsCollectionView;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
//        print(totalSum!);
        setupCollectionView();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupCollectionView(){
        self.addSubview(tipsCollectionView);
        tipsCollectionView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true;
        tipsCollectionView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true;
        tipsCollectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        tipsCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        
        
    }
    
}
