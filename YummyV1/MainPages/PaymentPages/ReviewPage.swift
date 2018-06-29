//
//  ReviewPage.swift
//  YummyV1
//
//  Created by Brandon In on 12/21/17.
//  Copyright © 2017 Rendered Co.RaftPod. All rights reserved.
//

import Foundation
import UIKit
import CoreData

//MARK: Variables for Payment Cycle
var addressUserText: String!;
var addressIDText: String!;
var deliveryTimeUserText: String!;
var paymentUserText: String!;//last 4 digits of the card
var paymentFullCard: String!;

var cardExpMonth: String!;
var cardExpYear: String!;
var cardCvc: String!;

class ReviewPage: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource{
    
    
    //DATA ELEMENTS
    var deliveryPrice: Double?;
    var taxPrice: Double = 0;
    var totalPrice: Double?;
    
    var selectedRestaurant: Restaurant?
    
    //RestaurantElements
    var restaurantName: String!;
    var restaurantAddress: String!;
    var restaurantTelephone: String!;
    var restaurantPic: UIImage!;
    var restaurantID: String!;
    
    var subPlan: String?
    var freeOrders: Int?
    
    var orderTotal: Double = 0.0;
    let reuse = "one";
    let reuse2 = "two";
    
    var userID: String?
    var email: String?
    
    //names of foods
    var names = [String]()
    //prices
    var prices = [Double]()
    //quantity
    var quantity = [Int]()
    //id
    var id = [String]();
    
    //MARK: TableView arrays
    let tableTitles = ["Address","Delivery Time","Payment","Name","Telephone","Email"];
    let tableImages = ["home","clock","creditCard","profile","phone","email"];
    
    var restName: UILabel!;
    var restAddress: UILabel!;
    var collectionView: UICollectionView!;
    var nextButton: UIButton!;
    var total: UILabel!;
    var deliveryFee: UILabel!;
    var sum: UILabel!;
    var tableView: UITableView!;
    var newNavController: UINavigationController!;
    
    lazy var taxTotal: UILabel = {
        let taxTotal = UILabel();
        taxTotal.translatesAutoresizingMaskIntoConstraints = false;
        taxTotal.font = UIFont(name: "Montserrat-Regular", size: 14);
        taxTotal.textColor = UIColor.black;
        taxTotal.textAlignment = .left;
        return taxTotal;
    }()
    
    var totalChargesView: UIView!;
    var taxPriceFormat: String!;
    
    var customerName: String!;
    var customerPhone: String!;
    var customerEmail: String!;
    
    override func viewDidLoad() {
        customerName = "none";
        customerPhone = "none";
        customerEmail = "none";
        
        //setup data
        if(defaults.string(forKey: "firstName") != nil && addresses.count > 0){
            addressUserText = addresses[0].value(forKey: "address") as! String;
            addressIDText = addresses[0].value(forKey: "addressID") as! String;
        }
        deliveryTimeUserText = "ASAP";
        paymentUserText = "none";
        calculateTotals();
        setup();
    }
    
    private func calculateTotals(){
        if(freeOrders! > 0 && totalPrice! <= 20){
            orderTotal = totalPrice!;
        }else{
                orderTotal = totalPrice! + deliveryPrice!;
        }
        
        taxPrice = totalPrice! * 0.0725;
        taxPriceFormat = String(format: "%.2f", taxPrice);
        taxPrice = Double(taxPriceFormat)!;
        totalPrice = totalPrice! + taxPrice;
        taxTotal.text = "Tax: $\(taxPriceFormat!)";
        
        orderTotal = orderTotal + taxPrice;
    }
    
    private func setup() {
        //format total Sum and then set sum to the total sum
        let formatPayPrice = String(format: "%.2f", orderTotal);
        
        self.view.backgroundColor = UIColor.white;
        self.navigationItem.title = "Summary";
        //restName
        restName = UILabel();
        restName.translatesAutoresizingMaskIntoConstraints = false;
        restName.text = "Resturaunt Name goes here";
        restName.adjustsFontSizeToFitWidth = true;
        restName.numberOfLines = 1;
        restName.minimumScaleFactor = 0.1;
        restName.font = UIFont(name: "Montserrat-SemiBold", size: 16);
        restName.textColor = UIColor.black;
        restName.text = "\(self.restaurantName!)"
        self.view.addSubview(restName);
        //need x,y,width,and height
        restName.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true;
        restName.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10).isActive = true;
        restName.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        restName.heightAnchor.constraint(equalToConstant: 30).isActive = true;
        
        //restAddress
        restAddress = UILabel();
        restAddress.translatesAutoresizingMaskIntoConstraints = false;
        restAddress.text = "Resturaunt Address Goes here"
        restAddress.adjustsFontSizeToFitWidth = true;
        restAddress.minimumScaleFactor = 0.1;
        restAddress.numberOfLines = 1;
        restAddress.font = UIFont(name: "Montserrat-Regular", size: 14);
        restAddress.text = "\(self.restaurantAddress!)"
        self.view.addSubview(restAddress);
        //need x,y,width,height
        restAddress.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true;
        restAddress.topAnchor.constraint(equalTo: self.restName.bottomAnchor).isActive = true;
        restAddress.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        restAddress.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        
        //border
        let border = UIView();
        border.translatesAutoresizingMaskIntoConstraints = false;
        border.backgroundColor = UIColor.black;
        self.view.addSubview(border);
        //x,y,width,height
        border.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        border.topAnchor.constraint(equalTo: self.restAddress.bottomAnchor, constant: 5).isActive = true;
        border.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        border.heightAnchor.constraint(equalToConstant: 0.5).isActive = true;
        
