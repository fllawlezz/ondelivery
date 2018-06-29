//
//  NoRestaurantCell.swift
//  YummyV1
//
//  Created by Brandon In on 4/4/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class NoRestaurantsCell: UICollectionViewCell{
    //elements
    var centerTitle: UILabel!;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        //load center Title
        centerTitle = UILabel();
        centerTitle.translatesAutoresizingMaskIntoConstraints = false;
        centerTitle.text = "No restaurants around you";
        centerTitle.font = UIFont(name: "Montserrat-Regular", size: 16);
        centerTitle.textColor = UIColor.black;
        centerTitle.textAlignment = .center;
        self.addSubview(centerTitle);
        centerTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true;
        centerTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        centerTitle.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true;
        centerTitle.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
}
