//
//  MenuPage.swift
//  YummyV1
//
//  Created by Brandon In on 11/22/17.
//  Copyright © 2017 Rendered Co.RaftPod. All rights reserved.
//

import Foundation
import UIKit
import CallKit

//global for the total
//var totalSum = 0.00;
//var menuItemArray = [MenuItem]();//saves the menu items that are added when added into an array

//var pageNum = 1;// page num is for the navigation bar

class MenuPage: UIViewController, UIGestureRecognizerDelegate, MenuCollectionViewDelegate, MenuPopUpDelegate, MenuBottomBarDelegate, SpecialOptionsPageDelegate, MenuSideBarDelegate{
    
    var selectedRestaurant: Restaurant?;
    var menuItemArray = [MainItem]()
    
    //DATA ELEMENTS
    var menu: Menu?
    var customer = Customer();
    var currentSection = 0;//which section of the menu
    
    var deliveryPrice: Double = 0.0;
    var totalPrice: Double = 0.0;
    
    let reuseIdentifier = "one";
    let reuseIdentifier2 = "two";
    let reuseIdentifier3 = "third";

    var reviewPage: ReviewPage!;
    var collectionView: UICollectionView!;
    var yAnchor: NSLayoutConstraint!;
    private var allFoodsArray = [[Food]]();
    //DATA Elements
    var sectionsTItles: [SectionItem]?
    
    //UI elements
    
