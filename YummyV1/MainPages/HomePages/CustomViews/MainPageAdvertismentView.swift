//
//  MainPageView.swift
//  YummyV1
//
//  Created by Brandon In on 6/29/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

//MARK: Main Page ScrollView Views
class MainPageAdvertismentView: UIView{
    var imageView: UIImageView!;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        setup();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    func setup(){
        let imageViewFrame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height);
        imageView = UIImageView(frame: imageViewFrame);
        self.addSubview(imageView);
    }
    
    func setImage(name: String){
        self.imageView.image = UIImage(named: name);
    }
    
}
