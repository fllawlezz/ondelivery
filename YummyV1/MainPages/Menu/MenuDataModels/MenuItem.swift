//
//  MenuItem.swift
//  YummyV1
//
//  Created by Brandon In on 3/28/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import Foundation

//MARK: Class Menu Items

class MenuItem{
    var name:String!;
    var price: Double!;
    var quantity: Int!;
    var mainCellIndex: Int!;
    var id: String!;
    
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
        //        print("Q:\(quantity)")
    }
    
    func subtractQuantity(giveQuantity: Int){
        quantity = quantity - giveQuantity;
        //        print("QS:\(quantity)")
    }
    
    func setIndex(index: Int){
        mainCellIndex = index;
    }
    
    func setID(id: String!){
        self.id = id;
    }
}
