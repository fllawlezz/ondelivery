//
//  SpecialOptionsPage.swift
//  YummyV1
//
//  Created by Brandon In on 7/1/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class SpecialOptionsPage: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextViewDelegate{
    
    var foodTitleLabel: NormalUILabel = {
        let foodTitleLabel = NormalUILabel(textColor: UIColor.black, font: UIFont.montserratSemiBold(fontSize: 18), textAlign: NSTextAlignment.left);
        return foodTitleLabel;
    }()
    
    var addButton: NormalUIButton = {
        let addButton = NormalUIButton(backgroundColor: UIColor.appYellow, title: "Add Food to Cart", font: UIFont.montserratSemiBold(fontSize: 16), fontColor: UIColor.black);
        return addButton;
    }()
    
    var specialOrderField: UITextView = {
        let specialOrderField = UITextView();
        specialOrderField.translatesAutoresizingMaskIntoConstraints = false;
        specialOrderField.text = "Special Request?";
        specialOrderField.textColor = UIColor.gray;
        specialOrderField.font = UIFont.montserratRegular(fontSize: 12);
        specialOrderField.textAlignment = .left;
        specialOrderField.layer.borderWidth = 0.5
        specialOrderField.layer.borderColor = UIColor.gray.cgColor;
        specialOrderField.layer.cornerRadius = 4;
        return specialOrderField;
    }()
    
    fileprivate var borderView: UIView = {
        let borderView = UIView();
        borderView.translatesAutoresizingMaskIntoConstraints = false;
        borderView.backgroundColor = UIColor.lightGray;
        borderView.layer.cornerRadius = 0.25
        borderView.alpha = 0.5
        return borderView;
    }()
    
    var collectionView: UICollectionView!;
    
    //Data
    let reuseOne = "SpecialOptionsCell";
    let reuseTwo = "SpecialOptionsHeader";
    var specialOptions: [[SpecialOption]]!;
    var numberOfSections: Int!;
    var mainFoodName: String?;
    var mainFoodPrice: Double?;
    var mainFoodID: Int?;
    var specialInstructions: String?;
    var sectionHeaders: [String]!
    var menuPage: MenuPage?
    var menuCell: MenuCell?
