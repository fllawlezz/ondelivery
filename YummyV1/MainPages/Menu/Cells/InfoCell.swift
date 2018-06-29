//
//  InfoCell.swift
//  YummyV1
//
//  Created by Brandon In on 3/28/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

//MARK: InfoCell
class InfoCell: UICollectionViewCell{
    var title: UILabel!;
    var phoneImage: UIImageView!;
    var makeCallClosure: (()->())?
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        setup();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    private func setup(){
        //Label
        title = UILabel();
        title.translatesAutoresizingMaskIntoConstraints = false;
        title.text = "This is where the title goes";
        title.font = UIFont(name: "Montserrat-Regular", size: 14);
        title.textColor = UIColor.gray;
        self.addSubview(title);
        //need x,y,width,and height
        title.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true;
        title.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true;
        title.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true;
        title.heightAnchor.constraint(equalToConstant: 30).isActive = true;
        
        //imageView
        phoneImage = UIImageView();
        phoneImage.translatesAutoresizingMaskIntoConstraints = false;
        phoneImage.image = UIImage(named: "phone");
        self.addSubview(phoneImage);
        phoneImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true;
        phoneImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        phoneImage.widthAnchor.constraint(equalToConstant: 20).isActive = true;
        phoneImage.heightAnchor.constraint(equalToConstant: 20).isActive = true;
        phoneImage.isUserInteractionEnabled = true;
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.makeCall));
        phoneImage.addGestureRecognizer(gesture);
        
        //botom border
        let border = UIView();
        border.backgroundColor = UIColor.lightGray;
        border.translatesAutoresizingMaskIntoConstraints = false;
        self.addSubview(border);
        //need x,y,width,and height
        border.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        border.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        border.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true;
        border.heightAnchor.constraint(equalToConstant: 0.25).isActive = true;
        
    }
    
    func setTitle(text: String){
        self.title.text = text;
    }
    
    @objc func makeCall(){
        self.makeCallClosure?()
    }
}

