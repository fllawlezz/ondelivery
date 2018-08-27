//
//  PlaceOrderPage.swift
//  YummyV1
//
//  Created by Brandon In on 7/24/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit


class PlaceOrderPage: UIViewController, UserOptionsTableDelegate {
    
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
        setupNavBar();
        setupUserOptionsTable();
        setupPlaceOrderButton();
    }
    
    fileprivate func setupNavBar(){
//        self.title = "Place Order";
        self.navigationItem.title = "PlaceOrder";
        
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil);
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton;
    }
    
    fileprivate func setupUserOptionsTable(){
        self.view.addSubview(userOptionsTable);
        userOptionsTable.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 5).isActive = true;
        userOptionsTable.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -5).isActive = true;
        userOptionsTable.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 5).isActive = true;
        if #available(iOS 11.0, *) {
            userOptionsTable.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -65).isActive = true
        } else {
            // Fallback on earlier versions
            userOptionsTable.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -65).isActive = true;
        };
        userOptionsTable.userOptionsDelegate = self;
        
    }
    
    fileprivate func setupPlaceOrderButton(){
        self.view.addSubview(placeOrderButton);
        placeOrderButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true;
        placeOrderButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true;
        if #available(iOS 11.0, *) {
            placeOrderButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        } else {
            // Fallback on earlier versions
            placeOrderButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -10).isActive = true;
        };
        
        placeOrderButton.heightAnchor.constraint(equalToConstant: 50).isActive = true;
    }
    
    
    
}

extension PlaceOrderPage{
    func toAddressPage() {
        let addressPage = UserOptionAddressPage();
        addressPage.delegate = userOptionsTable;
        self.navigationController?.pushViewController(addressPage, animated: true);
    }
    
    func toDeliveryTimePage(){
        let deliveryTimePage = DeliveryTimePage();
        deliveryTimePage.deliveryTimeDelegate = userOptionsTable;
        self.navigationController?.pushViewController(deliveryTimePage, animated: true);
    }
    
    func toPaymentPage(){
        let paymentPage = PaymentPage();
        paymentPage.paymentPageDelegate = userOptionsTable;
        self.navigationController?.pushViewController(paymentPage, animated: true);
    }
    
    func toCredentialsPage(){
        let credentialsPage = CustomerCredentialsPage();
        credentialsPage.customerCredentialsPageDelegate = userOptionsTable;
        self.navigationController?.pushViewController(credentialsPage, animated: true);
    }
}
