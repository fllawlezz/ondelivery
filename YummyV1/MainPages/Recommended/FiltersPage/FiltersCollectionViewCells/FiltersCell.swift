//
//  FiltersCell.swift
//  YummyV1
//
//  Created by Brandon In on 6/28/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import Foundation
import UIKit

class FiltersCell: UICollectionViewCell{
    
    var titleString: UILabel = {
        let titleString = UILabel();
        titleString.translatesAutoresizingMaskIntoConstraints = false;
        titleString.text = "Title goes here";
        titleString.font = UIFont.montserratSemiBold(fontSize: 14);
        titleString.textColor = UIColor.black;
        titleString.numberOfLines = 1;
        titleString.minimumScaleFactor = 0.1;
        titleString.adjustsFontSizeToFitWidth = true;
        titleString.textAlignment = .left;
        return titleString;
    }()
    
    var checkmarkView: UIImageView = {
        let checkmarkView = UIImageView();
        checkmarkView.translatesAutoresizingMaskIntoConstraints = false;
        checkmarkView.image = #imageLiteral(resourceName: "greenCheckMark");
        return checkmarkView;
    }()
    
    var bottomBorder: UIView = {
        let bottomBorder = UIView();
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false;
        bottomBorder.backgroundColor = UIColor.lightGray;
        bottomBorder.alpha = 0.7;
        return bottomBorder;
    }()
    
    var cellValue: Int?
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        setup();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setup(){
        self.backgroundColor = UIColor.white;
        
        self.addSubview(titleString);
        titleString.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true;
        titleString.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -60).isActive = true;
        titleString.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        titleString.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        
        self.addSubview(checkmarkView);
        checkmarkView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true;
        checkmarkView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        checkmarkView.widthAnchor.constraint(equalToConstant: 25).isActive = true;
        checkmarkView.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        
        self.addSubview(bottomBorder);
        bottomBorder.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true;
        bottomBorder.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true;
        bottomBorder.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        bottomBorder.heightAnchor.constraint(equalToConstant: 0.5).isActive = true;
        
        checkmarkView.isHidden = true;
    }
    
    func setTitle(title: String, cellValue: Int){
        self.titleString.text = title;
        self.cellValue = cellValue;
    }
    
    func hideBottomBorder(){
        self.bottomBorder.isHidden = true;
    }
    
    func unhideCheckmark(){
        self.titleString.textColor = UIColor(red: 49/255, green: 175/255, blue: 145/255, alpha: 1);
        self.checkmarkView.isHidden = false;
    }
    
    func hideCheckmark(){
        self.titleString.textColor = UIColor.black;
        self.checkmarkView.isHidden = true;
    }
    
}
