//
//  ReviewCell.swift
//  YummyV1
//
//  Created by Brandon In on 7/5/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class ReviewCell: UICollectionViewCell{
    
    var name: UILabel!;
    var quantity: UILabel!;
    var price: UILabel!;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        setup();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    private func setup(){
        name = UILabel();
        name.translatesAutoresizingMaskIntoConstraints = false;
        name.text = "This is the food name";
        name.font = UIFont(name: "Montserrat-Regular", size: 14);
        name.textColor = UIColor.black;
        name.adjustsFontSizeToFitWidth = true;
        name.numberOfLines = 1;
        name.minimumScaleFactor = 0.1;
        self.addSubview(name);
        //need x,y,width,height
        name.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true;
        name.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        name.widthAnchor.constraint(equalToConstant: 200).isActive = true;
        name.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true;
        
        //price
        price = UILabel();
        price.translatesAutoresizingMaskIntoConstraints = false;
        price.text = "$2.99";
        price.textColor = UIColor.red;
        price.font = UIFont(name: "Montserrat-Regular", size: 14);
        price.adjustsFontSizeToFitWidth = true;
        price.minimumScaleFactor = 0.1;
        price.numberOfLines = 1;
        self.addSubview(price);
        //need x,y,width, height
        price.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true;
        price.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        price.widthAnchor.constraint(equalToConstant: 50).isActive = true;
        price.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true;
        
        //quantity
        quantity = UILabel();
        quantity.translatesAutoresizingMaskIntoConstraints = false;
        quantity.text = "3 x";
        quantity.textColor = UIColor.black;
        quantity.font = UIFont(name: "Montserrat-Regular", size: 14);
        quantity.textAlignment = .left;
        quantity.adjustsFontSizeToFitWidth = true;
        quantity.numberOfLines = 1;
        quantity.minimumScaleFactor = 0.1;
        self.addSubview(quantity);
        //need x,y,width,height constraints
        quantity.leftAnchor.constraint(equalTo: name.rightAnchor).isActive = true;
        quantity.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        quantity.rightAnchor.constraint(equalTo: price.leftAnchor).isActive = true;
        quantity.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true;
        
        let border = UIView();
        border.translatesAutoresizingMaskIntoConstraints = false;
        border.backgroundColor = UIColor.gray;
        self.addSubview(border);
        //need x,y,width,height
        border.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        border.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        border.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true;
        border.heightAnchor.constraint(equalToConstant: 0.25).isActive = true;
        
    }
    
    func setName(name: String){
        self.name.text = name;
    }
    
    func setQuantity(quant: Int){
        self.quantity.text = "\(quant) x";
    }
    
    func setPrice(price: Double){
        let format = String(format: "%.2f", price);
        self.price.text = "$\(format)";
    }
}
