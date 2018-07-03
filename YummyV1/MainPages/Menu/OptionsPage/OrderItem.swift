//
//  OrderItem.swift
//  YummyV1
//
//  Created by Brandon In on 7/2/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import Foundation

class OrderItem: NSObject{
    var foodName: String!
    var foodPrice: Double!
    var foodQuantity: Int!
    var specialOptions: [SpecialOption]!
    
    init(foodName: String, foodPrice: Double, foodQuantity: Int, specialOptions: [SpecialOption]){
        self.foodName = foodName;
        self.foodPrice = foodPrice;
        self.foodQuantity = foodQuantity;
        self.specialOptions = specialOptions;
    }
}
