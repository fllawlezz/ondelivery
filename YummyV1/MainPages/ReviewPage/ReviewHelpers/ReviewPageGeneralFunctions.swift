//
//  ReviewPageGeneralFunctions.swift
//  YummyV1
//
//  Created by Brandon In on 3/14/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import Stripe

extension ReviewPage{
    //MARK: NewNavControllers
    //-----------------------------------------------
    
    @objc func clear(){
        self.newNavController.dismiss(animated: true, completion: nil);
    }
    
    //MARK: GetTableInfo
    func getTableInfo(){
        self.paymentCard = Card();
        
        for item in cCards{
            if((item.value(forKey: "mainCard") as! String) == "Y"){
                //card number = the global card
                let expirationString = item.value(forKey: "expiration") as! String;
//                let expirationStringArray = expirationString.components(separatedBy: "/");
                paymentCard?.expiration = expirationString;
                paymentCard?.cvc = item.value(forKey: "cvc") as? String;
                paymentCard?.cardNum = item.value(forKey: "cardNum") as? String;
                paymentCard?.last4 = item.value(forKey: "last4") as? String;
                
//                cardExpMonth = expirationStringArray[0];
//                cardExpYear = expirationStringArray[1];
//                cardCvc = item.value(forKey: "cvc") as! String;
//                paymentFullCard = item.value(forKey: "cardNum") as! String;
//                let text = item.value(forKey: "last4") as! String;
//                paymentUserText = "...\(text)"
            }
        }
    }
}
