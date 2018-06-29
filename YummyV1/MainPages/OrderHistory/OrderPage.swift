//
//  OrderPage.swift
//  YummyV1
//
//  Created by Brandon In on 11/20/17.
//  Copyright © 2017 Rendered Co.RaftPod. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class OrderPage: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    private let reuseCell = "cell";
    private let reuseCell2 = "cell2";
    
    var pastOrders: [PastOrder]?
    var timer: Timer!;
    
    override func viewDidLoad() {
        self.collectionView?.register(OrderPageCell.self, forCellWithReuseIdentifier: reuseCell);
        self.collectionView?.register(OrderPageNone.self, forCellWithReuseIdentifier: reuseCell2);
        self.collectionView?.backgroundColor = UIColor.gray;
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(pastOrders!.count > 0){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseCell, for: indexPath) as! OrderPageCell
            let pastOrder = pastOrders![indexPath.item];
            cell.setTitle(title: pastOrder.restaurantName!);
            cell.setPrice(priceValue: Double(pastOrder.totalSum!)!);
            cell.setDate(dateString: pastOrder.orderDate!);
            return cell;
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseCell2, for: indexPath) as! OrderPageNone
            
            return cell;
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(pastOrders!.count == 0){
            return 1;
        }else{
            return pastOrders!.count;
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 150)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("orderReload data");
        self.collectionView?.reloadData();
    }
    
    private func loadImages(url: String!)-> UIImage{
        let url = URL(string: url);
        let data = try? Data(contentsOf: url!);
        let image = UIImage(data: data!);
        return image!;
        
    }
    
    private class OrderPageNone: UICollectionViewCell{
        
        var messageLabel: UILabel!;
        
        override init(frame: CGRect) {
            super.init(frame: frame);
            messageLabel = UILabel();
            messageLabel.translatesAutoresizingMaskIntoConstraints = false;
            messageLabel.text = "You do not have any past orders";
            messageLabel.font = UIFont(name: "Montserrat-Regular", size: 20);
            messageLabel.numberOfLines = 1;
            messageLabel.adjustsFontSizeToFitWidth = true;
            messageLabel.minimumScaleFactor = 0.1;
            messageLabel.textAlignment = .center;
            messageLabel.textColor = UIColor.black;
            self.addSubview(messageLabel);
            messageLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true;
            messageLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true;
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
            messageLabel.heightAnchor.constraint(equalToConstant: 150).isActive = true;
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError();
        }
    }
    
    
    
}

class OrderPageCell: UICollectionViewCell{
    
    var restTitle: UILabel!;
    var restImage: UIImageView!;
    var price: UILabel!;
    var date: UILabel!;
    var expand: UIButton!;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        setup();
        self.backgroundColor = UIColor.white;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    private func setup(){
        
        restTitle = UILabel();
        restTitle.text = "Restaurant name here"
        restTitle.font = UIFont(name: "Montserrat-SemiBold", size: 16);
        restTitle.translatesAutoresizingMaskIntoConstraints = false;
        self.addSubview(restTitle);
        //need x,y,width,height constraints
        restTitle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true;
        restTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true;
        restTitle.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true;
        restTitle.heightAnchor.constraint(equalToConstant: 30).isActive = true;
        
        
        let border2 = UIView();
        border2.frame = CGRect(x: 0, y: 40, width: self.frame.width, height: 0.5);
        border2.backgroundColor = UIColor.lightGray;
        self.addSubview(border2);
        
        restImage = UIImageView();
        restImage.backgroundColor = UIColor.red;
        restImage.translatesAutoresizingMaskIntoConstraints = false;
        self.addSubview(restImage);
        restImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true;
        restImage.topAnchor.constraint(equalTo: border2.bottomAnchor, constant: 5).isActive = true;
        restImage.widthAnchor.constraint(equalToConstant: 90).isActive = true;
        restImage.heightAnchor.constraint(equalToConstant: 70).isActive = true;
        
        price = UILabel();
        price.text = "$10.82";
        price.font = UIFont(name: "Montserrat-Regular", size: 16);
        price.translatesAutoresizingMaskIntoConstraints = false;
        self.addSubview(price);
        price.leftAnchor.constraint(equalTo: restImage.rightAnchor, constant: 5).isActive = true;
        price.topAnchor.constraint(equalTo: border2.bottomAnchor, constant: 5).isActive = true;
        price.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true;
        price.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        
        
        date = UILabel();
        date.text = "Jan 1, 2017 9:55PM";
        date.font = UIFont(name: "Montserrat-Regular", size: 16);
        date.translatesAutoresizingMaskIntoConstraints = false;
        self.addSubview(date);
        date.leftAnchor.constraint(equalTo: restImage.rightAnchor, constant: 5).isActive = true;
        date.topAnchor.constraint(equalTo: price.bottomAnchor).isActive = true;
        date.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        date.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        
        //buttom layer
        let border = CALayer();
        let width = CGFloat(0.25);
        border.borderColor = UIColor.gray.cgColor;
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: self.frame.size.height);
        border.borderWidth = width;
        self.layer.addSublayer(border);
        self.layer.masksToBounds = true;
    }
    
    func setTitle(title: String){
        restTitle.text = title;
    }
    
    func setImage(file: String){
        restImage.image = UIImage(named: file);
    }

    func setPrice(priceValue: Double){
        let priceString = String(format: "%.2f", priceValue);
        price.text = "$"+priceString;
    }
    
    func setDate(dateString: String){
        date.text = dateString;
    }
}
