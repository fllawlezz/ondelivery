//
//  MenuItem.swift
//  YummyV1
//
//  Created by Brandon In on 9/7/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class MenuItem{
    var foodName: String?
    var foodSection: Int?
    var foodPrice: Double?
    var foodID: String?
    var foodPicURL: String?
    var foodDescription: String?
    var foodImage: UIImage?
    var options: String?;
    
    init(foodName: String, foodSection: Int, foodPrice: Double, foodID: String, foodPicUrl: String, foodDescription: String, options: String) {
        self.foodName = foodName;
        self.foodSection = foodSection;
        self.foodPrice = foodPrice;
        self.foodID = foodID;
        self.foodPicURL = foodPicUrl;
        self.foodDescription = foodDescription;
        self.options = options;
    }
    
}
