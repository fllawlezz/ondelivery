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
        self.addSubview(foodNameLabel);
        //need x,y,width,and height
        foodNameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true;
        foodNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        foodNameLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true;
        foodNameLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        foodNameLabel.backgroundColor = UIColor.white;
        
        //add button

        self.addSubview(addButton);
        //need x,y,width,height
        addButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true;
        addButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        addButton.widthAnchor.constraint(equalToConstant: 35).isActive = true;
        addButton.heightAnchor.constraint(equalToConstant: 35).isActive = true;
        addButton.layer.cornerRadius = 17.5;
        addButton.backgroundColor = UIColor.appYellow;
        addButton.addTarget(self, action: #selector(self.addItem), for: .touchUpInside);
        
        //quanityt
        self.addSubview(quantity);
        //need x,y,width,height
        quantity.rightAnchor.constraint(equalTo: addButton.leftAnchor, constant: -5).isActive = true;
        quantity.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        quantity.widthAnchor.constraint(equalToConstant: 30).isActive = true;
        quantity.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        
        //minus button
        
        self.addSubview(minusButton);
        //need x,y,width,height
        minusButton.rightAnchor.constraint(equalTo: quantity.leftAnchor, constant: -5).isActive = true;
        minusButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        minusButton.widthAnchor.constraint(equalToConstant: 35).isActive = true;
        minusButton.heightAnchor.constraint(equalToConstant: 35).isActive = true;
        minusButton.addTarget(self, action: #selector(self.subtractItem), for: .touchUpInside);
        
        //Border
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
        let bottomBar = menuPopup?.menuPage?.menuBottomBar
        
        var count = 0;
        var menuItemArray = menuPopup?.menuPage?.menuItemArray;
        while(count < menuItemArray!.count){
            let mainItem = menuItemArray![count];
            if(mainItem.name == self.foodNameLabel.text!){
                if(mainItem.hasOptions){
                    //go to the optionsPage
                    handleLoadOptions(foodID: Int(mainItem.id!)!, foodPrice: self.mainFoodPrice!);
                }else{
                    numberOfItems! += 1;
                    self.quantity.text = String(numberOfItems!);
//                    let foodItem = mainItem.foodItems[0];
                    let newFoodItem = FoodItem(foodName: self.foodName!, foodPrice: self.mainFoodPrice!, hasOptions: false);
                    
                    mainItem.addQuantity(giveQuantity: 1);
                    mainItem.addPrice(price: self.mainFoodPrice!);
                    mainItem.foodItems.append(newFoodItem);
                    
                    var orderTotal = menuPopup?.menuPage?.totalPrice;
                    orderTotal = orderTotal! + newFoodItem.foodPrice!;
                    menuPopup?.menuPage?.totalPrice = orderTotal!;
                    bottomBar?.setTotalSum(sum: orderTotal!);
                    
                    var bottomBarItemTotal = bottomBar?.getNumber();//number of items
                    bottomBarItemTotal = bottomBarItemTotal! + 1;
                    bottomBar?.setItem(number: bottomBarItemTotal!);
                    
                    
                    return;
                }
            }
            count+=1;
        }
    }
    
    @objc func subtractItem(){
        if(numberOfItems! > 0){
            numberOfItems! -= 1;
            self.quantity.text = String(numberOfItems!);
            let bottomBar = menuPopup?.menuPage?.menuBottomBar
            
            var count = 0;
            var menuItemArray = menuPopup?.menuPage?.menuItemArray;
            while(count < menuItemArray!.count){
                let mainFoodItem = menuItemArray![count];
                if(mainFoodItem.name == self.foodNameLabel.text!){
                    print("mainFoodItemCount:\(mainFoodItem.foodItems.count)");
                    let foodItem = mainFoodItem.foodItems.removeLast();
                    mainFoodItem.subtractQuantity(giveQuantity: 1);
                    mainFoodItem.subtractPrice(price: foodItem.foodPrice!);
                    
                    var orderTotal = menuPopup?.menuPage?.totalPrice;
                    orderTotal = orderTotal! - foodItem.foodPrice!;
                    menuPopup?.menuPage?.totalPrice = orderTotal!;
                    
                    bottomBar?.setTotalSum(sum: orderTotal!);
                    
                    var bottomBarItemTotal = bottomBar?.getNumber();//number of items
                    bottomBarItemTotal = bottomBarItemTotal! - 1;
                    bottomBar?.setItem(number: bottomBarItemTotal!);
                    
                    return;
                }
                count+=1;
            }
        }
    }
    
    fileprivate func handleLoadOptions(foodID: Int, foodPrice: Double){
        let conn = Conn();
        let postBody = "FoodID=\(foodID)"
        conn.connect(fileName: "LoadOptions.php", postString: postBody) { (result) in
            if(urlData != nil){
                do{
                    let json = try JSONSerialization.jsonObject(with: urlData!, options: .allowFragments) as! NSDictionary;
                    //                    print(json);
                    let numSections = json["numberOfSections"] as! String;
                    //                    let foodOptionSections = json["foodOptionSection"] as! NSArray;
                    let extraFoodNames = json["extraFoodNames"] as! NSArray;
                    let extraFoodPrices = json["extraFoodPrices"] as! NSArray;
                    let extraFoodIDs = json["extraFoodIDs"] as! NSArray;
                    let sectionNames = json["sectionNames"] as! NSArray;
                    
                    DispatchQueue.main.async {
                        let numberOfSections = Int(numSections)!
                        
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
                        
                        let foodIDInt =  foodID;
                        
                        let specialOptions = SpecialOptionsPage();
                        specialOptions.mainFoodName = self.foodNameLabel.text!;
                        specialOptions.mainFoodPrice = foodPrice;
                        specialOptions.mainFoodID = foodIDInt;
                        specialOptions.numberOfSections = numberOfSections;
                        specialOptions.specialOptions = optionsBySection;
                        specialOptions.sectionHeaders = sectionNameArray;
                        specialOptions.menuPage = self.menuPopup?.menuPage;
                        self.menuPopup?.menuPage?.navigationController?.pushViewController(specialOptions, animated: true);
                        
                    }
                }catch{
                    print("error");
                }
            }
        }
    }
    
}
