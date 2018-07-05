//
//  MenuItem.swift
//  YummyV1
//
//  Created by Brandon In on 3/28/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import Foundation

//MARK: Class Menu Items

class MainItem: NSObject{
    var name:String!;
    var itemTotals: Double!;
    var quantity: Int!;
    var id: String!;
    var hasOptions = false;
    var itemPrice: Double!;
    var foodItems = [FoodItem]();
    
    init(name: String, price: Double, quantity: Int){
        self.name = name;
        self.itemTotals = price;
        self.quantity = quantity;
    }
    
    func setName(nameString: String){
        name = nameString;
    }
    
    func setPrice(givePrice: Double){
        itemTotals = givePrice;
    }
    
    func addPrice(price: Double){
        itemTotals = itemTotals+price;
    }
    
    func subtractPrice(price: Double){
        itemTotals = itemTotals-price;
    }
    
    func addQuantity(giveQuantity: Int){
        quantity = quantity + giveQuantity;
    }
    
    func subtractQuantity(giveQuantity: Int){
        quantity = quantity - giveQuantity;
    }
    

    
    func setID(id: String!){
        self.id = id;
    }
}
