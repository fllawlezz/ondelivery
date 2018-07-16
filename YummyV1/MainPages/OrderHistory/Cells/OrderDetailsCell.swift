//
//  OrderDetailsCell.swift
//  YummyV1
//
//  Created by Brandon In on 7/16/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class OrderDetailsCell: UICollectionViewCell{
    
    var foodTitle:NormalUILabel = {
        let foodTitle = NormalUILabel(textColor: UIColor.black, font: UIFont.montserratRegular(fontSize: 14), textAlign: .left);
        return foodTitle;
    }()
    
    var foodQuantity: NormalUILabel = {
        let foodQuantity = NormalUILabel(textColor: UIColor.red, font: UIFont.montserratRegular(fontSize: 14), textAlign: .center);
        return foodQuantity;
    }();
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        self.addSubview(foodTitle);
        self.addSubview(foodQuantity);
        
        foodTitle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true;
        foodTitle.rightAnchor.constraint(equalTo: self.centerXAnchor).isActive = true;
        foodTitle.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        foodTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        
        foodQuantity.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        foodQuantity.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        foodQuantity.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        foodQuantity.leftAnchor.constraint(equalTo: self.centerXAnchor).isActive = true;
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    func setTitle(foodTitle: String){
        self.foodTitle.text = foodTitle;
    }
    
    func setQuantity(foodQuantity: String){
        self.foodQuantity.text = "x\(foodQuantity)"
    }
    
    
}
