//
//  ReviewItemsCell.swift
//  YummyV1
//
//  Created by Brandon In on 8/20/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class ReviewItemsCell: UICollectionViewCell{
    
    lazy var reviewCollectionView: ReviewItemsCollectionView = {
        let layout = UICollectionViewFlowLayout();
        let reviewCollectionView = ReviewItemsCollectionView(frame: .zero, collectionViewLayout: layout);
        return reviewCollectionView;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        setupCollectionView();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupCollectionView(){
        self.addSubview(reviewCollectionView);
        reviewCollectionView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        reviewCollectionView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        reviewCollectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        reviewCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
    }
    
}