    lazy var menuNavBar: MenuNavBar = {
        let navBar = MenuNavBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 40));
        navBar.backgroundColor = UIColor.red;
        navBar.menuPage = self;
        return navBar;
    }()
    
    lazy var menuBottomBar: MenuBottomBar = {
        let bottomBar = MenuBottomBar();
        bottomBar.deliveryPrice = 0;
        bottomBar.backgroundColor = UIColor.white;
//        bottomBar.checkoutButton.addTarget(self, action: #selector(self.checkOut), for: .touchUpInside);
        return bottomBar;
    }()
    
    lazy var popUpMenu: MenuPopUp = {
        let popUpMenu = MenuPopUp();
        popUpMenu.translatesAutoresizingMaskIntoConstraints = false;
        popUpMenu.totalPrice = self.totalPrice;
        return popUpMenu;
    }()
    
    lazy var darkView: UIView = {
        let darkView = UIView();
        darkView.translatesAutoresizingMaskIntoConstraints = false;
        darkView.backgroundColor = UIColor.black;
        darkView.alpha = 0;
        return darkView;
    }()
    
    lazy var menuCollectionView: MenuCollectionView = {
        let layout = UICollectionViewFlowLayout();
        let menuCollectionView = MenuCollectionView(frame: .zero, collectionViewLayout: layout);
        return menuCollectionView;
    }()
    
    
    
    //side bar
    var sideBar: MenuSideBar?;
    var sideBarLeftAnchorConstraint: NSLayoutConstraint?
    var sideBarOut = false;
    
    lazy var sideBarBackground: UIView = {
        let sideBarBackground = UIView();
        sideBarBackground.translatesAutoresizingMaskIntoConstraints = false;
        sideBarBackground.backgroundColor = UIColor.black;
        return sideBarBackground;
    }()
    
    lazy var sectionsBox: UIView = {
        let box1 = UIView();
        box1.translatesAutoresizingMaskIntoConstraints = false;
        box1.backgroundColor = UIColor.black;
        return box1;
    }()
    
    @objc func sideBarAnimate(){
//        pageNum = 1;
        if(sideBarOut){
            sideBarOut = false;
            UIView.animate(withDuration: 0.3) {
                self.sectionsBox.alpha = 1;
                self.sideBarLeftAnchorConstraint?.constant = -1000;
                self.sideBarBackground.alpha = 0;
                self.view.layoutIfNeeded();
            }
        }else{
            sideBarOut = true;
            UIView.animate(withDuration: 0.3) {
                self.sectionsBox.alpha = 0;
                self.sideBarLeftAnchorConstraint?.constant = 0;
                self.sideBarBackground.alpha = 0.7;
                self.view.layoutIfNeeded();
            }
        }
    }
    
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.veryLightGray;
        addObservers();
        
        setupNavBar();
        
        setupCustomer();
        calculateDeliveryFee();
        
        setData();
        setupMenuNavBar();
        setupMenuBottomBar();
        setupMenuCollectionView();
        
        setupSidebar();
        setupSectionsBox();
        
        setupDarkView();
        setupPopUpMenu();
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self);
    }
    
    func addObservers(){
        let addName = Notification.Name(rawValue: addedMenuItemNotification);
        NotificationCenter.default.addObserver(self, selector: #selector(self.addMenuItem(notification:)), name: addName, object: nil);
        
        let removeName = Notification.Name(rawValue: removeMenuItemNotification);
        NotificationCenter.default.addObserver(self, selector: #selector(self.removeFoodItem(notification:)), name: removeName, object: nil);
    }
    
    fileprivate func setupNavBar(){
        
        let leftBackButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil);
        navigationItem.backBarButtonItem = leftBackButton;
        navigationItem.title = "\(selectedRestaurant!.restaurantTitle!)";
    }
    
    fileprivate func setupCustomer(){
        if(user == nil){
            customer.customerName = "none";
            customer.customerPhone = "none";
            customer.customerEmail = "none";
            customer.customerID = "1";
            customer.customerSubPlan = "NONE";
            customer.customerFreeOrders = 0;
        }else{
            customer.customerName = user!.firstName!;
            customer.customerEmail = user!.email!;
            customer.customerPhone = user!.telephone!;
            customer.customerID = user!.userID!;
            customer.customerSubPlan = user!.subscriptionPlan!;
            customer.customerFreeOrders = user!.freeOrders!;
        }
    }
    
    fileprivate func setupMenuCollectionView(){
        self.view.addSubview(menuCollectionView);
        //need x,y,width,and height
        menuCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        menuCollectionView.topAnchor.constraint(equalTo: self.menuNavBar.bottomAnchor).isActive = true;
        menuCollectionView.bottomAnchor.constraint(equalTo: self.menuBottomBar.topAnchor).isActive = true;
        menuCollectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true;
        
        menuCollectionView.foods = self.allFoodsArray;
        
        if let sectionItems = self.menu?.sectionItems{
            menuCollectionView.sectionItems = sectionItems;
        }
        
        if let selectedRestaurant = self.selectedRestaurant{
            menuCollectionView.selectedRestaurant = selectedRestaurant;
        }
        
        menuCollectionView.menuItemArray = self.menuItemArray;
    }
    
    fileprivate func setBottomBarDeliveryPrice(){
        if(customer.customerFreeOrders! > 0 && totalPrice <= 20){
            menuBottomBar.setFreeOrderDeliveryPrice();
        }else{
            menuBottomBar.setDeliveryPrice(price: self.deliveryPrice);
        }
    }
    
    fileprivate func setupMenuNavBar(){
        self.view.addSubview(menuNavBar);
        menuNavBar.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        menuNavBar.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        menuNavBar.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true;
        menuNavBar.heightAnchor.constraint(equalToConstant: 40).isActive = true;
        
        menuNavBar.menuNavBarDelegate = menuCollectionView;
    }
    
    fileprivate func setupMenuBottomBar(){
        //set up the bottom bar
        self.view.addSubview(menuBottomBar);
        menuBottomBar.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true;
        menuBottomBar.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        menuBottomBar.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true;
        menuBottomBar.heightAnchor.constraint(equalToConstant: 60).isActive = true;//60
        
        menuBottomBar.menuBottomBarDelegate = self;
        
        menuBottomBar.setTotalSum(sum: totalPrice);
        self.menuBottomBar.setItem(number: 0);
        setBottomBarDeliveryPrice();
    }
    
    fileprivate func setupDarkView(){
        self.view.addSubview(darkView);
        darkView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        darkView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true;
        darkView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true;
        darkView.rightAnchor.constraint(equalTo:self.view.rightAnchor).isActive = true;
        darkView.isUserInteractionEnabled = true;
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.darkViewTouched));
        darkView.addGestureRecognizer(gesture);
    }
    
    fileprivate func setupPopUpMenu(){
        self.view.addSubview(popUpMenu);
        //need x,y,width,height anchor
        yAnchor = popUpMenu.topAnchor.constraint(equalTo: self.view.bottomAnchor);
        popUpMenu.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        yAnchor.isActive = true;
        popUpMenu.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true;
        popUpMenu.heightAnchor.constraint(equalToConstant: 300).isActive = true;
        
        popUpMenu.itemArray = self.menuItemArray;
        popUpMenu.menuPopUpDelegate = self;
        
        self.view.bringSubview(toFront: menuBottomBar);
    }
    
    fileprivate func setupSidebar(){
        self.view.addSubview(sideBarBackground);
        sideBarBackground.alpha = 0;
        sideBarBackground.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        sideBarBackground.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        sideBarBackground.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true;
        sideBarBackground.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true;
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.sideBarAnimate));
        sideBarBackground.addGestureRecognizer(gestureRecognizer);
        
        
        
        sideBar = MenuSideBar(sectionItems: self.menu!.sectionItems);
        sideBar?.translatesAutoresizingMaskIntoConstraints = false;
        sideBar!.menuPage = self;
        sideBar?.menuSideBarDelegate = self;
        
        self.view.addSubview(sideBar!);
        sideBarLeftAnchorConstraint = sideBar!.leftAnchor.constraint(equalTo:self.view.leftAnchor, constant: -1000);
        sideBarLeftAnchorConstraint!.isActive = true;
        sideBar!.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true;
        sideBar!.widthAnchor.constraint(equalToConstant: self.view.frame.width/2).isActive = true;
        sideBar!.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true;
    }
    
    fileprivate func setupSectionsBox(){
        sectionsBox.isUserInteractionEnabled = true;
        let tapBox = UITapGestureRecognizer(target: self, action: #selector(sideBarAnimate));
        sectionsBox.addGestureRecognizer(tapBox);
        self.view.addSubview(sectionsBox);
        sectionsBox.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        sectionsBox.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true;
        sectionsBox.widthAnchor.constraint(equalToConstant: 30).isActive = true;
        sectionsBox.heightAnchor.constraint(equalToConstant: 70).isActive = true;
    
        let imageView = UIImageView();
        imageView.translatesAutoresizingMaskIntoConstraints = false;
        imageView.image = #imageLiteral(resourceName: "backButtonWhite");
        imageView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi));
        self.sectionsBox.addSubview(imageView);
        imageView.leftAnchor.constraint(equalTo: sectionsBox.leftAnchor).isActive = true;
        imageView.rightAnchor.constraint(equalTo: sectionsBox.rightAnchor).isActive = true;
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true;
        imageView.centerYAnchor.constraint(equalTo: self.sectionsBox.centerYAnchor).isActive = true;
        
    }
    
    //MARK: addressDeliveryFee
    func calculateDeliveryFee(){
            let distance = selectedRestaurant!.restaurantDistance!;
        
            if(distance < 3.0){
                deliveryPrice += 3.99;
            }else if(distance >= 3.0 && distance < 5.0){
                deliveryPrice += 4.99;
            }else if(distance >= 5.0 && distance < 7.0){
                deliveryPrice += 5.99;
            }else if(distance >= 7.0 && distance < 10.0){
                deliveryPrice += 6.99;
            }else if(distance >= 8.0){
                deliveryPrice += 7.99;
            }
        
            if(customer.customerSubPlan! != "NONE"){
                switch(customer.customerSubPlan!){
                case "Standard":
                    deliveryPrice = deliveryPrice - (deliveryPrice*0.2);
                    break;
                case "Premium":
                    deliveryPrice = deliveryPrice - (deliveryPrice*0.3);
                    break;
                case "Executive":
                    deliveryPrice = deliveryPrice - (deliveryPrice*0.4);
                    break;
                default: break;
                }
            }
    }
    
    private func setData(){
        //names,prices, ids, and foodSections from menu into an array of array
        var count = 0;
        while(count<(menu?.numberOfSections!)!){
            let arrayAppend = [Food]()
            allFoodsArray.append(arrayAppend);
            //list array appends food
            count+=1;
        }
        
        for menuItem in menu!.menu{
            //each is a menuDataItem
            let name = menuItem.foodName!;
            let foodID = menuItem.foodID!;
            let price = menuItem.foodPrice!;
            let section = menuItem.foodSection!;
            let hotFood = menuItem.foodIsHot!;
            let pic = menuItem.foodImage!;
            let description = menuItem.foodDescription!;
            let options = menuItem.options!;
            
            let foodItem = Food(nameParam: name, priceParam: price, sectionParam: section, foodID: foodID, hOn: hotFood, pic: pic, description: description, options: options);
            
            allFoodsArray[section-1].append(foodItem);
        }
    }
    
    @objc func darkViewTouched(){
        self.menuCollectionView.reloadData();
        //go through the array list and remove any with teh quantity of zero
        UIView.animate(withDuration: 0.3) {
            self.darkView.alpha = 0;
            self.yAnchor.constant = 0;
            self.view.layoutIfNeeded()
        }
    }
    
    //MARK: run through arraylist and remove any with quantity of zero
    private func minusSearchArray(){
        //search through entire array
        for item in menuItemArray{
            if(item.quantity == 0){// if the quantity is 0, then find the index of the item
                let index = menuItemArray.index(where: { (newItem) -> Bool in
                    newItem.name == item.name
                })//get the index of the item in menuItemArray where the this.foodname.text = item.name
                menuItemArray.remove(at: index!);//remove the item at the menuArray
            }
        }
    }
    
}

