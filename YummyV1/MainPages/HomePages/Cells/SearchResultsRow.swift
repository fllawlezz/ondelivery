//
//  SearchResultsRow.swift
//  YummyV1
//
//  Created by Brandon In on 6/29/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class SearchResultRow: UITableViewCell{
    var restaurantName: UILabel!;
    var restaurantDistance: UILabel!;
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        setup();
    }
    
    private func setup(){
        restaurantName = UILabel();
        restaurantName.translatesAutoresizingMaskIntoConstraints = false;
        restaurantName.text = "This is restaurant name";
        restaurantName.textColor = UIColor.black;
        restaurantName.font = UIFont(name: "Montserrat-Regular", size: 14);
        restaurantName.adjustsFontSizeToFitWidth = true;
        restaurantName.numberOfLines = 1;
        restaurantName.minimumScaleFactor = 0.1;
        restaurantName.textAlignment = .left;
        self.addSubview(restaurantName);
        restaurantName.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true;
        restaurantName.widthAnchor.constraint(equalToConstant: 150).isActive = true;
        //            restaurantName.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true;
        restaurantName.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        restaurantName.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        
        restaurantDistance = UILabel();
        restaurantDistance.translatesAutoresizingMaskIntoConstraints = false;
        restaurantDistance.text = "0.2 miles";
        restaurantDistance.textColor = UIColor.black;
        restaurantDistance.font = UIFont(name: "Montserrat-Regular", size: 12);
        restaurantDistance.textAlignment = .right;
        self.addSubview(restaurantDistance);
        restaurantDistance.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true;
        //            restaurantDistance.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true;
        restaurantDistance.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        restaurantDistance.widthAnchor.constraint(equalToConstant: 70).isActive = true;
        restaurantDistance.heightAnchor.constraint(equalToConstant: 25).isActive = true;
    }
    
    func setName(name: String){
        self.restaurantName.text = name;
    }
    
    func setDistance(distance: Double){
        let string = String(format: "%.2f",distance);
        restaurantDistance.text = "\(string) mi.";
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
}
