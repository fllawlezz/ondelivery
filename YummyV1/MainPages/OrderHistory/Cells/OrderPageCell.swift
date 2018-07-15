//
//  OrderPageCell.swift
//  YummyV1
//
//  Created by Brandon In on 7/14/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class OrderPageCell: UICollectionViewCell{
    
    var restTitle: UILabel!;
    var restImage: UIImageView!;
    var price: UILabel!;
    var date: UILabel!;
    var expand: UIButton!;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        setup();
        self.backgroundColor = UIColor.white;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    private func setup(){
        
        restTitle = UILabel();
        restTitle.text = "Restaurant name here"
        restTitle.font = UIFont(name: "Montserrat-SemiBold", size: 16);
        restTitle.translatesAutoresizingMaskIntoConstraints = false;
        self.addSubview(restTitle);
        //need x,y,width,height constraints
        restTitle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true;
        restTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true;
        restTitle.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true;
        restTitle.heightAnchor.constraint(equalToConstant: 30).isActive = true;
        
        
        let border2 = UIView();
        border2.frame = CGRect(x: 0, y: 40, width: self.frame.width, height: 0.5);
        border2.backgroundColor = UIColor.lightGray;
        self.addSubview(border2);
        
        restImage = UIImageView();
        restImage.backgroundColor = UIColor.red;
        restImage.translatesAutoresizingMaskIntoConstraints = false;
        self.addSubview(restImage);
        restImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true;
        restImage.topAnchor.constraint(equalTo: border2.bottomAnchor, constant: 5).isActive = true;
        restImage.widthAnchor.constraint(equalToConstant: 90).isActive = true;
        restImage.heightAnchor.constraint(equalToConstant: 70).isActive = true;
        
        price = UILabel();
        price.text = "$10.82";
        price.font = UIFont(name: "Montserrat-Regular", size: 16);
        price.translatesAutoresizingMaskIntoConstraints = false;
        self.addSubview(price);
        price.leftAnchor.constraint(equalTo: restImage.rightAnchor, constant: 5).isActive = true;
        price.topAnchor.constraint(equalTo: border2.bottomAnchor, constant: 5).isActive = true;
        price.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true;
        price.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        
        
        date = UILabel();
        date.text = "Jan 1, 2017 9:55PM";
        date.font = UIFont(name: "Montserrat-Regular", size: 16);
        date.translatesAutoresizingMaskIntoConstraints = false;
        self.addSubview(date);
        date.leftAnchor.constraint(equalTo: restImage.rightAnchor, constant: 5).isActive = true;
        date.topAnchor.constraint(equalTo: price.bottomAnchor).isActive = true;
        date.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        date.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        
        //buttom layer
        let border = CALayer();
        let width = CGFloat(0.25);
        border.borderColor = UIColor.gray.cgColor;
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: self.frame.size.height);
        border.borderWidth = width;
        self.layer.addSublayer(border);
        self.layer.masksToBounds = true;
    }
    
    func setTitle(title: String){
        restTitle.text = title;
    }
    
//    func setImage(file: String){
//        restImage.image = UIImage(named: file);
//    }
    func setImage(imageData: NSData){
        let imageData = imageData;
        self.restImage.image = UIImage(data: imageData as Data);
    }
    
    func setPrice(priceValue: Double){
        let priceString = String(format: "%.2f", priceValue);
        price.text = "$"+priceString;
    }
    
    func setDate(dateString: String){
        date.text = dateString;
    }
}