extension MenuPage{
    func handleCheckout(deliveryPrice: Double, totalSum: Double) {
        if(self.menuItemArray.count > 0){
            let orderReviewPage = OrderReviewPage();
            orderReviewPage.restaurant = self.selectedRestaurant;
            orderReviewPage.menuItemArray = self.menuItemArray;
            orderReviewPage.totalSum = totalSum;
            orderReviewPage.deliveryCharge = self.deliveryPrice;
            self.navigationController?.pushViewController(orderReviewPage, animated: true);
        }
    }
}


extension MenuPage{
    func makeCall(){
        let actionSheet = UIAlertController(title: nil, message: "Call Restaurant?", preferredStyle: .actionSheet);
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil);
        let callAction = UIAlertAction(title: "Call", style: .default) { (action) in
            var telephoneNumber = self.selectedRestaurant!.restaurantTelephone!.replacingOccurrences(of: "(", with: "");
            telephoneNumber = telephoneNumber.replacingOccurrences(of: ")", with: "");
            telephoneNumber = telephoneNumber.replacingOccurrences(of: "-", with: "");
            let url = URL(string: "tel://\(telephoneNumber)")!;
            UIApplication.shared.open(url, options: [:], completionHandler: nil);
        }
        actionSheet.addAction(cancelAction);
        actionSheet.addAction(callAction);
        self.present(actionSheet, animated: true, completion: nil);
    }
    
    func updateItemArray() {
        self.popUpMenu.itemArray = self.menuItemArray;
        if(self.menuItemArray.count > 0){
            self.popUpMenu.showCollectionView();
        }else{
            self.popUpMenu.hideCollectionView();
        }
    }
    
    func handleShowPopUpMenu() {
        UIView.animate(withDuration: 0.3) {
            self.yAnchor.constant = -360;
            self.darkView.alpha = 0.7;
            self.view.layoutIfNeeded();
        }
    }
    
    func addSpecialFood(mainFoodName: String, mainFoodID: String, mainFoodPrice: Double, orderItemTotal: Double, selectedOptions: [SpecialOption]){
        //mainFoodName, orderItemTotal, has options
        for mainItem in menuItemArray{
            if(mainFoodName == mainItem.name){
                let foodItem = FoodItem(foodName: mainFoodName, foodPrice: orderItemTotal, hasOptions: true);
                for option in selectedOptions{
                    let appendedOption = SpecialOption();
                    appendedOption.specialOptionName = option.specialOptionName;
                    appendedOption.specialOptionPrice = option.specialOptionPrice;
                    appendedOption.specialOptionID = option.specialOptionID;
                    
                    foodItem.options.append(appendedOption);
                }
                
                mainItem.foodItems.append(foodItem);
                mainItem.addPrice(price: orderItemTotal);
                mainItem.addQuantity(giveQuantity: 1);
                //update bottom bar
                updateBottomBar(foodPrice: orderItemTotal);
                reloadCollectionViews();
                return;
            }
        }
        
        //not in the menuItemArray
        addNewSpecialFood(mainFoodName: mainFoodName, mainFoodID: mainFoodID, mainFoodPrice: mainFoodPrice, orderItemTotal: orderItemTotal, selectedOptions: selectedOptions);
       
    }
    
    func addNewSpecialFood(mainFoodName: String, mainFoodID: String, mainFoodPrice: Double, orderItemTotal: Double, selectedOptions: [SpecialOption]){
        let orderItem = MainItem(name: mainFoodName, price: 0, quantity: 1);
        orderItem.id = String(mainFoodID);
        orderItem.itemPrice = mainFoodPrice;
        orderItem.hasOptions = true;
        orderItem.addPrice(price: orderItemTotal);
        
        let foodItem = FoodItem(foodName: mainFoodName, foodPrice: orderItemTotal, hasOptions: true);
        for option in selectedOptions{
            let appendedOption = SpecialOption();
            appendedOption.specialOptionName = option.specialOptionName;
            appendedOption.specialOptionPrice = option.specialOptionPrice;
            appendedOption.specialOptionID = option.specialOptionID;
            
            foodItem.options.append(appendedOption);
        }
        orderItem.foodItems.append(foodItem);
        menuItemArray.append(orderItem);
        //update bottom bar
        updateBottomBar(foodPrice: orderItemTotal);
        reloadCollectionViews();
    }
    
    fileprivate func updateBottomBar(foodPrice: Double){
        let name = Notification.Name(rawValue: updateBottomBarNotification);
        let info = ["foodPrice":foodPrice]
        NotificationCenter.default.post(name: name, object: nil, userInfo: info);
    }
    
    func reloadCollectionViews() {
        self.menuCollectionView.menuItemArray = self.menuItemArray;
        menuCollectionView.reloadData();
        self.updateItemArray();
        
        
    }
    
    
    @objc func removeFoodItem(notification: NSNotification){
        //search through array to find the name
        if let info = notification.userInfo{
            let foodID = info["foodID"] as! Int
            let options = info["hasOptions"] as! Bool
            
            var count = 0;
            while(count<menuItemArray.count){
                let food = menuItemArray[count];
                if(food.id == "\(foodID)"){
                    let subtractedFood = food.foodItems.removeLast();//last food item
                    food.subtractQuantity(giveQuantity: 1);
                    food.subtractPrice(price: subtractedFood.foodPrice!);
                    if(options){
                        self.menuBottomBar.updateBottomBarSubtractSpecialOption(foodPrice: subtractedFood.foodPrice!);
                    }
                    if(food.quantity == 0){
                        menuItemArray.remove(at: count);
                        self.popUpMenu.collectionView.reloadData();
                    }
                }
                count += 1;
            }
            self.menuCollectionView.menuItemArray = self.menuItemArray;
        }
    }
    
    @objc func addMenuItem(notification: NSNotification){
        if let userInfo = notification.userInfo{
            let foodID = userInfo["foodID"] as! Int;
            let foodPrice = userInfo["foodPrice"] as! Double
            let foodName = userInfo["foodName"] as! String
            let hasOptions = userInfo["hasOptions"] as! Bool;
            
            if(hasOptions){
//                print("load options");
                self.handleLoadOptions(foodID: foodID, foodName: foodName, foodPrice: foodPrice);
                return;
            }

            for food in menuItemArray{
                if(food.id == "\(foodID)"){
                    food.addQuantity(giveQuantity: 1);
                    food.addPrice(price: foodPrice);
                    
                    let foodItem = FoodItem(foodName: foodName, foodPrice: foodPrice, hasOptions: false);
                    food.foodItems.append(foodItem);
                    self.menuCollectionView.menuItemArray = self.menuItemArray;
                    
                    //update bottom bar
                    
                    return;
                }
            }
            
            let orderItem = MainItem(name: foodName, price: foodPrice, quantity: 1);
            orderItem.id = "\(foodID)";
            orderItem.itemPrice = foodPrice;
            let foodItem = FoodItem(foodName: foodName, foodPrice: foodPrice, hasOptions: false);
            orderItem.foodItems.append(foodItem);
            menuItemArray.append(orderItem);
            self.menuCollectionView.menuItemArray = self.menuItemArray;
        }
        
    }
    
    func selectSection(currentSection: Int) {
        self.menuNavBar.moveLine(item: 0);
        self.menuCollectionView.currentSection = currentSection;
        self.menuCollectionView.pageNum = 0;
        self.menuCollectionView.reloadData();
        self.sideBarAnimate();
    }
    
}

