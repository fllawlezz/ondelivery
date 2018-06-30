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
    var foodImage: UIImageView = {
        let foodImage = UIImageView();
        foodImage.translatesAutoresizingMaskIntoConstraints = false;
        foodImage.image = UIImage(named: "shrimpRice");
        return foodImage;
    }()
    var foodName: UILabel = {
        let foodName = UILabel();
        foodName.translatesAutoresizingMaskIntoConstraints = false;
        foodName.text = "The name of the food goes here";
        foodName.font = UIFont.boldSystemFont(ofSize: 16);
        foodName.minimumScaleFactor = 12;
        return foodName;
    }()
    var foodDescription: UILabel = {
        let foodDescription = UILabel();
        foodDescription.translatesAutoresizingMaskIntoConstraints = false;
        foodDescription.text = "This is the description of the food";
        foodDescription.font = UIFont.systemFont(ofSize: 12);
        foodDescription.textColor = UIColor.gray;
        foodDescription.minimumScaleFactor = 12;
        return foodDescription;
    }()
    
    var foodPrice: UILabel = {
        let foodPrice = UILabel();
        foodPrice.translatesAutoresizingMaskIntoConstraints = false;
        foodPrice.font = UIFont.systemFont(ofSize: 16);
        foodPrice.textColor = UIColor.red;
        foodPrice.textAlignment = .right
        foodPrice.minimumScaleFactor = 14;
        return foodPrice;
    }()
    var addButton: UIButton = {
        let addButton = UIButton(type: .system);
        addButton.setTitle("+", for: .normal);
        addButton.setTitleColor(UIColor.black, for: .normal);
        addButton.titleLabel?.textColor = UIColor.black;
        addButton.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 24);
        addButton.layer.cornerRadius = 17.5;
        addButton.backgroundColor = UIColor(red: 236/255.0, green: 231/255.0, blue: 0, alpha: 1.0);
        addButton.setTitleShadowColor(UIColor.black, for: .normal);
        addButton.translatesAutoresizingMaskIntoConstraints = false;
        return addButton;
    }()
    var minusButton: UIButton = {
        let minusButton = UIButton(type: .system);
        minusButton.setTitle("-", for: .normal);
        minusButton.setTitleColor(UIColor.black, for: .normal);
        minusButton.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 22);
        minusButton.layer.cornerRadius = 17.5;
        minusButton.backgroundColor = UIColor.lightGray;
        minusButton.translatesAutoresizingMaskIntoConstraints = false;
        return minusButton;
    }()
    
    var numberOfItems: UILabel = {
        let numberOfItems = UILabel();
        numberOfItems.translatesAutoresizingMaskIntoConstraints = false;
        numberOfItems.textAlignment = .center;
        numberOfItems.textColor = UIColor.black;
        numberOfItems.font = UIFont.systemFont(ofSize: 18);
        return numberOfItems;
    }()
    var btnTapAction : (()->())?
    var btnMinusAction: (()->())?
    
    var buttonShown = false;
    var foodID: String!;
    var cellSection: Int?;
    var cellIndex: Int?;
    var price = 102.99;
    private var totalNumberOfFood = 0;
    var menuPage: MenuPage?
    
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
    
