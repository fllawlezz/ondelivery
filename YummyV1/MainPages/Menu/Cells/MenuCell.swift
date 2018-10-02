//
//  MenuCell.swift
//  YummyV1
//
//  Created by Brandon In on 3/28/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

let addedMenuItemNotification = "AddedMenuItem";
let removeMenuItemNotification = "RemoveMenuItem";

protocol MenuCellDelegate{
    func subtractOptionFoodPrice(foodID: Int);
}

//MARK: MenuCell
class MenuCell: UICollectionViewCell{
    
    var delegate: MenuCellDelegate?
    
    //MARK: Cell variables
    var foodImage: UIImageView = {
        let foodImage = UIImageView();
        foodImage.translatesAutoresizingMaskIntoConstraints = false;
        foodImage.image = UIImage(named: "shrimpRice");
        return foodImage;
    }()
    var foodNameLabel: UILabel = {
        let foodName = UILabel();
        foodName.translatesAutoresizingMaskIntoConstraints = false;
        foodName.text = "The name of the food goes here";
        foodName.font = UIFont.boldSystemFont(ofSize: 16);
        foodName.minimumScaleFactor = 12;
        return foodName;
    }()
    
    var foodDescriptionLabel: UITextView = {
        let foodDescription = UITextView();
        foodDescription.translatesAutoresizingMaskIntoConstraints = false;
        foodDescription.text = "This is the description of the food";
        foodDescription.font = UIFont.systemFont(ofSize: 12);
        foodDescription.textColor = UIColor.gray;
        foodDescription.isEditable = false;
        foodDescription.textAlignment = .left;
        foodDescription.isScrollEnabled = false
        return foodDescription;
    }()
    
