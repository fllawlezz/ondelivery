//
//  NormalUILabel.swift
//  YummyV1
//
//  Created by Brandon In on 7/1/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class NormalUILabel: UILabel{
    
    var fontColor: UIColor?
    var selfFont: UIFont?
    var textAlign: NSTextAlignment?
    
    init(textColor: UIColor, font: UIFont, textAlign: NSTextAlignment){
        super.init(frame: .zero);
        self.fontColor = textColor;
        self.selfFont = font;
        self.textAlign = textAlign;
        setup();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    private func setup(){
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.font = selfFont!;
        self.textColor = fontColor!;
        self.textAlignment = self.textAlign!;
        self.adjustsFontSizeToFitWidth = true;
        self.minimumScaleFactor = 0.1;
        self.numberOfLines = 1;
    }
    
    
}
