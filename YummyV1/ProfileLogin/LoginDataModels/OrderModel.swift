//
//  OrderModel.swift
//  YummyV1
//
//  Created by Brandon In on 6/19/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import Foundation
import UIKit

class PastOrder{
    
    var restaurantName: String?
    var restaurantID: String?
    var restaurantPic: UIImage?
    var totalSum: String?
    var orderID: String?
    var orderDate: String?
    var foods: [PastOrderFood]?// an array of the foods that were in that order
    
}
//@objc(PastOrderFood)
class PastOrderFood{
    var foodName: String?
    var foodPrice: String?
    var foodQuantity: String?
    var foodID: String?

}
