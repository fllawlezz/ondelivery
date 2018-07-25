//
//  PlaceOrderPage.swift
//  YummyV1
//
//  Created by Brandon In on 7/24/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit


class PlaceOrderPage: UIViewController {
    
    lazy var userOptionsTable: UserOptionsTable = {
        let layout = UICollectionViewFlowLayout();
//        layout.itemSize = CGSize(width: self.view.frame.width, height: 50);
        let userOptionsTable = UserOptionsTable(frame: .zero, collectionViewLayout: layout);
        return userOptionsTable;
    }()
    
    lazy var placeOrderButton: PlaceOrderButton = {
        let placeOrderButton = PlaceOrderButton(backgroundColor: UIColor.appYellow, title: "Place Order", font: UIFont.montserratSemiBold(fontSize: 16), fontColor: UIColor.black);
        return placeOrderButton;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.white;
        setupUserOptionsTable();
        setupPlaceOrderButton();
    }
    
    fileprivate func setupUserOptionsTable(){
        self.view.addSubview(userOptionsTable);
        userOptionsTable.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 5).isActive = true;
        userOptionsTable.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -5).isActive = true;
        userOptionsTable.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 5).isActive = true;
        userOptionsTable.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -65).isActive = true;
    }
    
    fileprivate func setupPlaceOrderButton(){
        self.view.addSubview(placeOrderButton);
        placeOrderButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true;
        placeOrderButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true;
        placeOrderButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -10).isActive = true;
        placeOrderButton.heightAnchor.constraint(equalToConstant: 50).isActive = true;
    }
    
    
    
}