    var foodPriceLabel: UILabel = {
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
    
    var border: UIView = {
        let border = UIView();
        border.translatesAutoresizingMaskIntoConstraints = false;
        border.backgroundColor = UIColor.gray;
        return border
    }()
    
    var buttonShown = false;
    
    var foodName: String?
    var foodDescription: String?
    var foodID: String!;
    
    
    var foodPrice = 102.99;
    var totalNumberOfFood = 0;
    var menuPage: MenuPage?
    var options = false;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        
        setupFoodImage();
        setupFoodNameLabel();
        setupPriceLabel();
        setupAddButton();
        setupNumberOfItems();
        setupMinusButton();
        setupDescriptionLabel();
        setupBorder();
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupFoodImage(){
        self.addSubview(foodImage);
        //x,y,width,height
        foodImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true;
        foodImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true;
        foodImage.widthAnchor.constraint(equalToConstant: 70).isActive = true;
        foodImage.heightAnchor.constraint(equalToConstant: 60).isActive = true;
    }
    
    fileprivate func setupFoodNameLabel(){
        self.addSubview(foodNameLabel);
        foodNameLabel.leftAnchor.constraint(equalTo: foodImage.rightAnchor, constant: 10).isActive = true;
        foodNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true;
        foodNameLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        foodNameLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true;
    }
    
    fileprivate func setupPriceLabel(){
        self.addSubview(foodPriceLabel);
        //need x,y,width,height
        foodPriceLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true;
        foodPriceLabel.topAnchor.constraint(equalTo: foodNameLabel.bottomAnchor, constant: 0).isActive = true;
        foodPriceLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true;
        foodPriceLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        
        let formatString = String(format: "%.2f",foodPrice);
        foodPriceLabel.text = "$"+formatString;
    }
    
    fileprivate func setupAddButton(){
        self.addSubview(addButton);
        //need x,y,width,height
        addButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true;
        addButton.topAnchor.constraint(equalTo: foodPriceLabel.bottomAnchor).isActive = true;
        addButton.widthAnchor.constraint(equalToConstant: 35).isActive = true;
        addButton.heightAnchor.constraint(equalToConstant: 35).isActive = true;
        
        addButton.addTarget(self, action: #selector(self.addItem), for: .touchUpInside);
    }
    
    fileprivate func setupNumberOfItems(){
        self.addSubview(numberOfItems);
        numberOfItems.rightAnchor.constraint(equalTo: addButton.leftAnchor, constant: -5).isActive = true;
        numberOfItems.centerYAnchor.constraint(equalTo: addButton.centerYAnchor).isActive = true;
        numberOfItems.widthAnchor.constraint(equalToConstant: 35).isActive = true;
        numberOfItems.heightAnchor.constraint(equalToConstant: 35).isActive = true;
        
        numberOfItems.text = String(totalNumberOfFood);
    }
    
    fileprivate func setupMinusButton(){
        self.addSubview(minusButton);
        minusButton.rightAnchor.constraint(equalTo: numberOfItems.leftAnchor, constant: -5).isActive = true;
        minusButton.centerYAnchor.constraint(equalTo: numberOfItems.centerYAnchor).isActive = true;
        minusButton.widthAnchor.constraint(equalToConstant: 35).isActive = true;
        minusButton.heightAnchor.constraint(equalToConstant: 35).isActive = true;
        
        minusButton.addTarget(self, action: #selector(self.subtractItem), for: .touchUpInside);
    }
    
    fileprivate func setupDescriptionLabel(){
        self.addSubview(foodDescriptionLabel);
        foodDescriptionLabel.leftAnchor.constraint(equalTo: foodImage.rightAnchor, constant: 10).isActive = true;
        foodDescriptionLabel.topAnchor.constraint(equalTo: foodNameLabel.bottomAnchor).isActive = true;
        foodDescriptionLabel.rightAnchor.constraint(equalTo: minusButton.leftAnchor).isActive = true;
        foodDescriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true;
    }
    
    fileprivate func setupBorder(){
        self.addSubview(border);
        border.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        border.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        border.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true;
        border.heightAnchor.constraint(equalToConstant: 0.5).isActive = true;
    }
    
    func setFoodID(id: String){
        self.foodID = id;
    }
    
    func setImage(name: String){
        foodImage.image = UIImage(named: name);
    }
    
    func setPrice(charge: Double){
        foodPrice = charge;
        let format = String(format:"%.2f",foodPrice);
        foodPriceLabel.text = String("$\(format)")
    }
    
    func setName(name: String){
        self.foodName = name;
        foodNameLabel.text = name;
    }
    
    func setDescription(description: String){
        self.foodDescription = description;
        foodDescriptionLabel.text = description
    }
    
    func setQuantity(quantity: Int){
        totalNumberOfFood = quantity;
        numberOfItems.text = String(totalNumberOfFood);
    }
    
    func unhideAddButton(){
        buttonShown = true;
        self.minusButton.isHidden = false;
        self.numberOfItems.isHidden = false;
    }
    

    
    func hideButton(){
        self.minusButton.isHidden = true;
        self.numberOfItems.isHidden = true;
        self.buttonShown = false;
    }
    
    
    
    //MARK: Private array functions
//    fileprivate func minusSearchArray(){
//        //search through array to find the name
//        var menuItemArray = menuPage?.menuItemArray;
//        var count = 0;
//        while(count<menuItemArray!.count){
//            let food = menuItemArray![count];
//            if(food.name == self.foodName!){
//                let subtractedFood = food.foodItems.removeLast();
//                food.subtractQuantity(giveQuantity: 1);
//                food.subtractPrice(price: subtractedFood.foodPrice!);
//                subtractFoodUpdateUI(foodPrice: subtractedFood.foodPrice!);
//
//                if(food.quantity == 0){
//                    menuPage?.menuItemArray.remove(at: count);
//                    menuPage?.popUpMenu.collectionView.reloadData();
//                    hideButton();
//                }
//            }
//            count += 1;
//        }
//    }
    
    fileprivate func subtractFoodUpdateUI(foodPrice: Double){
        let menuBottomBar = menuPage?.menuBottomBar;
        let popUpMenu = menuPage?.popUpMenu;
        var orderTotalSum = menuPage?.totalPrice;
        let deliveryPrice = menuPage?.deliveryPrice;
        let freeOrders = menuPage?.customer.customerFreeOrders!;
        orderTotalSum = orderTotalSum! - foodPrice;
    
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
    }
    
    func itemNumber() -> Int{
        return totalNumberOfFood;
    }

    
}

extension MenuCell{
    @objc fileprivate func subtractItem(){//on subtract button click
        totalNumberOfFood -= 1;//subtract one from items
        self.numberOfItems.text = String(totalNumberOfFood);
        
        if(buttonShown == true && totalNumberOfFood == 0){
            buttonShown = false;
            hideButton();
        }
        handleMenuSubtractItem(foodID: Int(self.foodID)!);
    }
    
    fileprivate func handleMenuSubtractItem(foodID: Int){
        /*
         1. subtract food price from the MainItem totals
         2. remove lastFood from MainItem.foodItems
         3. update the rest of the UI
         */
        
        //        minusSearchArray();
        //subtract from original menu array
        //update menuPopUp and bottomBar
//        print(options)
        let foodPrice = self.foodPrice;
        
        if(options){
            print("in delegate");
            if let delegate = self.delegate{
                delegate.subtractOptionFoodPrice(foodID: foodID);
                return;
            }
        }
        let name = Notification.Name(rawValue: removeMenuItemNotification);
        let userInfo = ["foodID":foodID, "foodPrice": foodPrice,"hasOptions":self.options] as [String : Any];
        NotificationCenter.default.post(name: name, object: nil, userInfo: userInfo)
        
        
        
    }
}

extension MenuCell{
    
    @objc func addItem(){
        if(buttonShown == false && !options){
            unhideAddButton();
        }
        
        if(!options){
            totalNumberOfFood += 1;
            self.numberOfItems.text = String(totalNumberOfFood);
        }
            
        postAddedMenuItem(foodPrice: self.foodPrice, foodID: Int(self.foodID)!, foodName: self.foodName!, hasOptions: self.options);
    }
    
    fileprivate func postAddedMenuItem(foodPrice: Double, foodID: Int, foodName: String, hasOptions: Bool){
        let name = Notification.Name(rawValue: addedMenuItemNotification);
        let info = ["foodID":foodID,"foodPrice":foodPrice, "foodName": foodName, "hasOptions": hasOptions] as [String : Any];
        NotificationCenter.default.post(name: name, object: nil, userInfo: info);
    }
}
