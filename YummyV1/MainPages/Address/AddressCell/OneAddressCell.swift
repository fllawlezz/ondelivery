//
//  OneAddressCell.swift
//  YummyV1
//
//  Created by Brandon In on 7/6/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class OneAddressCell:UICollectionViewCell{
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
}
