//
//  MenuBottomBar.swift
//  YummyV1
//
//  Created by Brandon In on 3/28/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

protocol MenuBottomBarDelegate{
    func handleShowPopUpMenu();
    func handleCheckout(deliveryPrice: Double, totalSum: Double);
}

let updateBottomBarNotification = "updateBottomBarSpecialOptions";

//MARK: MenuBottomBar
class MenuBottomBar: UIView{
    
    var menuController: MenuPage?
    var menuBottomBarDelegate: MenuBottomBarDelegate?
    //Data Elements
    
    var itemNumber = 0;
    var deliveryPrice: Double = 0;
    var deliveryPriceFormat = 3.99;
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView();
        imageView.image = UIImage(named: "whiteCart");
        imageView.translatesAutoresizingMaskIntoConstraints = false;
        imageView.contentMode = .scaleAspectFit;
        imageView.backgroundColor = UIColor.black
        return imageView;
    }()
    
    lazy var checkoutButton: UIButton = {
        let checkoutButton = UIButton(type: .system);
        checkoutButton.translatesAutoresizingMaskIntoConstraints = false;
        checkoutButton.setTitle("Checkout", for: .normal);
        checkoutButton.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 16);
        checkoutButton.setTitleColor(UIColor.black, for: .normal);
        checkoutButton.backgroundColor = UIColor(red: 236/255.0, green: 231/255.0, blue: 0, alpha: 1.0);
        checkoutButton.layer.borderColor = UIColor.lightGray.cgColor;
        checkoutButton.layer.borderWidth = 1;
        return checkoutButton;
    }()
    
    lazy var totalSum: UILabel = {
        let totalSum = UILabel();
        totalSum.translatesAutoresizingMaskIntoConstraints = false;
        totalSum.text = "Total: $102.99";
        totalSum.textColor = UIColor.black;
        totalSum.font = UIFont(name: "Montserrat-Regular", size: 16);
        return totalSum;
    }()
    
    lazy var itemLabel: UILabel = {
        let item = UILabel();
        item.translatesAutoresizingMaskIntoConstraints = false;
        item.textColor = UIColor.red;
        item.text = "0";
        item.font = UIFont(name: "Montserrat-Regular", size: 14);
        item.textAlignment = .center;
        item.layer.cornerRadius = 10;
        item.layer.masksToBounds = true;
        item.backgroundColor = UIColor(red: 236/255.0, green: 231/255.0, blue: 0, alpha: 1.0);
        return item;
    }()
    
    lazy var deliveryPriceLabel: UILabel = {
        let deliveryPriceLabel = UILabel();
        deliveryPriceLabel.translatesAutoresizingMaskIntoConstraints = false;
        deliveryPriceLabel.textColor = UIColor.black;
        deliveryPriceLabel.font = UIFont(name: "Montserrat-Regular", size: 10);
        return deliveryPriceLabel;
    }()
    
    var totalPrice = 0.00;
    
    deinit{
        NotificationCenter.default.removeObserver(self);
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.addObservers();
        setupImageView();
        setupCheckoutButton();
        setupTotalSum();
        setupItemLabel();
        setupDeliveryPrice();
        setupBorder();
    }
    
    fileprivate func addObservers(){
        let name = Notification.Name(rawValue: addedMenuItemNotification);
        let removeName = Notification.Name(rawValue: removeMenuItemNotification);
        let updateBottomBarName = Notification.Name(rawValue: updateBottomBarNotification);
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleAddFoodItem(notification:)), name: name, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleRemoveFoodItem(notification:)), name: removeName, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleUpdateBottomBar(notification:)), name: updateBottomBarName, object: nil);
    }
    
    fileprivate func setupImageView(){
        self.addSubview(imageView);
        imageView.isUserInteractionEnabled = true;
        //we need a x,y,width,height
        imageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true;
        imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true;
        if(UIScreenHeight != 568){
            imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true;
            imageView.heightAnchor.constraint(equalToConstant: 60).isActive = true;
        }else{
            imageView.widthAnchor.constraint(equalToConstant: 75).isActive = true;
            imageView.heightAnchor.constraint(equalToConstant: 60).isActive = true;
        }
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleCartPressed));
        imageView.addGestureRecognizer(gestureRecognizer);
    }
    
    fileprivate func setupCheckoutButton(){
        self.addSubview(checkoutButton);
        //need x,y,width,andheight
        checkoutButton.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        checkoutButton.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        if(UIScreenHeight != 568){
            checkoutButton.widthAnchor.constraint(equalToConstant: 125).isActive = true;
            checkoutButton.heightAnchor.constraint(equalToConstant: 60).isActive = true;
        }else{
            checkoutButton.titleLabel?.adjustsFontSizeToFitWidth = true;
            checkoutButton.titleLabel?.minimumScaleFactor = 0.1;
            checkoutButton.widthAnchor.constraint(equalToConstant: 90).isActive = true;
            checkoutButton.heightAnchor.constraint(equalToConstant: 60).isActive = true;
        }
        
        checkoutButton.addTarget(self, action: #selector(self.checkout), for: .touchUpInside);
    }
    
    fileprivate func setupTotalSum(){
        self.addSubview(totalSum);
        totalSum.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 10).isActive = true;
        totalSum.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true;
        totalSum.widthAnchor.constraint(equalToConstant: 150).isActive = true;
        totalSum.heightAnchor.constraint(equalToConstant: 20).isActive = true;
    }
    
    fileprivate func setupItemLabel(){
        self.addSubview(itemLabel);
        if(UIScreenHeight != 568){
            itemLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 75).isActive = true;
            itemLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 2).isActive = true;
        }else{
            itemLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 50).isActive = true;
            itemLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 2).isActive = true;
        }
        itemLabel.widthAnchor.constraint(equalToConstant: 20).isActive = true;
        itemLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true;
    }
    
    fileprivate func setupDeliveryPrice(){
        self.addSubview(deliveryPriceLabel);
        //need x,y,width,height
        deliveryPriceLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 10).isActive = true;
        deliveryPriceLabel.topAnchor.constraint(equalTo: self.totalSum.bottomAnchor).isActive = true;
        deliveryPriceLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true;
        deliveryPriceLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true;
    }
    
    fileprivate func setupBorder(){
        let border = UIView();
        border.translatesAutoresizingMaskIntoConstraints = false;
        border.backgroundColor = UIColor.lightGray;
        self.addSubview(border);
        //need x,y,width,height
        border.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        border.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        border.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true;
        border.heightAnchor.constraint(equalToConstant: 1).isActive = true;
        //
        let formatePrice = String(format: "%.2f", self.deliveryPrice);
        deliveryPriceLabel.text = "Delivery Price: $\(formatePrice)";
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    
    func getNumber()-> Int{
        return itemNumber;
    }
    
    func addItem(){
        itemNumber = itemNumber + 1;
        self.itemLabel.text = String(itemNumber);
    }
    
    func subItem(){
        itemNumber = itemNumber - 1;
        self.itemLabel.text = String(itemNumber);
    }
    
    func setItem(number: Int){
        itemNumber = number;
        self.itemLabel.text = String(itemNumber);
    }
    
    func setTotalSum(sum: Double){
        let newSum = fabs(sum);
        let format = String(format: "%.2f",newSum);
        totalSum.text = "Total: $"+format;
    }
    
    func setDeliveryPrice(price: Double){
        let newPrice = String(format: "%.2f", price);
        deliveryPrice = price;
        self.deliveryPriceLabel.text = "Delivery Price: $\(newPrice)";
    }
    
    func setFreeOrderDeliveryPrice(){
        self.deliveryPriceLabel.text = "Delivery Price: 1 free order";
    }
    
    func addItemPrice(foodPrice: Double){
        self.totalPrice += foodPrice;
        let formatedPrice = String(format: "%.2f", totalPrice);
        self.totalSum.text = "Total: $\(formatedPrice)"
        
    }
    
    func removeItemPrice(foodPrice: Double){
        self.totalPrice -= foodPrice;
        let formatedPrice = String(format: "%.2f", totalPrice);
        self.totalSum.text = "Total: $\(formatedPrice)"
    }
}

