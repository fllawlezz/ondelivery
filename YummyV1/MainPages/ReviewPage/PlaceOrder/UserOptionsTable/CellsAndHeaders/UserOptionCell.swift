//
//  UserOptionCell.swift
//  YummyV1
//
//  Created by Brandon In on 7/24/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class UserOptionCell: UICollectionViewCell{
    
    var optionTitle: NormalUILabel = {
        let optionTitle = NormalUILabel(textColor: UIColor.black, font: UIFont.montserratRegular(fontSize: 12), textAlign: .left);
        return optionTitle;
    }()
    
    var optionImage: UIImageView = {
        let optionImage = UIImageView();
        optionImage.translatesAutoresizingMaskIntoConstraints = false;
        return optionImage;
    }()
    
    var optionSelection: NormalUILabel = {
        let optionSelection = NormalUILabel(textColor: UIColor.gray, font: UIFont.montserratRegular(fontSize: 12), textAlign: .center);
        return optionSelection;
    }()
    
    var rightArrowImage: UIImageView = {
        let rightArrowIamge = UIImageView();
        rightArrowIamge.translatesAutoresizingMaskIntoConstraints = false;
        rightArrowIamge.image = #imageLiteral(resourceName: "arrowToRight");
        return rightArrowIamge;
    }()
    
    var bottomBorder: UIView = {
        let bottomBorder = UIView();
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false;
        bottomBorder.backgroundColor = UIColor.gray;
        return bottomBorder;
    }()
    
    var optionTitleString: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        setup();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setup(){
        self.addSubview(optionImage);
        optionImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true;
//        optionImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true;
        optionImage.heightAnchor.constraint(equalToConstant: 18).isActive = true;
        optionImage.widthAnchor.constraint(equalToConstant: 18).isActive = true;
        optionImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        
        self.addSubview(optionTitle);
        optionTitle.leftAnchor.constraint(equalTo: optionImage.rightAnchor, constant: 10).isActive = true;
        optionTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true;
        optionTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true;
        optionTitle.widthAnchor.constraint(equalToConstant: 100).isActive = true;
        
        self.addSubview(optionSelection);
        optionSelection.leftAnchor.constraint(equalTo: self.optionTitle.rightAnchor,constant: 5).isActive = true;
        optionSelection.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true;
        optionSelection.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        optionSelection.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        
        self.addSubview(rightArrowImage);
        rightArrowImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true;
        rightArrowImage.leftAnchor.constraint(equalTo: self.optionSelection.rightAnchor, constant: -5).isActive = true;
        rightArrowImage.heightAnchor.constraint(equalToConstant: 20).isActive = true;
        rightArrowImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;

        
        self.addSubview(bottomBorder);
        bottomBorder.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        bottomBorder.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 25).isActive = true;
        bottomBorder.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        bottomBorder.heightAnchor.constraint(equalToConstant: 0.5).isActive = true;
        
    }
    
    func setOptionTitle(optionTitle: String){
        self.optionTitle.text = optionTitle;
        self.optionTitleString = optionTitle;
    }
    
    func setOptionImage(optionImageName: String){
        self.optionImage.image = UIImage(named: optionImageName);
    }
    
    func setOption(option: String){
        self.optionSelection.text = option;
    }
    
}