//    var selectedOptionsArray = [SpecialOption]();
    var selectedIndexPaths = [IndexPath]();
    var selectedOptions = [SpecialOption]();
    
    var orderItemTotal = 0.00;
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white;
        foodTitleSetup();
        collectionViewSetup();
        setUpButton();
        setupTextView();
    }
    
    fileprivate func foodTitleSetup(){
        self.view.addSubview(foodTitleLabel);
        foodTitleLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true;
        foodTitleLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true;
        foodTitleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive = true;
        foodTitleLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true;
        
        self.view.addSubview(borderView);
        borderView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 15).isActive = true;
        borderView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -15).isActive = true;
        borderView.topAnchor.constraint(equalTo: self.foodTitleLabel.bottomAnchor, constant: 5).isActive = true;
        borderView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true;
        
        foodTitleLabel.text = mainFoodName!;
        
    }
    
    fileprivate func collectionViewSetup(){
        let layout = UICollectionViewFlowLayout();
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout);
        collectionView.translatesAutoresizingMaskIntoConstraints = false;
        collectionView.register(SpecialOptionsCell.self, forCellWithReuseIdentifier: reuseOne);
        collectionView.register(SpecialOptionsHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: reuseTwo);
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.backgroundColor = UIColor.white;
        self.view.addSubview(collectionView);
        collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        collectionView.topAnchor.constraint(equalTo: self.borderView.bottomAnchor, constant: 5).isActive = true;
        collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -125).isActive = true;
    }
    
    fileprivate func setUpButton(){
        self.view.addSubview(addButton);
        addButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true;
        addButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true;
        addButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -10).isActive = true;
        addButton.heightAnchor.constraint(equalToConstant: 50).isActive = true;
        addButton.addTarget(self, action: #selector(self.handleAddFood), for: .touchUpInside);
    }
    
    fileprivate func setupTextView(){
        specialOrderField.delegate = self;
        
        self.view.addSubview(specialOrderField);
        specialOrderField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true;
        specialOrderField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true;
        specialOrderField.bottomAnchor.constraint(equalTo: self.addButton.topAnchor, constant: -10).isActive = true;
        specialOrderField.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10).isActive = true;
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.specialOrderField.resignFirstResponder();
        
        let specialInstructions = SpecialInstructionsPage();
        specialInstructions.specialOptionsPage = self;
        self.navigationController?.pushViewController(specialInstructions, animated: true);
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseOne, for: indexPath) as! SpecialOptionsCell;
        let option = specialOptions[indexPath.section];
        let specialOption = option[indexPath.item];
        
        cell.setPrice(price: 0);
        
        cell.setTitle(title: specialOption.specialOptionName);
        if(specialOption.specialOptionPrice > 0){
            cell.setPrice(price: specialOption.specialOptionPrice);
        }
        cell.hideCheckmark();
        
        for selectedIndexPath in self.selectedIndexPaths{
            if(selectedIndexPath == indexPath){
                cell.unhideCheckmark();
            }
        }
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! SpecialOptionsCell
        //add the option to the menu
        hideAllCheckMarks(section: indexPath.section);
        self.selectedIndexPaths.append(indexPath);
        cell.unhideCheckmark();
    }
    
    fileprivate func hideAllCheckMarks(section: Int){
        var count = 0;
        
        let numItemsInSection = specialOptions![section].count;
        while(count < numItemsInSection){
            let indexPath = IndexPath(item: count, section: section);
            if let cell = collectionView.cellForItem(at: indexPath) as? SpecialOptionsCell{
                 cell.hideCheckmark();
            }
            count += 1;
        }
        removeIndexPath(section: section);
    }
    
    func removeIndexPath(section: Int){
        var count = 0;
        while(count<self.selectedIndexPaths.count){
            let selectedIndex = self.selectedIndexPaths[count];
            if(selectedIndex.section == section){
                self.selectedIndexPaths.remove(at: count);
                return;
            }
            count+=1;
        }
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numberOfSections;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let optionArrayCount = self.specialOptions[section].count;
        return optionArrayCount;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 40);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 50);
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: reuseTwo, for: indexPath) as! SpecialOptionsHeader;
        header.setTitle(title: sectionHeaders[indexPath.section]);
        return header;
    }
    
    func handleItemExists(){
        let mainItemArray = menuPage!.menuItemArray;//reference
        for mainItem in mainItemArray{
            if(self.mainFoodName == mainItem.name){
                calculateFoodPrice();
                let foodItem = FoodItem(foodName: self.mainFoodName!, foodPrice: orderItemTotal, hasOptions: true);
                for option in self.selectedOptions{
                    let appendedOption = SpecialOption();
                    appendedOption.specialOptionName = option.specialOptionName;
                    appendedOption.specialOptionPrice = option.specialOptionPrice;
                    appendedOption.specialOptionID = option.specialOptionID;
                    
                    foodItem.options.append(appendedOption);
                }
                
                mainItem.foodItems.append(foodItem);
                mainItem.addPrice(price: orderItemTotal);
                mainItem.addQuantity(giveQuantity: 1);
                updateMenuCell();
                handleMenuAddItem();
                self.menuPage?.navigationController?.popViewController(animated: true);
            }
        }
    }
    
    @objc func handleAddFood(){
        handleItemExists();
        
        let orderItem = MainItem(name: self.mainFoodName!, price: self.mainFoodPrice!, quantity: 1);
        calculateFoodPrice();
        let foodItem = FoodItem(foodName: self.mainFoodName!, foodPrice: orderItemTotal, hasOptions: true);
        for option in self.selectedOptions{
            let appendedOption = SpecialOption();
            appendedOption.specialOptionName = option.specialOptionName;
            appendedOption.specialOptionPrice = option.specialOptionPrice;
            appendedOption.specialOptionID = option.specialOptionID;
            
            foodItem.options.append(appendedOption);
        }
        orderItem.foodItems.append(foodItem);
        self.menuPage?.menuItemArray.append(orderItem);
        
        updateMenuCell();
        handleMenuAddItem();
        
        self.menuPage?.navigationController?.popViewController(animated: true);
    }
    
    fileprivate func updateMenuCell(){
        let quantity = self.menuCell!.totalNumberOfFood + 1;
        self.menuCell!.setQuantity(quantity: quantity);
        self.menuCell!.buttonShown = true;
        self.menuCell?.unhideAddButton();
    }
    
    fileprivate func calculateFoodPrice(){
        orderItemTotal += self.mainFoodPrice!;
        var count = 0;
        while(count < selectedIndexPaths.count){
            let currentIndexPath = selectedIndexPaths[count];
            let currentSection = self.specialOptions[currentIndexPath.section];
            let selectedOption = currentSection[currentIndexPath.item];//selected option
            
            orderItemTotal = orderItemTotal+selectedOption.specialOptionPrice;
            
            selectedOptions.append(selectedOption);
            count+=1;
        }
    }
    
    private func handleMenuAddItem(){
        let menuBottomBar = menuPage?.menuBottomBar;
        let popUpMenu = menuPage?.popUpMenu;
        var orderTotalSum = menuPage?.totalPrice;
        let deliveryPrice = menuPage?.deliveryPrice;
        let freeOrders = menuPage?.freeOrders;
        
        orderTotalSum = orderTotalSum! + self.orderItemTotal;
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
    
}
