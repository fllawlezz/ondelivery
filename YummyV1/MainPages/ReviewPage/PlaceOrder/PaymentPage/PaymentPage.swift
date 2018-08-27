//
//  PaymentPage.swift
//  YummyV1
//
//  Created by Brandon In on 8/22/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

protocol PaymentPageDelegate{
    func selectedPayment(paymentTitle: String);
}

class PaymentPage: UIViewController, PaymentListDelegate{

    var paymentPageDelegate:PaymentPageDelegate?
    
    var paymentList: PaymentList = {
        let layout = UICollectionViewFlowLayout();
        let paymentList = PaymentList(frame: .zero, collectionViewLayout: layout);
        return paymentList;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.white;
        setupPaymentList();
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
    func selectedPaymentOption(optionTitle: String) {
        self.paymentPageDelegate?.selectedPayment(paymentTitle: optionTitle);
        self.navigationController?.popViewController(animated: true);
    }
    
    
}
