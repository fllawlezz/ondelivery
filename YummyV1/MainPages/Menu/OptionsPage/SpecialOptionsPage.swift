//
//  SpecialOptionsPage.swift
//  YummyV1
//
//  Created by Brandon In on 7/1/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class SpecialOptionsPage: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    var foodTitleLabel: NormalUILabel = {
        let foodTitleLabel = NormalUILabel(textColor: UIColor.black, font: UIFont.montserratSemiBold(fontSize: 20), textAlign: NSTextAlignment.left);
        return foodTitleLabel;
    }()
    
    var addButton: NormalUIButton = {
        let addButton = NormalUIButton(backgroundColor: UIColor.appYellow, title: "Add Food to Cart", font: UIFont.montserratSemiBold(fontSize: 16), fontColor: UIColor.black);
        return addButton;
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
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white;
        foodTitleSetup();
        collectionViewSetup();
        setUpButton();
    }
    
    fileprivate func foodTitleSetup(){
        self.view.addSubview(foodTitleLabel);
        foodTitleLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true;
        foodTitleLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true;
        foodTitleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10).isActive = true;
        foodTitleLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true;
        
        self.view.addSubview(borderView);
        borderView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 15).isActive = true;
        borderView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -15).isActive = true;
        borderView.topAnchor.constraint(equalTo: self.foodTitleLabel.bottomAnchor, constant: 5).isActive = true;
        borderView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true;
        
        foodTitleLabel.text = "Food Name Goes right here";
        
    }
    
    fileprivate func collectionViewSetup(){
        let layout = UICollectionViewFlowLayout();
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout);
        collectionView.translatesAutoresizingMaskIntoConstraints = false;
        collectionView.register(SpecialOptionsCell.self, forCellWithReuseIdentifier: reuseOne);
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.backgroundColor = UIColor.white;
        self.view.addSubview(collectionView);
        collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        collectionView.topAnchor.constraint(equalTo: self.borderView.bottomAnchor, constant: 5).isActive = true;
        collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -70).isActive = true;
    }
    
    fileprivate func setUpButton(){
        self.view.addSubview(addButton);
        addButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true;
        addButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true;
        addButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -10).isActive = true;
        addButton.heightAnchor.constraint(equalToConstant: 50).isActive = true;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseOne, for: indexPath) as! SpecialOptionsCell;
        cell.setTitle(title: "FoodName");
        return cell;
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1;
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
    
}
