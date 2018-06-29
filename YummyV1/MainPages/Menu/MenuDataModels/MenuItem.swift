//
//  MenuItem.swift
//  YummyV1
//
//  Created by Brandon In on 3/28/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import Foundation

//MARK: Class Menu Items

class MenuItem: NSObject{
    var name:String!;
    var price: Double!;
    var quantity: Int!;
    var id: String!;
    var mainCellIndex: Int!;
    var cellSection: Int!;
    
    init(name: String, price: Double, quantity: Int){
        self.name = name;
        self.price = price;
        self.quantity = quantity;
    }
    
    func setName(nameString: String){
        name = nameString;
    }
    
    func setPrice(givePrice: Double){
        price = givePrice;
    }
    
    func addQuantity(giveQuantity: Int){
        quantity = quantity + giveQuantity;
    }
    
    func subtractQuantity(giveQuantity: Int){
        quantity = quantity - giveQuantity;
    }
    
    func setIndex(index: Int){
        mainCellIndex = index;
    }
    
    func setID(id: String!){
        self.id = id;
    }
}
