//
//  TipsCollectionViewCell.swift
//  YummyV1
//
//  Created by Brandon In on 7/25/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class TipsCollectionViewCell: UICollectionViewCell{
    var tipsCollectionView: TipsCollectionView?;
    
    var tipButton: NormalUIButton = {
        let tipButton = NormalUIButton(backgroundColor: UIColor.white, title: "10%", font: UIFont.montserratSemiBold(fontSize: 14), fontColor: UIColor.black);
        tipButton.layer.borderWidth = 1;
        tipButton.layer.borderColor = UIColor.black.cgColor;
        return tipButton;
    }()
    
    var percentage: String?;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        setupTipButton();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupTipButton(){
        self.addSubview(tipButton);
        tipButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true;
        tipButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true;
        tipButton.topAnchor.constraint(equalTo: self.topAnchor ,constant: 5).isActive = true;
        tipButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true;
        tipButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside);
    }
    
    func setButtonTitle(percentage: String){
        self.percentage = percentage;
        if(percentage != "Other"){
            self.tipButton.setTitle("\(percentage)%", for: .normal);
        }else{
            self.tipButton.setTitle(percentage, for: .normal);
        }
    }
    
    @objc func buttonPressed(){
        self.tipButton.backgroundColor = UIColor.appYellow;
    }
    
    func unselectButton(){
        self.tipButton.backgroundColor = UIColor.white;
    }
    
    
}
