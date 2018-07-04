//
//  FoodItem.swift
//  YummyV1
//
//  Created by Brandon In on 7/4/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import Foundation

class FoodItem: NSObject{
    var foodName: String?
    var foodPrice: Double?
    var hasOptions: Bool?
    var options = [SpecialOption]();
    
    init(foodName: String, foodPrice: Double, hasOptions: Bool){
        self.foodName = foodName;
        self.foodPrice = foodPrice;
        self.hasOptions = hasOptions;
    }
    
}
