//
//  PriceCollectionViewCell.swift
//  YummyV1
//
//  Created by Brandon In on 6/28/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class PriceCollectionViewCell: UICollectionViewCell{
    
    var filtersSectionTwo: FiltersSectionTwoCell?
    
    var priceButton: UIButton = {
        let priceButton = UIButton(type: .system);
        priceButton.translatesAutoresizingMaskIntoConstraints = false;
        priceButton.backgroundColor = UIColor.white;
        priceButton.setTitle("$", for: .normal);
        priceButton.titleLabel?.font = UIFont.montserratSemiBold(fontSize: 14);
        priceButton.setTitleColor(UIColor.black, for: .normal);
        priceButton.layer.cornerRadius = 4;
        priceButton.layer.borderColor = UIColor.appYellow.cgColor;
        priceButton.layer.borderWidth = 2;
        return priceButton;
    }()
    
    var priceSelected = false;
    var cellPrice: Int?
    var cellPriceArrayIndex: Int?
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        setup();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setup(){
        self.addSubview(priceButton);
        priceButton.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        priceButton.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        priceButton.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        priceButton.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        
        priceButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside);
    }
    
    func setPriceTitle(price: String, cellPrice: Int){
        self.priceButton.setTitle(price, for: .normal);
        self.cellPrice = cellPrice;
    }
    
    @objc func buttonPressed(){
        if(priceSelected){
            deselected();
        }else{
            selected();
        }
    }
    
    func selected(){
        self.priceButton.backgroundColor = UIColor.appYellow;
        self.priceSelected = true;
        
        let index = filtersSectionTwo?.pricesArray.count;
        self.cellPriceArrayIndex = index;
        filtersSectionTwo?.pricesArray.append(self.cellPrice!);
        
    }
    
    func deselected(){
        self.priceButton.backgroundColor = UIColor.white;
        self.priceSelected = false;
        
        filtersSectionTwo?.pricesArray.remove(at: cellPriceArrayIndex!);
    }
    
}
