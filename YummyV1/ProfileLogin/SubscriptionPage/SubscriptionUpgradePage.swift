//
//  SubscriptionUpgradePage.swift
//  YummyV1
//
/*
 Present user with the three options: standard, premium, executive
 When user presses to upgrade to one of the three, then the difference between the last subscription is added to freeOrders
 */
//  Created by Brandon In on 3/30/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit
import Stripe

class SubscriptionUpgradePage: UIViewController{
    
    var subscriptionView: SubscriptionCollectionView!
    
    override func viewDidLoad() {
        self.title = "Upgrade";
        
        let leftBarButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil);
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = leftBarButton;
        
        self.view.backgroundColor = UIColor.white;
        
        print(self.view.frame.width);
        print(self.view.frame.height);
        
        let layout = UICollectionViewFlowLayout();
        layout.scrollDirection = .horizontal;
        subscriptionView = SubscriptionCollectionView(frame: .zero, collectionViewLayout: layout);
        subscriptionView.translatesAutoresizingMaskIntoConstraints = false;
        subscriptionView.subscriptionUpgradePage = self;
//        subscriptionView.mainView = self.view;
        self.view.addSubview(subscriptionView);
        subscriptionView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        subscriptionView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        subscriptionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true;
        subscriptionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true;
        
    }
        
    
}
