//
//  ServiceFeeCell.swift
//  YummyV1
//
//  Created by Brandon In on 8/16/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class ServiceFeeCell: UICollectionViewCell{
    
    var serviceFeeLabel: UITextViewNoResponder = {
        let serviceFeeLabel = UITextViewNoResponder();
        serviceFeeLabel.translatesAutoresizingMaskIntoConstraints = false;
        serviceFeeLabel.font = .montserratSemiBold(fontSize: 14);
        serviceFeeLabel.textAlignment = .right;
        return serviceFeeLabel;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        setupServiceFeeLabel();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupServiceFeeLabel(){
        self.addSubview(serviceFeeLabel);
        serviceFeeLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        serviceFeeLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true;
        serviceFeeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        serviceFeeLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true;
    }
    
    func setServiceFeePrice(taxAndFees: Double){
        let taxAndFeesFormat = String(format: "%.2f", taxAndFees);
        self.serviceFeeLabel.text = "Tax and Fees: $\(taxAndFeesFormat)";
    }
    
}
