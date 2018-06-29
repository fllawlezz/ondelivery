//
//  FontExtensions.swift
//  YummyV1
//
//  Created by Brandon In on 6/19/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

extension UIFont{
    class func montserratRegular(fontSize: CGFloat)-> UIFont{
        let font = UIFont(name: "Montserrat-Regular", size: fontSize)!;
        return font;
    }
    
    class func montserratBold(fontSize: CGFloat)-> UIFont{
        let font = UIFont(name: "Montserrat-Bold", size: fontSize)!;
        return font;
    }
    
    class func montserratSemiBold(fontSize: CGFloat)-> UIFont{
        let font = UIFont(name: "Montserrat-SemiBold", size: fontSize)!;
        return font;
    }
}
