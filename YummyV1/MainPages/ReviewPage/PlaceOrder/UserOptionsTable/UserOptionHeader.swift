//
//  UserOptionHeader.swift
//  YummyV1
//
//  Created by Brandon In on 7/25/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class UserOptionHeader: UICollectionReusableView{
    
    lazy var sectionTitle: NormalUILabel = {
        let sectionTitle = NormalUILabel(textColor: UIColor.black, font: UIFont.montserratBold(fontSize: 18), textAlign: .left);
        return sectionTitle;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        setupSectionTitle();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupSectionTitle(){
        self.addSubview(sectionTitle);
        sectionTitle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true;
        sectionTitle.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        sectionTitle.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        sectionTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
    }
    
    func setSectionTitle(titleString: String){
        sectionTitle.text = titleString;
    }
    
}