extension MenuPage{
    
    fileprivate func showError(){
        let alert = UIAlertController(title: "Ugh-Oh!!", message: "There was a problem connecting to our servers! Please try again later", preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            self.navigationController?.popViewController(animated: true);
        }))
    }
    
    func handleLoadOptions(foodID: Int, foodName: String, foodPrice: Double ){
        let url = URL(string: "https://ondeliveryinc.com/LoadOptions.php");
        var request = URLRequest(url: url!);
        let postBody = "FoodID=\(foodID)"
        request.httpMethod = "POST";
        request.httpBody = postBody.data(using: .utf8);
        let task = URLSession.shared.dataTask(with: request) { (data, response, errorOrNil) in
            if errorOrNil != nil{
                DispatchQueue.main.async {
                    self.showError();
                }
            }
            if(data != nil){
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSDictionary;
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
                        
                        let foodIDInt =  foodID;
                        
                        let specialOptions = SpecialOptionsPage();
                        specialOptions.mainFoodName = foodName;
                        specialOptions.mainFoodPrice = foodPrice;
                        specialOptions.mainFoodID = foodIDInt;
                        specialOptions.numberOfSections = numberOfSections;
                        specialOptions.specialOptions = optionsBySection;
                        specialOptions.sectionHeaders = sectionNameArray;
                        specialOptions.delegate = self;
                        self.navigationController?.pushViewController(specialOptions, animated: true);
                        
                    }
                }catch{
                    print("error");
                }
            }
        }
        task.resume();
    }
}
