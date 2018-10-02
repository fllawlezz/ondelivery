//
//  PopUpMenuCell.swift
//  YummyV1
//
//  Created by Brandon In on 3/28/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

//MARK: PopUpMenuCell
class PopUpMenuCell: UICollectionViewCell{
    
    var menuPopup: MenuPopUp?
    var numberOfItems: Int?
    var mainFoodPrice: Double?
    var foodName: String?
    var foodID: Int?
    var hasOptions: Bool?
    
    //variables
    var foodNameLabel: UILabel = {
        let foodName = UILabel();
        foodName.text = "Food's name";
        foodName.font = UIFont(name: "Montserrat-Regular", size: 16);
        foodName.translatesAutoresizingMaskIntoConstraints = false;
        return foodName;
    }()
    
    var addButton: UIButton = {
        let addButton = UIButton(type: .system);
        addButton.setTitle("+", for: .normal);
        addButton.setTitleColor(UIColor.black, for: .normal);
        addButton.titleLabel?.textColor = UIColor.black;
        addButton.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 22);
        addButton.translatesAutoresizingMaskIntoConstraints = false;
        return addButton;
    }()
    var minusButton: UIButton = {
        let minusButton = UIButton(type: .system);
        minusButton.setTitle("-", for: .normal);
        minusButton.setTitleColor(UIColor.black, for: .normal);
        minusButton.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 22);
        minusButton.layer.cornerRadius = 17.5;
        minusButton.backgroundColor = UIColor.lightGray;
        minusButton.translatesAutoresizingMaskIntoConstraints = false;
        return minusButton;
    }()
    var quantity: UILabel = {
        let quantity = UILabel();
        quantity.text = "99";
        quantity.backgroundColor = UIColor.white;
        quantity.textAlignment = .center;
        quantity.translatesAutoresizingMaskIntoConstraints = false;
        return quantity;
    }()
    var border: UIView = {
        let border = UIView();
        border.translatesAutoresizingMaskIntoConstraints = false;
        border.backgroundColor = UIColor.lightGray;
        return border;
    }()
    override init(frame: CGRect) {
        super.init(frame: frame);
        setup();
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }

    
    private func setup(){
        //food name
        setupFoodNameLabel();
        //add button
        setupAddButton();
        setupQuantityLabel();
        setupMinusButton();
        setupBorder();
    }
    
    
    fileprivate func setupFoodNameLabel(){
        self.addSubview(foodNameLabel);
        //need x,y,width,and height
        foodNameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true;
        foodNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        foodNameLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true;
        foodNameLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        foodNameLabel.backgroundColor = UIColor.white;
    }
    
    fileprivate func setupAddButton(){
        self.addSubview(addButton);
        //need x,y,width,height
        addButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true;
        addButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        addButton.widthAnchor.constraint(equalToConstant: 35).isActive = true;
        addButton.heightAnchor.constraint(equalToConstant: 35).isActive = true;
        addButton.layer.cornerRadius = 17.5;
        addButton.backgroundColor = UIColor.appYellow;
        addButton.addTarget(self, action: #selector(self.addItem), for: .touchUpInside);
    }
    
    fileprivate func setupQuantityLabel(){
        self.addSubview(quantity);
        //need x,y,width,height
        quantity.rightAnchor.constraint(equalTo: addButton.leftAnchor, constant: -5).isActive = true;
        quantity.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        quantity.widthAnchor.constraint(equalToConstant: 30).isActive = true;
        quantity.heightAnchor.constraint(equalToConstant: 25).isActive = true;
    }
    
    fileprivate func setupMinusButton(){
        self.addSubview(minusButton);
        //need x,y,width,height
        minusButton.rightAnchor.constraint(equalTo: quantity.leftAnchor, constant: -5).isActive = true;
        minusButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        minusButton.widthAnchor.constraint(equalToConstant: 35).isActive = true;
        minusButton.heightAnchor.constraint(equalToConstant: 35).isActive = true;
        minusButton.addTarget(self, action: #selector(self.subtractItem), for: .touchUpInside);
    }
    
    fileprivate func setupBorder(){
        self.addSubview(border);
        //need x,y,width,and height
        border.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        border.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        border.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true;
        border.heightAnchor.constraint(equalToConstant: 0.25).isActive = true;
    }
    
    func setName(name: String){
        self.foodName = name;
        foodNameLabel.text = name;
    }
    func setQuantity(quantity: Int){
        numberOfItems = quantity;
        self.quantity.text = String(quantity);
    }
    
    func setPrice(price: Double){
        self.mainFoodPrice = price;
    }
    
    @objc func addItem(){
        let name = Notification.Name(rawValue: addedMenuItemNotification);
        let info = ["foodID": self.foodID!, "foodPrice": self.mainFoodPrice!, "foodName": self.foodName!, "hasOptions": self.hasOptions!] as [String : Any];
        NotificationCenter.default.post(name: name, object: nil, userInfo: info);
    }
    
    @objc func subtractItem(){
        let name = Notification.Name(rawValue: removeMenuItemNotification);
        let info = ["foodID": self.foodID!, "foodPrice":self.mainFoodPrice!, "hasOptions": self.hasOptions!] as [String : Any];
        NotificationCenter.default.post(name: name, object: nil, userInfo: info);
    }
    
}
