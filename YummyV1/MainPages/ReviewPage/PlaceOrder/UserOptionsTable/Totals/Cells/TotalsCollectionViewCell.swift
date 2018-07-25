//
//  TotalsCollectionViewCell.swift
//  YummyV1
//
//  Created by Brandon In on 7/25/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class TotalsCollectionViewCell: UICollectionViewCell{
    
    lazy var totalDescriptionLabel: NormalUILabel = {
        let totalDescriptionLabel = NormalUILabel(textColor: UIColor.black, font: UIFont.montserratSemiBold(fontSize: 14), textAlign: .right);
        return totalDescriptionLabel;
    }()
    
    lazy var actualTotalLabel: NormalUILabel = {
        let actualTotalLabel = NormalUILabel(textColor: UIColor.red, font: UIFont.montserratRegular(fontSize: 14), textAlign: .right);
        return actualTotalLabel;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        setup();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setup(){
        self.addSubview(totalDescriptionLabel);
        totalDescriptionLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true;
        totalDescriptionLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -50).isActive = true;
        totalDescriptionLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true;
        totalDescriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true;
        
        self.addSubview(actualTotalLabel);
        actualTotalLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true;
        actualTotalLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true;
        actualTotalLabel.leftAnchor.constraint(equalTo: self.totalDescriptionLabel.rightAnchor, constant: 5).isActive = true;
        actualTotalLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true;
    }
    
    func setDescription(description: String){
        self.totalDescriptionLabel.text = "\(description):";
    }
    
    func setTotal(total: Double){
        let totalFormat = String(format: "%.2f", total);
        self.actualTotalLabel.text = "$\(totalFormat)"
    }
    
}
