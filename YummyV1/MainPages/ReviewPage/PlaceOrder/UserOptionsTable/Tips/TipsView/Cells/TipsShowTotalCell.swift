//
//  TipsShowTotalCell.swift
//  YummyV1
//
//  Created by Brandon In on 7/25/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class TipsShowTotalCell: UICollectionViewCell{
    
    lazy var tipTotalLabel: NormalUILabel = {
        let tipTotalLabel = NormalUILabel(textColor: UIColor.black, font: UIFont.montserratRegular(fontSize: 14), textAlign: .right);
        return tipTotalLabel;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
//        self.backgroundColor = UIColor.red;
        self.backgroundColor = UIColor.white;
        setupTipTotalLabel();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupTipTotalLabel(){
        self.addSubview(tipTotalLabel);
        tipTotalLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        tipTotalLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true;
        tipTotalLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        tipTotalLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        
        self.tipTotalLabel.text = "Tip: $4.99";
    }
    
    func setTipTotal(tipTotal: Double){
        let tipTotalString = String(format: "%.2f", tipTotal);
        self.tipTotalLabel.text = "Tip: $\(tipTotalString)";
        
    }
    
    
    
}
