//
//  Food.swift
//  YummyV1
//
//  Created by Brandon In on 3/28/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class Food{
    //need name,price,sectionNumber
    var name: String!;
    var price: Double!;
    var section: Int!;
    var id: String!;
    var hotOrNot: String!;
    var image: UIImage!;
    var descript: String!;
    
    init(nameParam: String!, priceParam: Double!, sectionParam: Int!, foodID: String!, hOn: String!, pic: UIImage!, description: String!) {
        name = nameParam;
        price = priceParam;
        section = sectionParam;
        id = foodID;
        hotOrNot = hOn;
        image = pic;
        descript = description;
    }
}
