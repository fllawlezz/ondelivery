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
var menuItemArray = [MenuItem]();//saves the menu items that are added when added into an array

var pageNum = 1;// page num is for the navigation bar
var finalDeliveryPrice = 0.00;

class MenuPage: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate{
    
    var subPlan: String = "NONE";
    var freeOrders: Int = 1;
    
    var selectedRestaurant: Restaurant?;
    var menuItemArray = [MenuItem]();
    
    //DATA ELEMENTS
    var menu: Menu?
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
    
    lazy var navBar: MenuNavBar = {
        let navBar = MenuNavBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 40));
        navBar.backgroundColor = UIColor.red;
        navBar.menuPage = self;
        return navBar;
    }()
    
    lazy var menuBottomBar: MenuBottomBar = {
        let bottomBar = MenuBottomBar();
        bottomBar.deliveryPrice = 0;
        bottomBar.backgroundColor = UIColor.white;
        bottomBar.checkoutButton.addTarget(self, action: #selector(self.checkOut), for: .touchUpInside);
        return bottomBar;
    }()
    
    lazy var popUpMenu: MenuPopUp = {
        let popUpMenu = MenuPopUp();
        popUpMenu.translatesAutoresizingMaskIntoConstraints = false;
        popUpMenu.totalPrice = self.totalPrice;
        popUpMenu.menuPage = self;
        return popUpMenu;
    }()
    
    lazy var darkView: UIView = {
        let darkView = UIView();
        darkView.translatesAutoresizingMaskIntoConstraints = false;
        darkView.backgroundColor = UIColor.black;
        darkView.alpha = 0.0;
        return darkView;
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
        let leftBackButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil);
        navigationItem.backBarButtonItem = leftBackButton;
        navigationItem.title = "\(selectedRestaurant!.restaurantTitle!)";
        
        calculateDeliveryFee();
        self.view.backgroundColor = UIColor.white;
        let inset = UIEdgeInsets(top: 40, left: 0, bottom: 60, right: 0);
        self.collectionView?.contentInset = inset;
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 40, left: 0, bottom: 60, right: 0);
        self.collectionView?.backgroundColor = UIColor.white;
        
        setData();
        setup();
    }
    
    fileprivate func setBottomBarDeliveryPrice(){
        if(freeOrders > 0 && totalPrice <= 20){
            menuBottomBar.setFreeOrderDeliveryPrice();
        }else{
            menuBottomBar.setDeliveryPrice(price: self.deliveryPrice);
        }
    }
    
    fileprivate func setup(){
        self.view.addSubview(navBar);
        //set up the bottom bar
        menuBottomBar.translatesAutoresizingMaskIntoConstraints = false;
        self.view.addSubview(menuBottomBar);
        menuBottomBar.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true;
        menuBottomBar.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        menuBottomBar.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true;
        menuBottomBar.heightAnchor.constraint(equalToConstant: 60).isActive = true;//60
        
        menuBottomBar.setTotalSum(sum: totalPrice);
        self.menuBottomBar.setItem(number: 0);
        
        setBottomBarDeliveryPrice();
        
        //        tap gesture to show menu view for when the cart is clicked
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.showCart));
        tapGesture.numberOfTapsRequired = 1;
        menuBottomBar.imageView.isUserInteractionEnabled = true;
        menuBottomBar.imageView.addGestureRecognizer(tapGesture);
        
        //collectionView initialization
        let layout = UICollectionViewFlowLayout();
        layout.headerReferenceSize = CGSize(width: self.view.frame.width, height: 30);
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout);
        collectionView.translatesAutoresizingMaskIntoConstraints = false;
        collectionView.backgroundColor = UIColor.white;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: self.reuseIdentifier);
        self.collectionView?.register(InfoCell.self, forCellWithReuseIdentifier: reuseIdentifier2);
        collectionView.register(CollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: reuseIdentifier3);
        self.view.addSubview(collectionView);
        //need x,y,width,and height
        collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        collectionView.topAnchor.constraint(equalTo: self.navBar.bottomAnchor).isActive = true;
        collectionView.bottomAnchor.constraint(equalTo: self.menuBottomBar.topAnchor).isActive = true;
        collectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true;
        
        self.view.addSubview(darkView);
        darkView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        darkView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true;
        darkView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true;
        darkView.rightAnchor.constraint(equalTo:self.view.rightAnchor).isActive = true;
        darkView.isUserInteractionEnabled = true;
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.darkViewTouhced));
        darkView.addGestureRecognizer(gesture);
        
        setupSidebar();
        setupSectionsBox();
        
        //popUpMenu
        self.view.addSubview(popUpMenu);
        //need x,y,width,height anchor
        yAnchor = popUpMenu.topAnchor.constraint(equalTo: self.view.bottomAnchor);
        popUpMenu.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        yAnchor.isActive = true;
        popUpMenu.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true;
        popUpMenu.heightAnchor.constraint(equalToConstant: 300).isActive = true;
        
        self.view.bringSubview(toFront: menuBottomBar);
        
        navBar.setCollectionViewReference(collectionView: collectionView);
        
        //give botbar reference to popUpMenu
