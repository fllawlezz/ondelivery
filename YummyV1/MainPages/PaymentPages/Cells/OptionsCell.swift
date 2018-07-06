//
//  OptionsCell.swift
//  YummyV1
//
//  Created by Brandon In on 7/5/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class OptionsCell: UITableViewCell{
    
    var title: UILabel!
    var userText: UILabel!;
    var titleImage: UIImageView!;
    var arrow: UILabel!;
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        setup();
    }
    
    private func setup(){
        arrow = UILabel();
        arrow.translatesAutoresizingMaskIntoConstraints = false;
        arrow.text = ">";
        arrow.textColor = UIColor.black;
        arrow.font = UIFont(name: "Montserrat-Regular", size: 16);
        arrow.textAlignment = .right;
        self.addSubview(arrow);
        //need x,y,width,height
        arrow.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true;
        arrow.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        arrow.widthAnchor.constraint(equalToConstant: 50).isActive = true;
        arrow.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true;
        
        titleImage = UIImageView();
        titleImage.translatesAutoresizingMaskIntoConstraints = false;
        self.addSubview(titleImage);
        //need x,y,width,height
        titleImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true;
        titleImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        titleImage.widthAnchor.constraint(equalToConstant: 20).isActive = true;
        titleImage.heightAnchor.constraint(equalToConstant: 20).isActive = true;
        
        title = UILabel();
        title.translatesAutoresizingMaskIntoConstraints = false;
        title.text = "This is where the option goes";
        title.textColor = UIColor.black;
        title.font = UIFont(name: "Montserrat-Regular", size: 14);
        self.addSubview(title);
        title.leftAnchor.constraint(equalTo: titleImage.rightAnchor, constant: 5).isActive = true;
        title.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        title.widthAnchor.constraint(equalToConstant: 150).isActive = true;
        title.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true;
        
        userText = UILabel();
        userText.translatesAutoresizingMaskIntoConstraints = false;
        userText.font = UIFont(name: "Montserrat-Regular", size: 12);
        userText.textColor = UIColor.gray;
        userText.adjustsFontSizeToFitWidth = true;
        userText.numberOfLines = 1;
        userText.minimumScaleFactor = 0.1;
        userText.textAlignment = .center;
        userText.text = "";
        self.addSubview(userText);
        //need x,y,width,height
        userText.leftAnchor.constraint(equalTo: title.rightAnchor, constant: 5).isActive = true;
        userText.rightAnchor.constraint(equalTo: arrow.leftAnchor).isActive = true;
        userText.centerYAnchor.constraint(equalTo: title.centerYAnchor).isActive = true;
        userText.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true;
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    func setTitle(name: String){
        self.title.text = name;
    }
    
    func setImage(url: String){
        self.titleImage.image = UIImage(named: url);
    }
    
    func setUserText(text: String){
        self.userText.text = text;
    }
}