extension MenuBottomBar{
    @objc func handleAddFoodItem(notification: NSNotification){
        
        if let userInfo = notification.userInfo{
            
            let foodPrice = userInfo["foodPrice"]!;
            let hasOptions = userInfo["hasOptions"] as! Bool;
//            print(foodPrice);
            if(!hasOptions){
                self.addItem();
                self.addItemPrice(foodPrice: foodPrice as! Double);
            }
        }
    }
    
    @objc func handleRemoveFoodItem(notification: NSNotification){
        if let userInfo = notification.userInfo{
            let foodPrice = userInfo["foodPrice"]!;
//            let foodID = userInfo["foodID"];
            let options = userInfo["hasOptions"] as! Bool;
            if(!options){
                self.subItem();
                self.removeItemPrice(foodPrice: foodPrice as! Double);
            }
            
        }
    }
    
    @objc func handleUpdateBottomBar(notification: NSNotification){
        if let userInfo = notification.userInfo{
            let foodPrice = userInfo["foodPrice"]!;
            self.addItem();
            self.addItemPrice(foodPrice: foodPrice as! Double);
        }
    }
    
    @objc func updateBottomBarSubtractSpecialOption(foodPrice: Double){
        self.subItem();
        self.removeItemPrice(foodPrice: foodPrice);
    }
    
    @objc func handleCartPressed(){
        if let delegate = self.menuBottomBarDelegate{
            delegate.handleShowPopUpMenu();
        }
    }
    
    @objc func checkout(){
        if let delegate = self.menuBottomBarDelegate{
            delegate.handleCheckout(deliveryPrice: self.deliveryPrice, totalSum: self.totalPrice);
        }
    }
}