//        popUpMenu.passBotBarReference(reference: menuButtonBar);
        
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
            }else if(distance >= 7.0 && distance < 8.0){
                deliveryPrice += 6.99;
            }else if(distance >= 8.0){
                deliveryPrice += 7.99;
            }
        
        if(subPlan != nil){
            if(subPlan != "NONE"){
                switch(subPlan){
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
    
    
    @objc func showCart(sender: UITapGestureRecognizer){
        if(menuItemArray.count == 0){
            popUpMenu.collectionView.isHidden = true;
        }else{
            popUpMenu.collectionView.isHidden = false;
        }
        self.popUpMenu.collectionView.reloadData();
        UIView.animate(withDuration: 0.3) {
            self.darkView.alpha = 0.7;
            self.yAnchor.constant = -360;
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func checkOut(){
        if(menuItemArray.count > 0){
            let reviewPage = ReviewPage();
            reviewPage.deliveryPrice = self.deliveryPrice;
            reviewPage.totalPrice = self.totalPrice;
            
            reviewPage.selectedRestaurant = self.selectedRestaurant!;
            
            let leftBackButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil);
            navigationController?.navigationBar.topItem?.backBarButtonItem = leftBackButton;
            navigationController?.pushViewController(reviewPage, animated: true);
        }
    }
    
    @objc func darkViewTouhced(){
        minusSearchArray();
        self.collectionView?.reloadData();
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
    
    //MARK: Button targets
    //MenuAddButton
    @objc private func addItem(indexPath: IndexPath, price: Double){
        
    }
    
    //MENUSubtractButton
    @objc private func subItem(indexPath: IndexPath, price: Double){
    }
    
    //MARK: FoodsList
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //Page Num is not 3
        if(pageNum != 3){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MenuCell;
            //model CELL: shown = false, hidden
            cell.menuPage = self;
            cell.buttonShown = false;//set shown = to false.
            cell.hideButton();//hide the minus and the label
            cell.setQuantity(quantity: 0);//reset the quantity to zero
            
            if(pageNum == 1){
                //if hotFoods
                let foodArray = allFoodsArray[currentSection];
                let food = foodArray[indexPath.item];
                cell.setName(name: food.name!);
                cell.setPrice(charge: food.price!);
                cell.setFoodID(id: food.id!);
                cell.foodImage.image = food.image!;
                cell.setDescription(description: food.descript!);
                cell.cellSection = indexPath.section;
                cell.cellIndex = indexPath.section;
                if(food.options == "Y"){
                    cell.options = true;
                }
//                if(food.options == "Y"){
//                    cell.hideAddButton();
//                }
                //if food is selected then set orders and
                
            }else if(pageNum == 2){
                //do that
                var count = 0;//count to run through array
                while(count<allFoodsArray.count){
                    if(indexPath.section == count){
                        let sectionArray = allFoodsArray[count];
                        let food = sectionArray[indexPath.item];
                        
                        cell.setName(name: food.name!);
                        cell.setPrice(charge: food.price!);
                        cell.setFoodID(id: food.id!);
                        cell.foodImage.image = food.image!;
                        cell.setDescription(description: food.descript!);
                        cell.cellSection = indexPath.section;
                        cell.cellIndex = indexPath.section;
                    }
                    count+=1;
                }
            }
            
            //MARK: Hide/unhide minus button and update quantity
            //check if the menu item is in the menuItem array
            for item in self.menuItemArray{//for every item in the menuItemArray
                if(item.name == cell.foodName.text!){//if the names are the same
                    if(item.quantity != 0){
                        cell.buttonShown = true;//shown = true to notify that the cell minus and plus are unhidden
                        cell.unhideAddButton();//make sure to unhide the minus and the quantity indicator
                        cell.setQuantity(quantity: item.quantity);//set the quantity to the actual menu Item quantity
                    }
                }
            }
            return cell;
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier2, for: indexPath) as! InfoCell;
            if(indexPath.item == 0){
                cell.setTitle(text: self.selectedRestaurant!.restaurantTelephone!);
                cell.phoneImage.isHidden = false;
                cell.makeCallClosure = {
                    self.makeCall();
                }
            }else if(indexPath.item == 1){
                cell.setTitle(text: self.selectedRestaurant!.restaurantAddress!);
                cell.phoneImage.isHidden = true;
            }else{
                cell.setTitle(text: "\(self.selectedRestaurant!.restaurantOpenHour!)-\(self.selectedRestaurant!.restaurantCloseHour!)");
                cell.phoneImage.isHidden = true;
            }
            
            return cell;
        }
    }
    
    private func makeCall(){
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
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if(pageNum == 2){
            return CGSize(width: self.view.frame.width, height: 30);
        }else{
            return CGSize(width: self.view.frame.width, height: 30);
        }
    }
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if(pageNum == 1){
            return 1;
        }else if(pageNum == 2){
            return allFoodsArray.count;
        }else if(pageNum == 3){
            return 1
        }else{
            return 1;
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(pageNum == 1){
            let array = allFoodsArray[currentSection];
            return array.count;
        }else if(pageNum == 2){
            let array = allFoodsArray[section];
            return array.count;
        }else if(pageNum == 3){
            return 3;
        }
        return 1;
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(pageNum != 3){
            return CGSize(width: self.view.frame.width, height: 110);
        }else{
            return CGSize(width: self.view.frame.width, height: 40);
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reuseIdentifier3, for: indexPath) as! CollectionViewHeader;
        headerView.frame.size.height = 30;
        headerView.backgroundColor = UIColor.veryLightGray;
        if(pageNum == 1){
            let sectionItem = self.menu!.sectionItems[self.currentSection];
            let sectionName = sectionItem.sectionTitle!;
            headerView.setTitle(string: sectionName);
        }else if(pageNum == 2){
            let index = indexPath.section;
            let sectionItem = self.menu!.sectionItems[index];
            let sectionName = sectionItem.sectionTitle!;
            headerView.setTitle(string: sectionName);
        }
        return headerView;
    }
    
    
}

