//
//  SpecialOptionsCell.swift
//  YummyV1
//
//  Created by Brandon In on 7/1/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class SpecialOptionsCell: UICollectionViewCell{
    //Data Variables
    var foodName: String?
    var foodPrice: Double?
    var cellSelected: Bool = false;
    
    fileprivate var foodNameLabel: NormalUILabel = {
        let foodName = NormalUILabel(textColor: UIColor.black, font: UIFont.montserratRegular(fontSize: 14), textAlign: .left);
        return foodName;
    }()
    
    fileprivate var foodPriceLabel: NormalUILabel = {
        let foodPrice = NormalUILabel(textColor: UIColor.red, font: UIFont.montserratRegular(fontSize: 14), textAlign: .left);
        return foodPrice;
    }()
    
    fileprivate var checkmarkView: UIImageView = {
        let checkmarkView = UIImageView();
        checkmarkView.translatesAutoresizingMaskIntoConstraints = false;
        checkmarkView.image = #imageLiteral(resourceName: "greenCheckMark");
        return checkmarkView;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        setup();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setup(){
        self.addSubview(foodNameLabel);
        foodNameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true;
//        foodName.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30).isActive = true;
        foodNameLabel.rightAnchor.constraint(equalTo: self.centerXAnchor).isActive = true;
        foodNameLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        foodNameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        
        self.addSubview(foodPriceLabel);
        foodPriceLabel.leftAnchor.constraint(equalTo: foodNameLabel.rightAnchor).isActive = true;
        foodPriceLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -35).isActive = true;
        foodPriceLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        foodPriceLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true;
//        foodPrice.backgroundColor = UIColor.red;
        
        self.addSubview(checkmarkView);
        checkmarkView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true;
        checkmarkView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        checkmarkView.widthAnchor.constraint(equalToConstant: 25).isActive = true;
        checkmarkView.heightAnchor.constraint(equalToConstant: 25).isActive = true;
    }
    
    func setTitle(title: String){
        self.foodNameLabel.text = title;
        self.foodName = title;
    }
    
    func unhideCheckmark(){
        self.foodNameLabel.textColor = UIColor(red: 49/255, green: 175/255, blue: 145/255, alpha: 1);
        self.checkmarkView.isHidden = false;
        self.cellSelected = true;
    }
    
    func hideCheckmark(){
        self.foodNameLabel.textColor = UIColor.black;
        self.checkmarkView.isHidden = true;
        self.cellSelected = false;
    }
    
    func setPrice(price: Double){
        self.foodPrice = price;
        if(price > 0){
            let format = String(format:"%.2f",price);
            self.foodPriceLabel.text = "+$\(format)"
        }else{
            self.foodPriceLabel.text = "";
        }
    }
    
}
