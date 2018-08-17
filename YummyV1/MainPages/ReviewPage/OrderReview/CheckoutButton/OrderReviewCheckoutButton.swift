//
//  OrderReviewCheckoutButton.swift
//  YummyV1
//
//  Created by Brandon In on 7/25/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

protocol OrderReviewCheckoutButtonDelegate{
    func handleToCheckout();
    
}

class OrderReviewCheckoutButton: NormalUIButton{
    
//    var orderReviewPage: OrderReviewPage?
    var delegate: OrderReviewCheckoutButtonDelegate?
    
    override init(backgroundColor: UIColor, title: String, font: UIFont, fontColor: UIColor) {
        super.init(backgroundColor: backgroundColor, title: title, font: font, fontColor: fontColor);
        self.addTarget(self, action: #selector(handleToPlaceOrderPage), for: .touchUpInside);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    @objc func handleToPlaceOrderPage(){
        delegate?.handleToCheckout();
    }
    
}
