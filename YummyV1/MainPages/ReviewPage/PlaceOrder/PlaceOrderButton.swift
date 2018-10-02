//
//  PlaceOrderButton.swift
//  YummyV1
//
//  Created by Brandon In on 7/24/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

protocol PlaceOrderButtonDelegate{
    func placeOrder();
}

class PlaceOrderButton: NormalUIButton{
    
    var delegate: PlaceOrderButtonDelegate?;
    
    override init(backgroundColor: UIColor, title: String, font: UIFont, fontColor: UIColor) {
        super.init(backgroundColor: backgroundColor, title: title, font: font, fontColor: fontColor);
        self.addTarget(self, action: #selector(self.submitOrder), for: .touchUpInside);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    @objc func submitOrder(){
        if let delegate = self.delegate{
            delegate.placeOrder();
        }
    }
    
}
