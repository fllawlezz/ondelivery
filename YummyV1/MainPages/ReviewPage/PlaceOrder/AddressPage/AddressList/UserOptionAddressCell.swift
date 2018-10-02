//
//  UserOptionAddressCell.swift
//  YummyV1
//
//  Created by Brandon In on 7/24/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class UserOptionAddressCell: UICollectionViewCell{
    
    var addressTitle: NormalUILabel = {
        let addressTitle = NormalUILabel(textColor: UIColor.black, font: UIFont.montserratSemiBold(fontSize: 14), textAlign: .left);
        return addressTitle;
    }()
    
    var addressDetails: NormalUILabel = {
        let addressDetails = NormalUILabel(textColor: UIColor.black, font: UIFont.montserratRegular(fontSize: 14), textAlign: .left);
        return addressDetails;
    }()
    
    lazy var border: UIView = {
        let border = UIView();
        border.translatesAutoresizingMaskIntoConstraints = false;
        border.backgroundColor = UIColor.gray;
        return border;
    }()
    
    var addressTitleString: String?
    var addressDetailsString: String?
    
    var address: String?;
    var city: String?;
    var zipcode: String?;
    var state: String?;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        setup();
        setupBorder();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setup(){
        self.addSubview(addressTitle);
        addressTitle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true;
        addressTitle.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -50).isActive = true;
        addressTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true;
        addressTitle.bottomAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        
        self.addSubview(addressDetails);
        addressDetails.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true;
        addressDetails.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -50).isActive = true;
        addressDetails.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true;
        addressDetails.topAnchor.constraint(equalTo: self.addressTitle.bottomAnchor, constant: 5).isActive = true;
        
    }
    
    fileprivate func setupBorder(){
        self.addSubview(border);
        border.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        border.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        border.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        border.heightAnchor.constraint(equalToConstant: 0.3).isActive = true;
    }
    
    func setAddressTitle(address: String){
        self.addressTitle.text = address;
        self.address = address;
    }
    
    func setAddressDetails(city: String, zipcode: String, state: String){
        self.addressDetails.text = "\(city),\(state) \(zipcode)";
        self.city = city;
        self.zipcode = zipcode;
        self.state = state;
    }
    
    
    
}
