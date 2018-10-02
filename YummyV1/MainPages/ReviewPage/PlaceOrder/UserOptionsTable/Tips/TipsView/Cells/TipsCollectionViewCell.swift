//
//  TipsCollectionViewCell.swift
//  YummyV1
//
//  Created by Brandon In on 7/25/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit
protocol TipsCollectionViewCellDelegate{
    func handleSelectedTip(cellIndex: Int, percentage: Double);
}

class TipsCollectionViewCell: UICollectionViewCell{
//    var tipsCollectionView: TipsCollectionView?;
    
    var delegate: TipsCollectionViewCellDelegate?
    
    var tipButton: NormalUIButton = {
        let tipButton = NormalUIButton(backgroundColor: UIColor.white, title: "10%", font: UIFont.montserratSemiBold(fontSize: 14), fontColor: UIColor.black);
        tipButton.layer.borderWidth = 1;
        tipButton.layer.borderColor = UIColor.black.cgColor;
        return tipButton;
    }()
    
    var percentage: Double?;
    var cellIndex: Int?
    
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
    
    func setButtonTitle(percentage: Double){
        self.percentage = percentage;
        let percentageInt = Int(percentage);
        if(percentage != 0){
            self.tipButton.setTitle("\(percentageInt)%", for: .normal);
        }else{
            self.tipButton.setTitle("Other", for: .normal);
        }
    }
    
    @objc func buttonPressed(){
        
        if let cellIndex = self.cellIndex{
            var percent: Double = 0.0;
            if(percentage! == 10.0){
                percent = 0.1;
            }else if (percentage! == 15.0){
                percent = 0.15;
            }else if (percentage! == 20.0){
                percent = 0.2;
            }
            
            delegate?.handleSelectedTip(cellIndex: cellIndex, percentage: percent);
//            self.tipButton.backgroundColor = UIColor.appYellow;
        }
        
    }
    
    func selectButton(){
        self.tipButton.backgroundColor = UIColor.appYellow;
    }
    
    func unselectButton(){
        self.tipButton.backgroundColor = UIColor.white;
    }
    
    
}
