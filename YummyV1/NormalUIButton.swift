//
//  NormalUIButton.swift
//  YummyV1
//
//  Created by Brandon In on 7/1/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class NormalUIButton: UIButton{
    
    var selfBackgroundColor: UIColor!
    var titleString: String!
    var selfFont: UIFont!;
    var fontColor: UIColor!;
    
    init(backgroundColor: UIColor, title: String, font: UIFont, fontColor: UIColor){
        super.init(frame: .zero);
        self.selfBackgroundColor = backgroundColor;
        self.titleString = title;
        self.selfFont = font;
        self.fontColor = fontColor;
        setup();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setup(){
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.backgroundColor = selfBackgroundColor;
        self.setTitle(titleString, for: .normal);
        self.titleLabel?.font = selfFont;
        self.setTitleColor(fontColor, for: .normal);
        self.layer.cornerRadius = 4;
    }
    
}
