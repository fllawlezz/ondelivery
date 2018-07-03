//
//  SpecialOptionsHeader.swift
//  YummyV1
//
//  Created by Brandon In on 7/2/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import Foundation
import UIKit

class SpecialOptionsHeader: UICollectionReusableView{
    
    var specialOptionTitle: NormalUILabel = {
        let specialOptionTitle = NormalUILabel(textColor: UIColor.black, font: UIFont.montserratBold(fontSize: 16), textAlign: .left);
        return specialOptionTitle;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        self.backgroundColor = UIColor.white;
        
        self.addSubview(specialOptionTitle);
        specialOptionTitle.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 10).isActive = true;
        specialOptionTitle.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true;
        specialOptionTitle.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        specialOptionTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    func setTitle(title: String){
        self.specialOptionTitle.text = title;
    }
    
}
