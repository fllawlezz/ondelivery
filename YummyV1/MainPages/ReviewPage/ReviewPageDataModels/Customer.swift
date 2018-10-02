//
//  Customer.swift
//  YummyV1
//
//  Created by Brandon In on 7/7/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import Foundation

class Customer: NSObject{
    var customerName: String?
    var customerPhone: String?
    var customerEmail: String?
    var customerSubPlan: String?
    var customerID: String?
    var customerFreeOrders: Int?
    
    func isNil()->Bool{
        if(customerName == nil){
            return true;
        }
        
        if(customerPhone == nil){
            return true;
        }
        
        if(customerEmail == nil){
            return true;
        }
        
        return false;
    }
}
