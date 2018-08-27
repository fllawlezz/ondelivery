//
//  DeliveryFeeCell.swift
//  YummyV1
//
//  Created by Brandon In on 8/16/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class DeliveryFeeCell: UICollectionViewCell{
    
    var deliveryFeeLabel: NormalUILabel = {
        let deliveryFeeLabel = NormalUILabel(textColor: .black, font: .montserratSemiBold(fontSize: 14), textAlign: .right);
        return deliveryFeeLabel;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.clear;
        setupDeliveryFeeLabel();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupDeliveryFeeLabel(){
        self.addSubview(deliveryFeeLabel);
        deliveryFeeLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        deliveryFeeLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true;
        deliveryFeeLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        deliveryFeeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
    }
    
    func setDeliveryFee(deliveryFee: Double){
        let doubleFormat = String(format: "%.2f", deliveryFee);
        self.deliveryFeeLabel.text = "Delivery Fee: $\(doubleFormat)";
    }
    
}
