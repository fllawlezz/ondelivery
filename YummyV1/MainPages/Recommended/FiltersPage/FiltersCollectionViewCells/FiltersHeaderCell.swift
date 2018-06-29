//
//  FiltersHeaderCell.swift
//  YummyV1
//
//  Created by Brandon In on 6/28/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import Foundation
import UIKit

class FiltersHeaderCell: UICollectionReusableView{
    
    var titleString: UILabel = {
        let titleString = UILabel();
        titleString.translatesAutoresizingMaskIntoConstraints = false;
        titleString.text = "Title goes here";
        titleString.font = UIFont.montserratBold(fontSize: 16);
        titleString.textColor = UIColor.black;
        titleString.numberOfLines = 1;
        titleString.minimumScaleFactor = 0.1;
        titleString.adjustsFontSizeToFitWidth = true;
        titleString.textAlignment = .left;
        return titleString;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        setup();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    private func setup(){
        self.backgroundColor = UIColor.white;
        
        self.addSubview(titleString);
        titleString.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true;
        titleString.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true;
        titleString.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        titleString.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
    }
    
    func setTitle(title: String){
        self.titleString.text = title;
    }
    
    func selectedItem(){
        self.titleString.textColor = UIColor.red;
    }
    
    func deselectedItem(){
        self.titleString.textColor = UIColor.black;
    }
    
}
