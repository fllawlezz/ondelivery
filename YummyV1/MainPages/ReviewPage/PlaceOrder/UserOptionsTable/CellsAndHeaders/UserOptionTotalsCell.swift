//
//  UserOptionTotalView.swift
//  YummyV1
//
//  Created by Brandon In on 7/25/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit
import NotificationCenter

class UserOptionTotalsCell: UICollectionViewCell{
    
    var totalSum: Double?{
        didSet{
            totalsCollectionView.orderTotal = self.totalSum;
        }
    }
    
    var deliveryCharge: Double?{
        didSet{
            totalsCollectionView.deliveryTotal = self.deliveryCharge;
        }
    }
    
    var taxAndFees: Double?{
        didSet{
            totalsCollectionView.taxAndFees = self.taxAndFees;
        }
    }
    
    lazy var totalsCollectionView: TotalsCollectionView = {
        let layout = UICollectionViewFlowLayout();
        let totalsCollectionView = TotalsCollectionView(frame: .zero, collectionViewLayout: layout);
        return totalsCollectionView;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        setup();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setup(){
        self.addSubview(totalsCollectionView);
        totalsCollectionView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true;
        totalsCollectionView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true;
        totalsCollectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true;
        totalsCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true;
    }
}
