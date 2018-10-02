//
//  SpecialOptionsPage.swift
//  YummyV1
//
//  Created by Brandon In on 7/1/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

protocol SpecialOptionsPageDelegate{
//    func reloadCollectionViews();
//    func addExistedSpecialFood(mainFoodName: String, mainFoodID: String, mainFoodPrice: Double, orderItemTotal: Double, selectedOptions: [SpecialOption])
    func addSpecialFood(mainFoodName: String, mainFoodID: String, mainFoodPrice: Double, orderItemTotal: Double, selectedOptions: [SpecialOption])
}

class SpecialOptionsPage: UIViewController, UITextViewDelegate{
    
    var delegate: SpecialOptionsPageDelegate?;
    
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
    
    lazy var collectionView: SpecialOptionsCollectionView = {
        let layout = UICollectionViewFlowLayout();
        let collectionView = SpecialOptionsCollectionView(frame: .zero, collectionViewLayout: layout);
        return collectionView;
    }()
    
//    var collectionView: UICollectionView!;
    
    //Data
    var mainItemArray:[MainItem]?
    
    var specialOptions: [[SpecialOption]]!;
    var numberOfSections: Int!;
    var mainFoodName: String?;
    var mainFoodPrice: Double?;
    var mainFoodID: Int?;
    var specialInstructions: String?;
    var sectionHeaders: [String]!
    var menuCell: MenuCell?
    var selectedIndexPaths = [IndexPath]();
    var selectedOptions = [SpecialOption]();
    var itemExists = false;
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
        self.view.addSubview(collectionView);
        collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        collectionView.topAnchor.constraint(equalTo: self.borderView.bottomAnchor, constant: 5).isActive = true;
        collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -125).isActive = true;
        
        collectionView.numOfSections = self.numberOfSections;
        collectionView.specialOptions = self.specialOptions;
        collectionView.sectionHeaders = self.sectionHeaders;
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
    
    @objc func handleAddFood(){
        //get options
        getOptions();
//        self.selectedOptions = self.collectionView.selectedOptions;
        if(selectedOptions.count > 0){
            calculateFoodPrice();
            
            if let delegate = self.delegate{
                delegate.addSpecialFood(mainFoodName: self.mainFoodName!, mainFoodID: "\(self.mainFoodID!)", mainFoodPrice: self.mainFoodPrice!, orderItemTotal: orderItemTotal, selectedOptions: selectedOptions);
            }
            self.navigationController?.popViewController(animated: true);
        }
    }
    
    func getOptions(){
        self.selectedIndexPaths = self.collectionView.selectedIndexPaths;
        for indexPath in selectedIndexPaths{
            let optionSection = specialOptions[indexPath.section];//this is the section
            let specialOption = optionSection[indexPath.item];//specialOption
            self.selectedOptions.append(specialOption);
        }
    }
    
    func handleItemExists(){
        calculateFoodPrice();
        
        if let delegate = self.delegate{
            delegate.addSpecialFood(mainFoodName: self.mainFoodName!, mainFoodID: "\(self.mainFoodID!)", mainFoodPrice: self.mainFoodPrice!, orderItemTotal: orderItemTotal, selectedOptions: selectedOptions);
        }
    }
    
    fileprivate func updateMenuCell(){
        let quantity = (self.menuCell?.totalNumberOfFood)! + 1;
        self.menuCell?.setQuantity(quantity: quantity);
        self.menuCell?.buttonShown = true;
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
        print(orderItemTotal);
        
    }
    
    
    
}
