//
//  MenuBottomBar.swift
//  YummyV1
//
//  Created by Brandon In on 3/28/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

//MARK: MenuBottomBar
class MenuBottomBar: UIView{
    
    var menuController: MenuPage? {
        didSet{
            
        }
    }
    
    var itemNumber = 0;
    var deliveryPrice: Double?
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
    
    lazy var item: UILabel = {
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
        let formatePrice = String(format: "%.2f", finalDeliveryPrice);
        let deliveryPriceLabel = UILabel();
        deliveryPriceLabel.translatesAutoresizingMaskIntoConstraints = false;
        deliveryPriceLabel.text = "Delivery Price: $\(formatePrice)";
        deliveryPriceLabel.textColor = UIColor.black;
        deliveryPriceLabel.font = UIFont(name: "Montserrat-Regular", size: 10);
        return deliveryPriceLabel;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        setUp();
    }
    
    
    private func setUp(){
        //iphone 5s: 320x 568
        self.addSubview(imageView);
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
        
        
        //setUp checkOutButton
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
        
        //setup Price
        self.addSubview(totalSum);
        totalSum.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 10).isActive = true;
        totalSum.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true;
        totalSum.widthAnchor.constraint(equalToConstant: 150).isActive = true;
        totalSum.heightAnchor.constraint(equalToConstant: 20).isActive = true;
        
        //setUp number
        self.addSubview(item);
        if(UIScreenHeight != 568){
            item.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 75).isActive = true;
            item.topAnchor.constraint(equalTo: self.topAnchor, constant: 2).isActive = true;
        }else{
            item.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 50).isActive = true;
            item.topAnchor.constraint(equalTo: self.topAnchor, constant: 2).isActive = true;
        }
        item.widthAnchor.constraint(equalToConstant: 20).isActive = true;
        item.heightAnchor.constraint(equalToConstant: 20).isActive = true;
        
        self.addSubview(deliveryPriceLabel);
        //need x,y,width,height
        deliveryPriceLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 10).isActive = true;
        deliveryPriceLabel.topAnchor.constraint(equalTo: self.totalSum.bottomAnchor).isActive = true;
        deliveryPriceLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true;
        deliveryPriceLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true;
        
        //set up border
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
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    func getNumber()-> Int{
        return itemNumber;
    }
    
    func addItem(){
        itemNumber = itemNumber + 1;
        self.item.text = String(itemNumber);
    }
    
    func subItem(){
        itemNumber = itemNumber - 1;
        self.item.text = String(itemNumber);
    }
    
    func setItem(number: Int){
        itemNumber = number;
        self.item.text = String(itemNumber);
    }
    
    func setTotalSum(sum: Double){
        let newSum = fabs(sum);
        let format = String(format: "%.2f",newSum);
        totalSum.text = "Total: $"+format;
    }
    
    func setDeliveryPrice(price: Double){
        let newPrice = String(format: "%.2f", price);
        finalDeliveryPrice = price;
        self.deliveryPriceLabel.text = "Delivery Price: $\(newPrice)";
    }
    
    func setFreeOrderDeliveryPrice(){
        self.deliveryPriceLabel.text = "Delivery Price: 1 free order";
    }
}
