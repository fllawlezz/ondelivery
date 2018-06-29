//
//  MenuCell.swift
//  YummyV1
//
//  Created by Brandon In on 3/28/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

//MARK: MenuCell
class MenuCell: UICollectionViewCell{
    
    //MARK: Cell variables
    var foodImage: UIImageView!;
    var foodName: UILabel!;
    var foodDescription: UILabel!;
    var foodID: String!;
    var price = 102.99;
    var foodPrice: UILabel!;
    var addButton: UIButton!;
    var minusButton: UIButton!;
    var numberOfItems: UILabel!;
    var btnTapAction : (()->())?
    var btnMinusAction: (()->())?
    
    var shown = false;
    
    private var items = 0;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        setUp();
        addButton.addTarget(self, action: #selector(self.addItem), for: .touchUpInside);
        minusButton.addTarget(self, action: #selector(self.subtractItem), for: .touchUpInside);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    @objc func btnTapped(){
        
        btnTapAction?()
    }
    
    @objc func minusButtonTapped(){
        btnMinusAction?();
    }
    
    func setFoodID(id: String){
        self.foodID = id;
    }
    
    private func setUp(){
        foodImage = UIImageView();
        //        foodImage.frame = CGRect(x: 10, y: 10, width: 70, height: 60);
        foodImage.translatesAutoresizingMaskIntoConstraints = false;
        foodImage.image = UIImage(named: "shrimpRice");
        self.addSubview(foodImage);
        //x,y,width,height
        foodImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true;
        foodImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true;
        foodImage.widthAnchor.constraint(equalToConstant: 70).isActive = true;
        foodImage.heightAnchor.constraint(equalToConstant: 60).isActive = true;
        
        foodName = UILabel();
        //        foodName.frame = CGRect(x: 90, y: 5, width: 250, height: 25);
        foodName.text = "The name of the food goes here";
        foodName.font = UIFont.boldSystemFont(ofSize: 16);
        foodName.minimumScaleFactor = 12;
        foodName.translatesAutoresizingMaskIntoConstraints = false;
        //        foodName.backgroundColor = UIColor.yellow;
        self.addSubview(foodName);
        foodName.leftAnchor.constraint(equalTo: foodImage.rightAnchor, constant: 10).isActive = true;
        foodName.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true;
        foodName.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        foodName.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        
        foodPrice = UILabel();
        //        foodPrice.frame = CGRect(x: 340, y: 30, width: 70, height: 30);
        foodPrice.font = UIFont.systemFont(ofSize: 16);
        foodPrice.textColor = UIColor.red;
        foodPrice.textAlignment = .right
        let formatString = String(format: "%.2f",price);
        foodPrice.text = "$"+formatString;
        foodPrice.minimumScaleFactor = 14;
        //        foodPrice.backgroundColor = UIColor.black;
        foodPrice.translatesAutoresizingMaskIntoConstraints = false;
        self.addSubview(foodPrice);
        //need x,y,width,height
        foodPrice.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true;
        foodPrice.topAnchor.constraint(equalTo: foodName.bottomAnchor, constant: 0).isActive = true;
        foodPrice.widthAnchor.constraint(equalToConstant: 80).isActive = true;
        foodPrice.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        
        foodDescription = UILabel();
        //        foodDescription.frame = CGRect(x: 90, y: 30, width: 250, height: 25);
        foodDescription.text = "This is the description of the food";
        foodDescription.font = UIFont.systemFont(ofSize: 12);
        foodDescription.textColor = UIColor.gray;
        foodDescription.minimumScaleFactor = 12;
        foodDescription.translatesAutoresizingMaskIntoConstraints = false;
        //        foodDescription.backgroundColor = UIColor.red;
        self.addSubview(foodDescription);
        foodDescription.leftAnchor.constraint(equalTo: foodImage.rightAnchor, constant: 10).isActive = true;
        foodDescription.topAnchor.constraint(equalTo: foodName.bottomAnchor, constant: 5).isActive = true;
        foodDescription.rightAnchor.constraint(equalTo: foodPrice.leftAnchor).isActive = true;
        foodDescription.heightAnchor.constraint(equalToConstant: 25);
        
        addButton = UIButton(type: .system);
        //        addButton.frame = CGRect(x: 370, y: 60, width: 35, height: 35);
        addButton.setTitle("+", for: .normal);
        addButton.setTitleColor(UIColor.black, for: .normal);
        addButton.titleLabel?.textColor = UIColor.black;
        addButton.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 24);
        addButton.layer.cornerRadius = 17.5;
        addButton.backgroundColor = UIColor(red: 236/255.0, green: 231/255.0, blue: 0, alpha: 1.0);
        addButton.setTitleShadowColor(UIColor.black, for: .normal);
        addButton.translatesAutoresizingMaskIntoConstraints = false;
        self.addSubview(addButton);
        //need x,y,width,height
        addButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true;
        addButton.topAnchor.constraint(equalTo: foodPrice.bottomAnchor).isActive = true;
        addButton.widthAnchor.constraint(equalToConstant: 35).isActive = true;
        addButton.heightAnchor.constraint(equalToConstant: 35).isActive = true;
        addButton.addTarget(self, action: #selector(self.btnTapped), for: .touchUpInside);
        
        numberOfItems = UILabel();
        //        numberOfItems.frame = CGRect(x: 335, y: 60, width: 35, height: 35);
        //        numberOfItems.backgroundColor = UIColor.red;
        numberOfItems.textAlignment = .center;
        numberOfItems.textColor = UIColor.black;
        numberOfItems.text = String(items);
        numberOfItems.font = UIFont.systemFont(ofSize: 18);
        numberOfItems.translatesAutoresizingMaskIntoConstraints = false;
        self.addSubview(numberOfItems);
        numberOfItems.rightAnchor.constraint(equalTo: addButton.leftAnchor, constant: -5).isActive = true;
        numberOfItems.centerYAnchor.constraint(equalTo: addButton.centerYAnchor).isActive = true;
        numberOfItems.widthAnchor.constraint(equalToConstant: 35).isActive = true;
        numberOfItems.heightAnchor.constraint(equalToConstant: 35).isActive = true;
        
        minusButton = UIButton(type: .system);
        //        minusButton.frame = CGRect(x: 300, y: 60, width: 35, height: 35);
        minusButton.setTitle("-", for: .normal);
        minusButton.setTitleColor(UIColor.black, for: .normal);
        minusButton.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 22);
        minusButton.layer.cornerRadius = 17.5;
        minusButton.backgroundColor = UIColor.lightGray;
        minusButton.translatesAutoresizingMaskIntoConstraints = false;
        self.addSubview(minusButton);
        minusButton.rightAnchor.constraint(equalTo: numberOfItems.leftAnchor, constant: -5).isActive = true;
        minusButton.centerYAnchor.constraint(equalTo: numberOfItems.centerYAnchor).isActive = true;
        minusButton.widthAnchor.constraint(equalToConstant: 35).isActive = true;
        minusButton.heightAnchor.constraint(equalToConstant: 35).isActive = true;
        minusButton.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside);
        
