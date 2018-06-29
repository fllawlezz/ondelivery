//
//  MainPageCustomClassesPlus.swift
//  YummyV1
//
//  Created by Brandon In on 11/16/17.
//  Copyright © 2017 Rendered Co.RaftPod. All rights reserved.
//

import Foundation
import UIKit

//MARK: Main Page List Cell
class MainPageListCell: UICollectionViewCell{
    
    var cellImage: UIImageView!;
    var restName: UILabel!;
    var restAddress: UILabel!;
    var avgDeliveryPrice: UILabel!;
    var distance: UILabel!;
    var seeMenu: UIButton!;
//    var ratingsView: RatingsViewImage!;
    var btnTapAction: (()->())?;//callback method
    
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        setUp();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    private func setUp(){
        
        //MARK: Cell Image
        cellImage = UIImageView();
        cellImage.translatesAutoresizingMaskIntoConstraints = false;
        self.addSubview(cellImage);
        //need x,y,width, and height
        cellImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true;
        cellImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true;
        cellImage.widthAnchor.constraint(equalToConstant: 80).isActive = true;
        cellImage.heightAnchor.constraint(equalToConstant: 60).isActive = true;
        
        //MARK: RestName
        restName = UILabel();
        restName.font = UIFont(name: "Montserrat-Bold", size: 14);
        restName.translatesAutoresizingMaskIntoConstraints = false;
        self.addSubview(restName);
        restName.leftAnchor.constraint(equalTo: cellImage.rightAnchor, constant: 5).isActive = true;
        restName.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true;
        restName.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        restName.heightAnchor.constraint(equalToConstant: 25).isActive = true;

        //MARK: Distance
        distance = UILabel();
        distance.textColor = UIColor.gray;
        distance.font = UIFont(name: "Montserrat-Regular", size: 12);
        distance.textAlignment = .right;
        distance.translatesAutoresizingMaskIntoConstraints = false;
        self.addSubview(distance);
        //need x,y,width,height
        distance.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true;
        distance.topAnchor.constraint(equalTo: restName.bottomAnchor).isActive = true;
        distance.widthAnchor.constraint(equalToConstant: 60).isActive = true;
        distance.heightAnchor.constraint(equalToConstant: 20).isActive = true;
        //        distance.layer.borderWidth = 0.25;
        
        //MARK: Rest Address
        restAddress = UILabel();
        restAddress.font = UIFont(name: "Montserrat-Regular", size: 12);
        restAddress.textColor = UIColor.gray;
        restAddress.translatesAutoresizingMaskIntoConstraints = false;
        self.addSubview(restAddress);
        restAddress.leftAnchor.constraint(equalTo: cellImage.rightAnchor, constant: 5).isActive = true;
        restAddress.topAnchor.constraint(equalTo: restName.bottomAnchor, constant: 0).isActive = true;
        restAddress.rightAnchor.constraint(equalTo: distance.rightAnchor).isActive = true;
        restAddress.heightAnchor.constraint(equalToConstant: 20);
        
        //MARK: SeeMenu Button
        seeMenu = UIButton();
        seeMenu.backgroundColor = UIColor.appYellow;
        seeMenu.layer.cornerRadius = 3;
        seeMenu.setTitle("Menu", for: .normal);
        seeMenu.setTitleColor(UIColor.black, for: .normal);
        seeMenu.titleLabel?.font = UIFont(name: "Montserrat-Medium", size: 10);
        seeMenu.translatesAutoresizingMaskIntoConstraints = false;
        self.addSubview(seeMenu);
        seeMenu.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true;
        seeMenu.topAnchor.constraint(equalTo: distance.bottomAnchor).isActive = true;
        seeMenu.widthAnchor.constraint(equalToConstant: 60).isActive = true;
        seeMenu.heightAnchor.constraint(equalToConstant: 20).isActive = true;
        seeMenu.addTarget(self, action: #selector(self.callBack), for: .touchUpInside);
        
        
        //MARK: Delivery Price
        avgDeliveryPrice = UILabel();
        avgDeliveryPrice.font = UIFont(name: "Montserrat-Regular", size: 12);
        avgDeliveryPrice.textColor = UIColor.gray;
        avgDeliveryPrice.translatesAutoresizingMaskIntoConstraints = false;
        avgDeliveryPrice.adjustsFontSizeToFitWidth = true;
        avgDeliveryPrice.numberOfLines = 1;
        avgDeliveryPrice.minimumScaleFactor = 0.1;
        self.addSubview(avgDeliveryPrice);
        //need x,y,width,height
        avgDeliveryPrice.leftAnchor.constraint(equalTo: cellImage.rightAnchor, constant: 5).isActive = true;
        avgDeliveryPrice.topAnchor.constraint(equalTo: restAddress.bottomAnchor).isActive = true;
        avgDeliveryPrice.rightAnchor.constraint(equalTo: seeMenu.leftAnchor, constant: -5).isActive = true;
        avgDeliveryPrice.heightAnchor.constraint(equalToConstant: 20).isActive = true;
        //Test the size of frame
//        deliveryPrice.layer.borderWidth = 1;
//        deliveryPrice.layer.borderColor = UIColor.black.cgColor;
        
        //MARK: Rating View
//        ratingsView = RatingsViewImage();
//        ratingsView.translatesAutoresizingMaskIntoConstraints = false;
////        ratingsView.backgroundColor = UIColor.blue;
//        self.addSubview(ratingsView);
//        ratingsView.leftAnchor.constraint(equalTo: avgDeliveryPrice.leftAnchor).isActive = true;
//        ratingsView.topAnchor.constraint(equalTo: avgDeliveryPrice.bottomAnchor).isActive = true;
//        ratingsView.rightAnchor.constraint(equalTo: avgDeliveryPrice.rightAnchor).isActive = true;
//        ratingsView.heightAnchor.constraint(equalToConstant: 20).isActive = true;
        
        //border setup for cell
        let border = UIView();
        border.translatesAutoresizingMaskIntoConstraints = false;
        border.backgroundColor = UIColor.gray;
        self.addSubview(border);
        //need x,y,width,height
        border.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        border.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        border.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true;
        border.heightAnchor.constraint(equalToConstant: 0.25).isActive = true;
        
    }
    
    @objc public func callBack(){
        btnTapAction?();
    }
    
    public func setImage(imageName: String){
        self.cellImage.image = UIImage(named: imageName);
    }
    
    public func setNameAndAddress(name: String, address: String){
        self.restName.text = name;
        self.restAddress.text = address;
    }
    
    public func setPrice(price: Double){
        let priceString = String(format: "%.2f", price);
        self.avgDeliveryPrice.text = "Avg delivery Price: $"+priceString;
    }
    
    public func setDistance(dist: Double){
        let distString = String(format: "%.1f",dist);
        self.distance.text = distString+"mi.";
    }
    
}


//MARK: Main Page ScrollView Views
class MainPageView: UIView{
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











