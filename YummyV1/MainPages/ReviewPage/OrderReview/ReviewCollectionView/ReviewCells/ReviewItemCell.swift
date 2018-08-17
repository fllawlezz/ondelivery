//
//  ItemCell.swift
//  YummyV1
//
//  Created by Brandon In on 7/25/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class ReviewItemCell: UICollectionViewCell{
    
    var itemNameLabel: NormalUILabel = {
        let itemNameLabel = NormalUILabel(textColor: UIColor.black, font: UIFont.montserratSemiBold(fontSize: 14), textAlign: .left);
        return itemNameLabel;
    }()
    
    var quantityLabel: NormalUILabel = {
        let quantityLabel = NormalUILabel(textColor: UIColor.black, font: UIFont.montserratBold(fontSize: 14), textAlign: .center);
        return quantityLabel;
    }()
    
    var itemTotalCostLabel: NormalUILabel = {
        let itemTotalCostLabel = NormalUILabel(textColor: UIColor.red, font: UIFont.montserratSemiBold(fontSize: 14), textAlign: .center);
        return itemTotalCostLabel;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        setupitemLabel();
        setupQuantityLabel();
        setupItemTotalCost();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupitemLabel(){
        self.addSubview(itemNameLabel);
        itemNameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true;
        itemNameLabel.rightAnchor.constraint(equalTo: self.centerXAnchor).isActive = true;
        itemNameLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        itemNameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
    }
    
    fileprivate func setupQuantityLabel(){
        self.addSubview(quantityLabel);
        quantityLabel.leftAnchor.constraint(equalTo: self.itemNameLabel.rightAnchor).isActive = true;
        quantityLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -100).isActive = true;
        quantityLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        quantityLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
//        quantityLabel.backgroundColor = .blue;
    }
    
    fileprivate func setupItemTotalCost(){
        self.addSubview(itemTotalCostLabel);
        itemTotalCostLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true;
        itemTotalCostLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        itemTotalCostLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        itemTotalCostLabel.widthAnchor.constraint(equalToConstant: 90).isActive = true;
//        itemTotalCostLabel.backgroundColor = .red;
    }
    
    func setItemData(itemName: String, itemQuantity: Int, itemTotalCost: Double){
        self.itemNameLabel.text = itemName;
        self.quantityLabel.text = "x\(itemQuantity)"
        self.itemTotalCostLabel.text = "$\(itemTotalCost)";
    }
    
}
