//
//  PopUpMenuCell.swift
//  YummyV1
//
//  Created by Brandon In on 3/28/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

//MARK: PopUpMenuCell
class PopUpMenuCell: UICollectionViewCell{
    
    //variables
    var foodName: UILabel!;
    var foodPrice: UILabel!;
    var addButton: UIButton!;
    var minusButton: UIButton!;
    var quantity: UILabel!;
    var border: UIView!;
    override init(frame: CGRect) {
        super.init(frame: frame);
        //        self.backgroundColor = UIColor.blue
        setup();
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    
    private func setup(){
        //food name
        foodName = UILabel();
        foodName.text = "Food's name";
        foodName.font = UIFont(name: "Montserrat-Regular", size: 16);
        foodName.translatesAutoresizingMaskIntoConstraints = false;
        self.addSubview(foodName);
        //need x,y,width,and height
        foodName.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true;
        foodName.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        foodName.widthAnchor.constraint(equalToConstant: 200).isActive = true;
        foodName.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        //        foodName.backgroundColor = UIColor.red;
        foodName.backgroundColor = UIColor.white;
        
        //add button
        addButton = UIButton(type: .system);
        //        addButton.frame = CGRect(x: 370, y: 60, width: 35, height: 35);
        addButton.setTitle("+", for: .normal);
        addButton.setTitleColor(UIColor.black, for: .normal);
        addButton.titleLabel?.textColor = UIColor.black;
        addButton.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 22);
        addButton.translatesAutoresizingMaskIntoConstraints = false;
        self.addSubview(addButton);
        //need x,y,width,height
        addButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true;
        addButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        addButton.widthAnchor.constraint(equalToConstant: 35).isActive = true;
        addButton.heightAnchor.constraint(equalToConstant: 35).isActive = true;
        addButton.layer.cornerRadius = 17.5;
        addButton.backgroundColor = UIColor.appYellow;
        
        //quanityt
        quantity = UILabel();
        quantity.text = "99";
        quantity.backgroundColor = UIColor.white;
        quantity.textAlignment = .center;
        quantity.translatesAutoresizingMaskIntoConstraints = false;
        self.addSubview(quantity);
        //need x,y,width,height
        quantity.rightAnchor.constraint(equalTo: addButton.leftAnchor, constant: -5).isActive = true;
        quantity.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        quantity.widthAnchor.constraint(equalToConstant: 30).isActive = true;
        quantity.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        
        //minus button
        minusButton = UIButton(type: .system);
        minusButton.setTitle("-", for: .normal);
        minusButton.setTitleColor(UIColor.black, for: .normal);
        minusButton.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 22);
        minusButton.layer.cornerRadius = 17.5;
        minusButton.backgroundColor = UIColor.lightGray;
        minusButton.translatesAutoresizingMaskIntoConstraints = false;
        self.addSubview(minusButton);
        //need x,y,width,height
        minusButton.rightAnchor.constraint(equalTo: quantity.leftAnchor, constant: -5).isActive = true;
        minusButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        minusButton.widthAnchor.constraint(equalToConstant: 35).isActive = true;
        minusButton.heightAnchor.constraint(equalToConstant: 35).isActive = true;
        
        //Border
        border = UIView();
        border.translatesAutoresizingMaskIntoConstraints = false;
        border.backgroundColor = UIColor.lightGray;
        self.addSubview(border);
        //need x,y,width,and height
        border.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        border.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        border.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true;
        border.heightAnchor.constraint(equalToConstant: 0.25).isActive = true;
        
    }
    
    
    
    func setName(name: String){
        foodName.text = name;
    }
    func setQuantity(quantity: Int){
        self.quantity.text = String(quantity);
    }
    
}
