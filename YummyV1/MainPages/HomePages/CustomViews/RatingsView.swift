//
//  RatingsView.swift
//  YummyV1
//
//  Created by Brandon In on 6/29/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

//MARK: Ratings View
class RatingsViewImage: UIView{
    
    var ratingsLabel: UILabel!;
    var star1: UIImageView!;
    var star2: UIImageView!;
    var star3: UIImageView!;
    var star4: UIImageView!;
    var star5: UIImageView!;
    
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.setup();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    func setup(){
        
        ratingsLabel = UILabel();
        ratingsLabel.translatesAutoresizingMaskIntoConstraints = false;
        ratingsLabel.text = "Rating:";
        ratingsLabel.font = UIFont.systemFont(ofSize: 14);
        ratingsLabel.textColor = UIColor.gray;
        ratingsLabel.adjustsFontSizeToFitWidth = true;
        ratingsLabel.numberOfLines = 1;
        //        ratingsLabel.backgroundColor = UIColor.red;
        ratingsLabel.minimumScaleFactor = 0.1;
        self.addSubview(ratingsLabel);
        //x,y,width,height
        ratingsLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        ratingsLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        if(UIScreenHeight != 568){
            ratingsLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true;
            ratingsLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true;
        }else{
            ratingsLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true;
            ratingsLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true;
        }
        
        star1 = UIImageView();
        star1.translatesAutoresizingMaskIntoConstraints = false;
        star1.image = UIImage(named: "starFull");
        self.addSubview(star1);
        //need x,y,width,height
        star1.leftAnchor.constraint(equalTo: ratingsLabel.rightAnchor, constant:5).isActive = true;
        star1.centerYAnchor.constraint(equalTo: ratingsLabel.centerYAnchor).isActive = true;
        if(UIScreenHeight != 568){
            star1.widthAnchor.constraint(equalToConstant: 20).isActive = true;
            star1.heightAnchor.constraint(equalToConstant: 20).isActive = true;
        }else{
            star1.widthAnchor.constraint(equalToConstant: 16).isActive = true;
            star1.heightAnchor.constraint(equalToConstant: 16).isActive = true;
        }
        
        star2 = UIImageView();
        star2.translatesAutoresizingMaskIntoConstraints = false;
        star2.image = UIImage(named: "starFull");
        self.addSubview(star2);
        star2.leftAnchor.constraint(equalTo: star1.rightAnchor).isActive = true;
        star2.centerYAnchor.constraint(equalTo: star1.centerYAnchor).isActive = true;
        if(UIScreenHeight != 568){
            star2.widthAnchor.constraint(equalToConstant: 20).isActive = true;
            star2.heightAnchor.constraint(equalToConstant: 20).isActive = true;
        }else{
            star2.widthAnchor.constraint(equalToConstant: 16).isActive = true;
            star2.heightAnchor.constraint(equalToConstant: 16).isActive = true;
        }
        
        star3 = UIImageView();
        star3.translatesAutoresizingMaskIntoConstraints = false;
        star3.image = UIImage(named: "starFull");
        self.addSubview(star3);
        star3.leftAnchor.constraint(equalTo: star2.rightAnchor).isActive = true;
        star3.centerYAnchor.constraint(equalTo: star2.centerYAnchor).isActive = true;
        if(UIScreenHeight != 568){
            star3.widthAnchor.constraint(equalToConstant: 20).isActive = true;
            star3.heightAnchor.constraint(equalToConstant: 20).isActive = true;
        }else{
            star3.widthAnchor.constraint(equalToConstant: 16).isActive = true;
            star3.heightAnchor.constraint(equalToConstant: 16).isActive = true;
        }
        
        star4 = UIImageView();
        star4.translatesAutoresizingMaskIntoConstraints = false;
        star4.image = UIImage(named: "star");
        self.addSubview(star4);
        star4.leftAnchor.constraint(equalTo: star3.rightAnchor).isActive = true;
        star4.centerYAnchor.constraint(equalTo: star3.centerYAnchor).isActive = true;
        if(UIScreenHeight != 568){
            star4.widthAnchor.constraint(equalToConstant: 20).isActive = true;
            star4.heightAnchor.constraint(equalToConstant: 20).isActive = true;
        }else{
            star4.widthAnchor.constraint(equalToConstant: 16).isActive = true;
            star4.heightAnchor.constraint(equalToConstant: 16).isActive = true;
        }
        
        star5 = UIImageView();
        star5.translatesAutoresizingMaskIntoConstraints = false;
        star5.image = UIImage(named: "star");
        self.addSubview(star5);
        star5.leftAnchor.constraint(equalTo: star4.rightAnchor).isActive = true;
        star5.centerYAnchor.constraint(equalTo: star4.centerYAnchor).isActive = true;
        if(UIScreenHeight != 568){
            star5.widthAnchor.constraint(equalToConstant: 20).isActive = true;
            star5.heightAnchor.constraint(equalToConstant: 20).isActive = true;
        }else{
            star5.widthAnchor.constraint(equalToConstant: 16).isActive = true;
            star5.heightAnchor.constraint(equalToConstant: 16).isActive = true;
        }
        
    }
    
    //MARK: Star Images
}