        //nextButton
        nextButton = UIButton(type: .system);
        nextButton.translatesAutoresizingMaskIntoConstraints = false;
        nextButton.setTitle("Pay: $\(formatPayPrice)", for: .normal);
        nextButton.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 20);
        nextButton.setTitleColor(UIColor.black, for: .normal);
        nextButton.backgroundColor = UIColor.appYellow;
        self.view.addSubview(nextButton);
        nextButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        nextButton.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        nextButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true;
        nextButton.heightAnchor.constraint(equalToConstant: 70).isActive = true;
        nextButton.addTarget(self, action: #selector(self.nextPush), for: .touchUpInside);
        
        //border 2
        let border2 = UIView();
        border2.translatesAutoresizingMaskIntoConstraints = false;
        border2.backgroundColor = UIColor.gray;
        self.view.addSubview(border2);
        //need x,y,width,height
        border2.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        border2.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        border2.bottomAnchor.constraint(equalTo: self.nextButton.topAnchor).isActive = true;
        border2.heightAnchor.constraint(equalToConstant: 0.5).isActive = true;
        
        //get info first
        getCollectionViewInfo();
        
        //collectionView
        let layout = UICollectionViewFlowLayout();
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout);
        collectionView.translatesAutoresizingMaskIntoConstraints = false;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.backgroundColor = UIColor.white;
        collectionView.register(ReviewCell.self, forCellWithReuseIdentifier: reuse);
        self.view.addSubview(collectionView);
        //need x,y,width,height
        collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        collectionView.topAnchor.constraint(equalTo: border.bottomAnchor, constant: 10).isActive = true;
        collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
//        collectionView.topAnchor.constraint(equalTo: border.bottomAnchor).isActive = true;
        collectionView.heightAnchor.constraint(equalToConstant: 200).isActive = true;
        
        self.view.addSubview(taxTotal);
        taxTotal.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true;
        taxTotal.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        taxTotal.topAnchor.constraint(equalTo: self.collectionView.bottomAnchor).isActive = true;
        taxTotal.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        
        setupTotalsView();
        
        getTableInfo();
        
        //options list
        tableView = UITableView();
        tableView.translatesAutoresizingMaskIntoConstraints = false;
        tableView.register(OptionsCell.self, forCellReuseIdentifier: reuse2);
        tableView.backgroundColor = UIColor.white;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.alwaysBounceVertical = false;
        self.view.addSubview(tableView);
        //need x,y,width,height
        tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        tableView.bottomAnchor.constraint(equalTo: border2.topAnchor).isActive = true;
//        tableView.heightAnchor.constraint(equalToConstant: 200).isActive = true;
        tableView.topAnchor.constraint(equalTo: self.totalChargesView.bottomAnchor).isActive = true;
        
    }
   
    
    func setupTotalsView(){
        
        let formatDeliveryPrice = String(format: "%.2f", deliveryPrice!);
        let formatTotalPrice = String(format: "%.2f", totalPrice!);
        
        totalChargesView = UIView();
        totalChargesView.translatesAutoresizingMaskIntoConstraints = false;
        totalChargesView.backgroundColor = UIColor.white;
        self.view.addSubview(totalChargesView);
        totalChargesView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        totalChargesView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        totalChargesView.topAnchor.constraint(equalTo: self.taxTotal.bottomAnchor).isActive = true;
        totalChargesView.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        
        //deliveryFee left side
        deliveryFee = UILabel();
        deliveryFee.translatesAutoresizingMaskIntoConstraints = false;
        deliveryFee.font = UIFont(name: "Montserrat-Regular", size: 14);
        deliveryFee.textColor = UIColor.black;
        deliveryFee.textAlignment = .left;
        //        deliveryFee.backgroundColor = UIColor.black;
        self.totalChargesView.addSubview(deliveryFee);
        deliveryFee.leftAnchor.constraint(equalTo: self.totalChargesView.leftAnchor,constant: 20).isActive = true;
        deliveryFee.widthAnchor.constraint(equalToConstant: self.view.frame.width*0.5).isActive = true;
        deliveryFee.centerYAnchor.constraint(equalTo: self.totalChargesView.centerYAnchor).isActive = true;
        deliveryFee.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        
        if(freeOrders! > 0 && totalPrice! <= 20.0){
            deliveryFee.text = "Delivery Fee: 1 free order";
        }else{
            deliveryFee.text = "Delivery Fee: $\(formatDeliveryPrice)";
        }
        
        //totalSum: Right Side
        sum = UILabel();
        sum.translatesAutoresizingMaskIntoConstraints = false;
        sum.textColor = UIColor.red;
        sum.textAlignment = .center;
        sum.font = UIFont(name: "Montserrat-Regular", size: 14);
        self.totalChargesView.addSubview(sum);
        //need x,y,width,and height
        sum.rightAnchor.constraint(equalTo: self.totalChargesView.rightAnchor).isActive = true;
        sum.centerYAnchor.constraint(equalTo: deliveryFee.centerYAnchor).isActive = true;
        sum.widthAnchor.constraint(equalToConstant: 75).isActive = true;
        sum.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        sum.text = "$\(formatTotalPrice)";
        
        //total: Left Side
        total = UILabel();
        total.translatesAutoresizingMaskIntoConstraints = false;
        total.text = "Total:"
        total.font = UIFont(name: "Montserrat-SemiBold", size: 14);
        total.textColor = UIColor.black;
        total.textAlignment = .right;
        self.totalChargesView.addSubview(total);
        //need x,y,width,height
        total.topAnchor.constraint(equalTo: totalChargesView.topAnchor).isActive = true;
        total.leftAnchor.constraint(equalTo: deliveryFee.rightAnchor).isActive = true;
        total.rightAnchor.constraint(equalTo: self.sum.leftAnchor).isActive = true;
        total.heightAnchor.constraint(equalToConstant: 25).isActive = true;
    }
}






