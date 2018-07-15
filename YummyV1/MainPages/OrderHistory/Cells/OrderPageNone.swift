//
//  OrderPageNone.swift
//  YummyV1
//
//  Created by Brandon In on 7/14/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class OrderPageNone: UICollectionViewCell{
    
    var messageLabel: UILabel!;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        messageLabel = UILabel();
        messageLabel.translatesAutoresizingMaskIntoConstraints = false;
        messageLabel.text = "You do not have any past orders";
        messageLabel.font = UIFont(name: "Montserrat-Regular", size: 20);
        messageLabel.numberOfLines = 1;
        messageLabel.adjustsFontSizeToFitWidth = true;
        messageLabel.minimumScaleFactor = 0.1;
        messageLabel.textAlignment = .center;
        messageLabel.textColor = UIColor.black;
        self.addSubview(messageLabel);
        messageLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true;
        messageLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true;
        messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        messageLabel.heightAnchor.constraint(equalToConstant: 150).isActive = true;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
}
