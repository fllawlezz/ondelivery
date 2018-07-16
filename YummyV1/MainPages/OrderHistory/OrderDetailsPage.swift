//
//  OrderDetailsPage.swift
//  YummyV1
//
//  Created by Brandon In on 7/16/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class OrderDetailsPage: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    var restaurantName: String?
    var date: String?
    var orderSum: Double?;
    
    var orderFoods:[OrderHistoryItem]?
    
    var border: UIView = {
        let border = UIView();
        border.translatesAutoresizingMaskIntoConstraints = false;
        border.backgroundColor = UIColor.gray;
        return border;
    }()
    
    var dateLabel: NormalUILabel = {
        let dateLabel = NormalUILabel(textColor: UIColor.black, font: UIFont.montserratSemiBold(fontSize: 16), textAlign: .left);
        return dateLabel;
    }()
    
    var totalSumLabel: NormalUILabel = {
        let totalSumLabel = NormalUILabel(textColor: UIColor.red, font: UIFont.montserratSemiBold(fontSize: 14), textAlign: .left);
        return totalSumLabel;
    }()
    
    var collectionView: UICollectionView!;
    var reuse = "one";
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white;
        setupNavBar();
        setupDate();
        setupTotalSumLabel();
        setupBorder();
        setupCollectionView();
    }
    
    fileprivate func setupNavBar(){
        self.navigationItem.title = restaurantName!;
    }
    
    fileprivate func setupDate(){
        self.view.addSubview(dateLabel);
        dateLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true;
        dateLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        dateLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10).isActive = true;
        dateLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true;
        
        dateLabel.text = date!;
    }
    
    fileprivate func setupTotalSumLabel(){
        self.view.addSubview(totalSumLabel);
        totalSumLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true;
        totalSumLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 10).isActive = true;
        totalSumLabel.topAnchor.constraint(equalTo: self.dateLabel.bottomAnchor, constant: 5).isActive = true;
        totalSumLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        
        totalSumLabel.text = "$\(orderSum!)"
    }
    
    fileprivate func setupBorder(){
        self.view.addSubview(border);
        border.topAnchor.constraint(equalTo: self.totalSumLabel.bottomAnchor, constant: 10).isActive = true;
        border.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        border.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        border.heightAnchor.constraint(equalToConstant: 0.5).isActive = true;
    }
    
    fileprivate func setupCollectionView(){
        let layout = UICollectionViewFlowLayout();
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout);
        collectionView.translatesAutoresizingMaskIntoConstraints = false;
        collectionView.register(OrderDetailsCell.self, forCellWithReuseIdentifier: reuse);
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.backgroundColor = UIColor.white;
        self.view.addSubview(collectionView);
        collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        collectionView.topAnchor.constraint(equalTo: self.border.bottomAnchor, constant: 10).isActive = true;
        collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -60).isActive = true;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuse, for: indexPath) as! OrderDetailsCell;
        let item = self.orderFoods![indexPath.item];
        cell.setTitle(foodTitle: item.foodName!);
        cell.setQuantity(foodQuantity: String(item.foodQuantity!));
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.orderFoods!.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 50);
    }
    
}
