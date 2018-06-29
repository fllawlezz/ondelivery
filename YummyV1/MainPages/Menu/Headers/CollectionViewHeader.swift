//
//  CollectionViewHeader.swift
//  YummyV1
//
//  Created by Brandon In on 6/29/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class CollectionViewHeader: UICollectionReusableView{
    //just a UIlabel on the left side
    var headerLabel: UILabel!;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        setup();
    }
    
    private func setup(){
        headerLabel = UILabel();
        headerLabel.translatesAutoresizingMaskIntoConstraints = false;
        headerLabel.text = "This is Text";
        headerLabel.font = UIFont(name: "Montserrat-Regular", size: 14);
        headerLabel.textAlignment = .left;
        headerLabel.textColor = UIColor.black;
        self.addSubview(headerLabel);
        //need x,y,width,height
        headerLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true;
        headerLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        headerLabel.widthAnchor.constraint(equalToConstant: 350).isActive = true;
        headerLabel.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    func setTitle(string: String!){
        self.headerLabel.text = string;
    }
}