        let border = UIView();
        border.translatesAutoresizingMaskIntoConstraints = false;
        border.backgroundColor = UIColor.gray;
        self.addSubview(border);
        border.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        border.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        border.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true;
        border.heightAnchor.constraint(equalToConstant: 0.5).isActive = true;
        
    }
    
    func setImage(name: String){
        foodImage.image = UIImage(named: name);
    }
    
    func setPrice(charge: Double){
        price = charge;
        foodPrice.text = String("$\(price)")
    }
    
    func setName(name: String){
        foodName.text = name;
    }
    
    func setDescription(description: String){
        foodDescription.text = description
    }
    
    func setQuantity(quantity: Int){
        //        numberOfItems.text = String(quantity);
        items = quantity;
        numberOfItems.text = String(items);
    }
    
    @objc func addItem(){
        if(shown == false){
            shown = true;
            unHide();
        }
        items += 1;
        self.numberOfItems.text = String(items);
        //        print("addPrice");
        //        totalSum += self.price;
    }
    
    @objc func subtractItem(){//on subtract button click
        
        
        items -= 1;//subtract one from items
        if(shown == true && items == 0){//if shown == true and items is less than or equal to 0
            shown = false;//set shown = false because we are going to hide the buttons
            hide();//hide button and labels
            minusSearchArray();
        }
        self.numberOfItems.text = String(items);//set the numberOfItems text to the number of items
//        totalSum -= self.price;//subtract this price from the total sum
        for item in menuItemArray{
            if(item.name == self.foodName.text!){
                item.subtractQuantity(giveQuantity: 1);
                return;
            }
        }
    }
    
    //MARK: PRivate array functions
    
    
    
    private func minusSearchArray(){
        //search through array to find the name
        //        print("minusSearchArray");
        for item in menuItemArray{
            if(item.name == self.foodName.text!){//if the item name is the same as cell's name
                //                print("     name found");
                item.subtractQuantity(giveQuantity: 1);//subtract one from the quantity
                //                print("     \(item.quantity)")
                if(item.quantity == 0){// if the quantity is 0, then
                    //                    print("         itemFound");
                    let index = menuItemArray.index(where: { (item) -> Bool in
                        item.name == self.foodName.text;
                    })//get the index of the item in menuItemArray where the this.foodname.text = item.name
                    menuItemArray.remove(at: index!);//remove the item at the menuArray
                    return;
                }
                break;
            }
        }
    }
    
    func unHide(){
        self.minusButton.isHidden = false;
        self.numberOfItems.isHidden = false;
    }
    
    func hide(){
        self.minusButton.isHidden = true;
        self.numberOfItems.isHidden = true;
    }
    
    func itemNumber() -> Int{
        return items;
    }
    
}
