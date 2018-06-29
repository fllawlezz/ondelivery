//
//  SectionTitlesCell.swift
//  YummyV1
//
//  Created by Brandon In on 6/19/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class SectionTitlesCell: UICollectionViewCell{
    //UIElements
    lazy var sectionTitle: UILabel = {
        let sectionTitle = UILabel();
        sectionTitle.translatesAutoresizingMaskIntoConstraints = false;
        sectionTitle.text = "Section Title goes here";
        sectionTitle.font = UIFont.montserratRegular(fontSize: 14);
        sectionTitle.adjustsFontSizeToFitWidth = true;
        sectionTitle.minimumScaleFactor = 0.1;
        sectionTitle.numberOfLines = 1;
        sectionTitle.textColor = UIColor.white;
        sectionTitle.textAlignment = .center;
        return sectionTitle;
    }()
    
    
    //DATA elements
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.black;
        
        self.addSubview(sectionTitle);
        sectionTitle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true;
        sectionTitle.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true;
        sectionTitle.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        sectionTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    func setSectionTitle(sectionTitle: String!){
        self.sectionTitle.text = sectionTitle;
    }
    
}
