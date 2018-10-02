//
//  MainPageListCell.swift
//  YummyV1
//
//  Created by Brandon In on 6/29/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class MainPageListCell: UICollectionViewCell{
    
    var cellImage: UIImageView!;
    var restName: UILabel!;
    var restAddress: UILabel!;
    var avgDeliveryPrice: UILabel!;
    var distance: UILabel!;
    var seeMenu: UIButton!;
    //    var ratingsView: RatingsViewImage!;
    
    
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
        
        seeMenu.isUserInteractionEnabled = false;
        
        
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
