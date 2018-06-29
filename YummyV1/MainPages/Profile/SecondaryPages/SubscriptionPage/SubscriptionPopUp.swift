//
//  SubscriptionPopUp.swift
//  YummyV1
//
/*
 view that pops up from the bottom to let them upgrade/cancel
 */
//  Created by Brandon In on 3/30/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class SubscriptionPopUp: UIView{
    
    var profileSubscriptionPage: ProfileSubscriptionPage? {
        didSet{
            self.cancelButton.addTarget(profileSubscriptionPage, action: #selector(profileSubscriptionPage!.cancelPlan), for: .touchUpInside);
            self.upgradeButton.addTarget(profileSubscriptionPage, action: #selector(profileSubscriptionPage!.toUpgradePage), for: .touchUpInside);
        }
    }
    
    lazy var upgradeButton: UIButton = {
        let upgradeButton = UIButton(type: .system);
        upgradeButton.translatesAutoresizingMaskIntoConstraints = false;
        upgradeButton.backgroundColor = UIColor.black;
        upgradeButton.setTitle("Upgrade", for: .normal);
        upgradeButton.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 14);
        upgradeButton.setTitleColor(UIColor.white, for: .normal);
        return upgradeButton;
    }()
    
    lazy var cancelButton: UIButton = {
        let cancelButton = UIButton(type: .system);
        cancelButton.translatesAutoresizingMaskIntoConstraints = false;
        cancelButton.backgroundColor = UIColor.black;
        cancelButton.setTitle("Cancel Subscription", for: .normal);
        cancelButton.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 14);
        cancelButton.setTitleColor(UIColor.white, for: .normal);
        return cancelButton;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        self.backgroundColor = UIColor.white;
        
        self.addSubview(upgradeButton);
        upgradeButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true;
        upgradeButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true;
        upgradeButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true;
        upgradeButton.heightAnchor.constraint(equalToConstant: 40).isActive = true;
        
        self.addSubview(cancelButton);
        cancelButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true;
        cancelButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true;
        cancelButton.topAnchor.constraint(equalTo: self.upgradeButton.bottomAnchor, constant: 20).isActive = true;
        cancelButton.heightAnchor.constraint(equalToConstant: 40).isActive = true;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
}
