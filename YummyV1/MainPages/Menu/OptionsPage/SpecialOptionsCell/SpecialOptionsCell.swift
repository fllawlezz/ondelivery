//
//  SpecialOptionsCell.swift
//  YummyV1
//
//  Created by Brandon In on 7/1/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit


class SpecialOptionsCell: UICollectionViewCell{
    
    fileprivate var foodName: NormalUILabel = {
        let foodName = NormalUILabel(textColor: UIColor.black, font: UIFont.montserratRegular(fontSize: 14), textAlign: .left);
        return foodName;
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
        self.addSubview(foodName);
        foodName.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true;
        foodName.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30).isActive = true;
        foodName.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        foodName.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        
        self.addSubview(checkmarkView);
        checkmarkView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true;
        checkmarkView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        checkmarkView.widthAnchor.constraint(equalToConstant: 25).isActive = true;
        checkmarkView.heightAnchor.constraint(equalToConstant: 25).isActive = true;
    }
    
    func setTitle(title: String){
        self.foodName.text = title;
    }
    
    func unhideCheckmark(){
        self.foodName.textColor = UIColor(red: 49/255, green: 175/255, blue: 145/255, alpha: 1);
        self.checkmarkView.isHidden = false;
    }
    
    func hideCheckmark(){
        self.foodName.textColor = UIColor.black;
        self.checkmarkView.isHidden = true;
    }
    
}
