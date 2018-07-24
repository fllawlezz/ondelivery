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
    var foodNameLabel: UILabel = {
        let foodName = UILabel();
        foodName.translatesAutoresizingMaskIntoConstraints = false;
        foodName.text = "The name of the food goes here";
        foodName.font = UIFont.boldSystemFont(ofSize: 16);
        foodName.minimumScaleFactor = 12;
        return foodName;
    }()
//    var foodDescriptionLabel: UILabel = {
//        let foodDescription = UILabel();
//        foodDescription.translatesAutoresizingMaskIntoConstraints = false;
//        foodDescription.text = "This is the description of the food";
//        foodDescription.font = UIFont.systemFont(ofSize: 12);
//        foodDescription.textColor = UIColor.gray;
//        foodDescription.minimumScaleFactor = 12;
//        foodDescription.numberOfLines = 0;
//        return foodDescription;
//    }()
    
    var foodDescriptionLabel: UITextView = {
        let foodDescription = UITextView();
        foodDescription.translatesAutoresizingMaskIntoConstraints = false;
        foodDescription.text = "This is the description of the food";
        foodDescription.font = UIFont.systemFont(ofSize: 12);
        foodDescription.textColor = UIColor.gray;
//        foodDescription.minimumScaleFactor = 12;
//        foodDescription.numberOfLines = 0;
        foodDescription.isEditable = false;
        foodDescription.textAlignment = .left;
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
        setUp();
        addButton.addTarget(self, action: #selector(self.addItem), for: .touchUpInside);
        minusButton.addTarget(self, action: #selector(self.subtractItem), for: .touchUpInside);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
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
        
        self.addSubview(foodNameLabel);
        foodNameLabel.leftAnchor.constraint(equalTo: foodImage.rightAnchor, constant: 10).isActive = true;
        foodNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true;
        foodNameLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        foodNameLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        
        self.addSubview(foodPriceLabel);
        //need x,y,width,height
        foodPriceLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true;
        foodPriceLabel.topAnchor.constraint(equalTo: foodNameLabel.bottomAnchor, constant: 0).isActive = true;
        foodPriceLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true;
        foodPriceLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        
        let formatString = String(format: "%.2f",foodPrice);
        foodPriceLabel.text = "$"+formatString;
        
        self.addSubview(addButton);
        //need x,y,width,height
        addButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true;
        addButton.topAnchor.constraint(equalTo: foodPriceLabel.bottomAnchor).isActive = true;
        addButton.widthAnchor.constraint(equalToConstant: 35).isActive = true;
        addButton.heightAnchor.constraint(equalToConstant: 35).isActive = true;
        
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
        
        self.addSubview(foodDescriptionLabel);
        foodDescriptionLabel.leftAnchor.constraint(equalTo: foodImage.rightAnchor, constant: 10).isActive = true;
        foodDescriptionLabel.topAnchor.constraint(equalTo: foodNameLabel.bottomAnchor).isActive = true;
        foodDescriptionLabel.rightAnchor.constraint(equalTo: minusButton.leftAnchor).isActive = true;
        foodDescriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true;
        
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
//        foodDescriptionLabel.sizeToFit();
    }
    
    func setQuantity(quantity: Int){
        totalNumberOfFood = quantity;
        numberOfItems.text = String(totalNumberOfFood);
    }
    
    @objc func addItem(){
        if(options){
            self.handleLoadOptions();
        }else{
            if(buttonShown == false){
                buttonShown = true;
                unhideAddButton();
            }
            
            totalNumberOfFood += 1;
            self.numberOfItems.text = String(totalNumberOfFood);
            print(totalNumberOfFood);
            //manipulate menuPage
            handleMenuPageAddItem();
        }
    }
    
    fileprivate func handleMenuPageAddItem(){
        for food in menuPage!.menuItemArray{
            if(food.name == self.foodName!){
                food.addQuantity(giveQuantity: 1);
                food.addPrice(price: self.foodPrice);
                
                let foodItem = FoodItem(foodName: self.foodName!, foodPrice: self.foodPrice, hasOptions: false);
                food.foodItems.append(foodItem);
                addFoodUpdateUI(foodPrice: foodItem.foodPrice!);
                return;
            }
        }
        
        let orderItem = MainItem(name: self.foodName!, price: self.foodPrice, quantity: 1);
        orderItem.id = self.foodID!;
        orderItem.itemPrice = self.foodPrice;
        let foodItem = FoodItem(foodName: self.foodName!, foodPrice: self.foodPrice, hasOptions: false);
        orderItem.foodItems.append(foodItem);
        menuPage!.menuItemArray.append(orderItem);
        
        addFoodUpdateUI(foodPrice: foodItem.foodPrice!);
    }
    
    fileprivate func addFoodUpdateUI(foodPrice: Double){
        let menuBottomBar = menuPage?.menuBottomBar;
        let popUpMenu = menuPage?.popUpMenu;
        var orderTotalSum = menuPage?.totalPrice;
        let deliveryPrice = menuPage?.deliveryPrice;
        let freeOrders = menuPage?.customer.customerFreeOrders;
        orderTotalSum = orderTotalSum! + foodPrice;
        
        self.menuPage?.totalPrice = orderTotalSum!;
        
        menuBottomBar?.addItem();
        menuBottomBar?.setTotalSum(sum: orderTotalSum!);
        popUpMenu?.totalPrice = orderTotalSum;
        
        if(orderTotalSum! > 20.0){
            menuBottomBar?.setDeliveryPrice(price: deliveryPrice!);
        }else if(orderTotalSum! <= 20 && freeOrders! > 0){
            menuBottomBar?.setFreeOrderDeliveryPrice();
        }
        
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
        /*
         1. subtract food price from the MainItem totals
         2. remove lastFood from MainItem.foodItems
         3. update the rest of the UI
     */
        
        minusSearchArray();
    }
    
    //MARK: Private array functions
    fileprivate func minusSearchArray(){
        //search through array to find the name
        var menuItemArray = menuPage?.menuItemArray;
        var count = 0;
        while(count<menuItemArray!.count){
            let food = menuItemArray![count];
            if(food.name == self.foodName!){
                let subtractedFood = food.foodItems.removeLast();
                food.subtractQuantity(giveQuantity: 1);
                food.subtractPrice(price: subtractedFood.foodPrice!);
                subtractFoodUpdateUI(foodPrice: subtractedFood.foodPrice!);
                
                if(food.quantity == 0){
                    menuPage?.menuItemArray.remove(at: count);
                    menuPage?.popUpMenu.collectionView.reloadData();
                    hideButton();
                }
            }
            count += 1;
        }
    }
    
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
    
    fileprivate func handleLoadOptions(){
        let conn = Conn();
        let postBody = "FoodID=\(self.foodID!)"
        print(postBody);
        conn.connect(fileName: "LoadOptions.php", postString: postBody) { (result) in
            if(urlData != nil){
                do{
                    let json = try JSONSerialization.jsonObject(with: urlData!, options: .allowFragments) as! NSDictionary;
//                    print(json);
                    let numSections = json["numberOfSections"] as! String;
                    let extraFoodNames = json["extraFoodNames"] as! NSArray;
                    let extraFoodPrices = json["extraFoodPrices"] as! NSArray;
                    let extraFoodIDs = json["extraFoodIDs"] as! NSArray;
                    let sectionNames = json["sectionNames"] as! NSArray;
                    
                    DispatchQueue.main.async {
                        let numberOfSections = Int(numSections)!
                        print(numberOfSections);
                        
                        var count = 0;
                        var optionsBySection = [[SpecialOption]]();
                        while(count < extraFoodNames.count){
                            var sectionOfFoods = [SpecialOption]();
                            
                            let foodNameOptions = extraFoodNames[count] as! NSArray;
                            let foodPriceOptions = extraFoodPrices[count] as! NSArray;
                            let extraFoodIDs = extraFoodIDs[count] as! NSArray;
                            
                            var count2 = 0;
                            while(count2<foodNameOptions.count){
                                let currentFoodNameOption = foodNameOptions[count2] as? String;
                                let currentFoodPriceOption = foodPriceOptions[count2] as? String;
                                let currentFoodID = extraFoodIDs[count2] as? String;
                                let currentFoodIDInt = Int(currentFoodID!);
                                
                                let option = SpecialOption();
                                option.specialOptionName = currentFoodNameOption!;
                                option.specialOptionPrice = Double(currentFoodPriceOption!);
                                option.specialOptionID = currentFoodIDInt;
                                
                                sectionOfFoods.append(option);
                                
                                count2+=1;
                            }
                            count2 = 0;
                            optionsBySection.append(sectionOfFoods);
                            count+=1;
                        }
                        
                        var sectionNameArray = [String]()
                        for sectionName in sectionNames{
                            let sectionName = sectionName as! String
                            sectionNameArray.append(sectionName);
                        }
                        
                        let foodIDInt =  Int(self.foodID!);
                        
                        let specialOptions = SpecialOptionsPage();
                        specialOptions.mainFoodName = self.foodNameLabel.text!;
                        specialOptions.mainFoodPrice = self.foodPrice;
                        specialOptions.mainFoodID = foodIDInt;
                        specialOptions.numberOfSections = numberOfSections;
                        specialOptions.specialOptions = optionsBySection;
                        specialOptions.sectionHeaders = sectionNameArray;
                        specialOptions.menuCell = self;
                        specialOptions.menuPage = self.menuPage;
                        self.menuPage?.navigationController?.pushViewController(specialOptions, animated: true);
                        
                    }
                }catch{
                    print("error");
                }
            }
        }
    }
    
}
