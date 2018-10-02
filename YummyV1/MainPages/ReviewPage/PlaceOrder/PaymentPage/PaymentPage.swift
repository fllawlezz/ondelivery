//
//  PaymentPage.swift
//  YummyV1
//
//  Created by Brandon In on 8/22/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

protocol PaymentPageDelegate{
    func selectedPayment(cardNum: String, last4: String, cvc: String, expirationDate: String, nickName: String, cardID: String);
}

class PaymentPage: UIViewController, PaymentListDelegate, AddPaymentPageDelegate{

    var paymentPageDelegate:PaymentPageDelegate?
    
    var paymentList: PaymentList = {
        let layout = UICollectionViewFlowLayout();
        let paymentList = PaymentList(frame: .zero, collectionViewLayout: layout);
        return paymentList;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.white;
        
        setupNavBar();
        setupPaymentList();
    }
    
    fileprivate func setupNavBar(){
        self.navigationItem.title = "Select Payment";
        
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: nil);
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton;
        
        let rightBarButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(self.handleToAddPayment));
        self.navigationItem.rightBarButtonItem = rightBarButton;
    }
    
    fileprivate func setupPaymentList(){
        self.view.addSubview(paymentList);
        paymentList.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        paymentList.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        paymentList.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true;
        paymentList.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true;
        
        paymentList.paymentListDelegate = self;
    }
}

extension PaymentPage{
    
    func selectedPaymentOption(cardNum: String, last4: String, cvc: String, expirationDate: String, nickName: String, cardID: String) {
        self.paymentPageDelegate?.selectedPayment(cardNum: cardNum, last4: last4, cvc: cvc, expirationDate: expirationDate, nickName: nickName, cardID: cardID);
        self.navigationController?.popViewController(animated: true);
    }
    
    
    
    @objc func handleToAddPayment(){
        let addPaymentPage = AddPaymentPage();
        addPaymentPage.addPaymentPageDelegate = self;
        self.navigationController?.pushViewController(addPaymentPage, animated: true);
    }
    
    func paymentAdded() {
        self.paymentList.reloadData();
    }
    

}