//    @objc func btnTapped(){
//
//        btnTapAction?()
//    }
//
//    @objc func minusButtonTapped(){
//        btnMinusAction?();
//    }
    
    func setFoodID(id: String){
        self.foodID = id;
    }
    
    private func setUp(){
        self.addSubview(foodImage);
        //x,y,width,height
        foodImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true;
        foodImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true;
        foodImage.widthAnchor.constraint(equalToConstant: 70).isActive = true;
        foodImage.heightAnchor.constraint(equalToConstant: 60).isActive = true;
        
        self.addSubview(foodName);
        foodName.leftAnchor.constraint(equalTo: foodImage.rightAnchor, constant: 10).isActive = true;
        foodName.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true;
        foodName.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        foodName.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        
        self.addSubview(foodPrice);
        //need x,y,width,height
        foodPrice.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true;
        foodPrice.topAnchor.constraint(equalTo: foodName.bottomAnchor, constant: 0).isActive = true;
        foodPrice.widthAnchor.constraint(equalToConstant: 80).isActive = true;
        foodPrice.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        
        let formatString = String(format: "%.2f",price);
        foodPrice.text = "$"+formatString;
        
        self.addSubview(foodDescription);
        foodDescription.leftAnchor.constraint(equalTo: foodImage.rightAnchor, constant: 10).isActive = true;
        foodDescription.topAnchor.constraint(equalTo: foodName.bottomAnchor, constant: 5).isActive = true;
        foodDescription.rightAnchor.constraint(equalTo: foodPrice.leftAnchor).isActive = true;
        foodDescription.heightAnchor.constraint(equalToConstant: 25);
        
        self.addSubview(addButton);
        //need x,y,width,height
        addButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true;
        addButton.topAnchor.constraint(equalTo: foodPrice.bottomAnchor).isActive = true;
        addButton.widthAnchor.constraint(equalToConstant: 35).isActive = true;
        addButton.heightAnchor.constraint(equalToConstant: 35).isActive = true;
//        addButton.addTarget(self, action: #selector(self.btnTapped), for: .touchUpInside);
        
        self.addSubview(numberOfItems);
        numberOfItems.rightAnchor.constraint(equalTo: addButton.leftAnchor, constant: -5).isActive = true;
        numberOfItems.centerYAnchor.constraint(equalTo: addButton.centerYAnchor).isActive = true;
        numberOfItems.widthAnchor.constraint(equalToConstant: 35).isActive = true;
        numberOfItems.heightAnchor.constraint(equalToConstant: 35).isActive = true;
        
        numberOfItems.text = String(totalNumberOfFood);
        
        self.addSubview(minusButton);
        minusButton.rightAnchor.constraint(equalTo: numberOfItems.leftAnchor, constant: -5).isActive = true;
        minusButton.centerYAnchor.constraint(equalTo: numberOfItems.centerYAnchor).isActive = true;
        minusButton.widthAnchor.constraint(equalToConstant: 35).isActive = true;
        minusButton.heightAnchor.constraint(equalToConstant: 35).isActive = true;
//        minusButton.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside);
        
        let border = UIView();
        border.translatesAutoresizingMaskIntoConstraints = false;
        border.backgroundColor = UIColor.gray;
        self.addSubview(border);
        border.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        border.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        border.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true;
        border.heightAnchor.constraint(equalToConstant: 0.5).isActive = true;
        
//        hideButton();
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
        totalNumberOfFood = quantity;
        numberOfItems.text = String(totalNumberOfFood);
    }
    
    @objc func addItem(){
        if(buttonShown == false){
            buttonShown = true;
            unhideAddButton();
        }
        
        totalNumberOfFood += 1;
        self.numberOfItems.text = String(totalNumberOfFood);
        //manipulate menuPage
        handleMenuPageAddItem();
    }
    
    fileprivate func handleMenuPageAddItem(){
        let menuBottomBar = menuPage?.menuBottomBar;
        let popUpMenu = menuPage?.popUpMenu;
        var orderTotalSum = menuPage?.totalPrice;
        let deliveryPrice = menuPage?.deliveryPrice;
        let freeOrders = menuPage?.freeOrders;
        orderTotalSum = orderTotalSum! + price;
        
        self.menuPage?.totalPrice = orderTotalSum!;
        menuBottomBar?.addItem();
        menuBottomBar?.setTotalSum(sum: orderTotalSum!);
        popUpMenu?.totalPrice = orderTotalSum;
        
        if(orderTotalSum! > 20.0){
            menuBottomBar?.setDeliveryPrice(price: deliveryPrice!);
        }else if(orderTotalSum! <= 20 && freeOrders! > 0){
            menuBottomBar?.setFreeOrderDeliveryPrice();
        }
        
//        var menuItemArray = menuPage?.menuItemArray;
        
        for food in menuPage!.menuItemArray{
            if(food.name == foodName.text!){
                food.addQuantity(giveQuantity: 1);
                return;
            }
        }
        let menuItem = MenuItem(name: foodName.text!, price: price, quantity: 1);
        menuItem.mainCellIndex = self.cellIndex;
        menuItem.cellSection = self.cellSection;
        menuPage!.menuItemArray.append(menuItem);
        
        menuPage?.popUpMenu.collectionView.reloadData();
    }
    
    func unhideAddButton(){
        self.minusButton.isHidden = false;
        self.numberOfItems.isHidden = false;
    }
    
    @objc fileprivate func subtractItem(){//on subtract button click
        totalNumberOfFood -= 1;//subtract one from items
        self.numberOfItems.text = String(totalNumberOfFood);
        
        if(buttonShown == true && totalNumberOfFood == 0){
            buttonShown = false;
            hideButton();
        }
        handleMenuSubtractItem();
    }
    
    func hideButton(){
        self.minusButton.isHidden = true;
        self.numberOfItems.isHidden = true;
    }
    
    fileprivate func handleMenuSubtractItem(){
        let menuBottomBar = menuPage?.menuBottomBar;
        let popUpMenu = menuPage?.popUpMenu;
        var orderTotalSum = menuPage?.totalPrice;
        let deliveryPrice = menuPage?.deliveryPrice;
        let freeOrders = menuPage?.freeOrders;
        orderTotalSum = orderTotalSum! - price;
        
        self.menuPage?.totalPrice = orderTotalSum!;
        
        menuBottomBar?.subItem();
        popUpMenu?.totalPrice = orderTotalSum!;
        menuBottomBar?.setTotalSum(sum: orderTotalSum!);
        
        if(orderTotalSum! > 20){
            //set bottom bar delivery price
            menuBottomBar?.setDeliveryPrice(price: deliveryPrice!);
        }else if(orderTotalSum! <= 20 && freeOrders! > 0){
            menuBottomBar?.setFreeOrderDeliveryPrice();
        }
        
        minusSearchArray();
    }
    
    //MARK: PRivate array functions
    fileprivate func minusSearchArray(){
        //search through array to find the name
        var menuItemArray = menuPage?.menuItemArray;
        var count = 0;
        while(count<menuItemArray!.count){
            let food = menuItemArray![count];
            if(food.name == self.foodName.text!){
                food.subtractQuantity(giveQuantity: 1);
                if(food.quantity == 0){
                    menuPage?.menuItemArray.remove(at: count);
                    menuPage?.popUpMenu.collectionView.reloadData();
                    hideButton();
                }
            }
            count += 1;
        }
//        
    }
    
    func itemNumber() -> Int{
        return totalNumberOfFood;
    }
    
}
