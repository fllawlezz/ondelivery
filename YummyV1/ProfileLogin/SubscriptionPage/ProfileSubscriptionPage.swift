//
//  ProfileSubscriptionPage.swift
//  YummyV1
//
/*
 Show # of free orders left, # of clues
 */
//  Created by Brandon In on 3/29/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class ProfileSubscriptionPage: UIViewController{
    
    var popUpTopAnchor: NSLayoutConstraint!;
    
    lazy var ordersView: UIView = {
        let ordersView = UIView();
        ordersView.translatesAutoresizingMaskIntoConstraints = false;
        ordersView.backgroundColor = UIColor.white;
        return ordersView;
    }()
    
    lazy var numberOfOrdersTitle: UILabel = {
        let numberOfOrdersTitle = UILabel();
        numberOfOrdersTitle.translatesAutoresizingMaskIntoConstraints = false;
        numberOfOrdersTitle.text = "# of Orders:";
        numberOfOrdersTitle.font = UIFont(name: "Montserrat-SemiBold", size: 16);
        numberOfOrdersTitle.textAlignment = .center;
        numberOfOrdersTitle.textColor = UIColor.black;
        numberOfOrdersTitle.adjustsFontSizeToFitWidth = true;
        numberOfOrdersTitle.numberOfLines = 1;
        numberOfOrdersTitle.minimumScaleFactor = 0.1;
        numberOfOrdersTitle.text = "# of Orders: ";
        return numberOfOrdersTitle;
    }()
    
    lazy var numberOfOrders: UILabel = {
        let numberOfOrders = UILabel();
        numberOfOrders.translatesAutoresizingMaskIntoConstraints = false;
        numberOfOrders.textAlignment = .center;
        numberOfOrders.text = "\(user!.freeOrders!)";
        numberOfOrders.font = UIFont(name: "Montserrat-Regular", size: 16);
        numberOfOrders.textColor = UIColor.black;
        return numberOfOrders;
    }()
    
    lazy var subscriptionView: UIView = {
        let subscriptionView = UIView();
        subscriptionView.translatesAutoresizingMaskIntoConstraints = false;
        subscriptionView.backgroundColor = UIColor.white;
        return subscriptionView;
    }()
    
    lazy var subscriptionTypeLabel: UILabel = {
        let subscriptionTypeLabel = UILabel();
        subscriptionTypeLabel.translatesAutoresizingMaskIntoConstraints = false;
        subscriptionTypeLabel.font = UIFont(name: "Montserrat-SemiBold", size: 16);
        subscriptionTypeLabel.textColor = UIColor.black;
        subscriptionTypeLabel.textAlignment = .center;
        subscriptionTypeLabel.minimumScaleFactor = 0.1;
        subscriptionTypeLabel.adjustsFontSizeToFitWidth = true;
        subscriptionTypeLabel.numberOfLines = 1;
        subscriptionTypeLabel.text = "Subscription Type: ";
        return subscriptionTypeLabel;
    }()
    
    lazy var subscriptionPayingLabel: UILabel = {
        let subscriptionPayingLabel = UILabel();
        subscriptionPayingLabel.translatesAutoresizingMaskIntoConstraints = false;
        subscriptionPayingLabel.font = UIFont(name: "Montserrat-Regular", size: 16);
        subscriptionPayingLabel.textAlignment = .center;
        subscriptionPayingLabel.textColor = UIColor.black;
        subscriptionPayingLabel.minimumScaleFactor = 0.1;
        subscriptionPayingLabel.adjustsFontSizeToFitWidth = true;
        subscriptionPayingLabel.numberOfLines = 1;
        return subscriptionPayingLabel;
    }()
    
    lazy var perMonthChargeView: UIView = {
        let perMonthChargeView = UIView();
        perMonthChargeView.translatesAutoresizingMaskIntoConstraints = false;
        perMonthChargeView.backgroundColor = UIColor.white;
        return perMonthChargeView;
    }()
    
    lazy var perMonthChargeLabel: UILabel = {
        let perMonthChargeLabel = UILabel();
        perMonthChargeLabel.translatesAutoresizingMaskIntoConstraints = false;
        perMonthChargeLabel.font = UIFont(name: "Montserrat-SemiBold", size: 16);
        perMonthChargeLabel.textColor = UIColor.black;
        perMonthChargeLabel.textAlignment = .center;
        perMonthChargeLabel.minimumScaleFactor = 0.1;
        perMonthChargeLabel.adjustsFontSizeToFitWidth = true;
        perMonthChargeLabel.numberOfLines = 1;
        perMonthChargeLabel.text = "Price/Month: "
        return perMonthChargeLabel;
    }()
    
    lazy var perMonthChargeAmount: UILabel = {
        let perMonthChargeAmount = UILabel();
        perMonthChargeAmount.translatesAutoresizingMaskIntoConstraints = false;
        perMonthChargeAmount.font = UIFont(name: "Montserrat-Regular", size: 16);
        perMonthChargeAmount.textAlignment = .center;
        perMonthChargeAmount.textColor = UIColor.black;
        perMonthChargeAmount.minimumScaleFactor = 0.1;
        perMonthChargeAmount.adjustsFontSizeToFitWidth = true;
        perMonthChargeAmount.numberOfLines = 1;
        return perMonthChargeAmount;
    }()
    
    lazy var editButton: UIButton = {
        let editButton = UIButton(type: .system);
        editButton.translatesAutoresizingMaskIntoConstraints = false;
        editButton.backgroundColor = UIColor.appYellow;
        editButton.setTitle("Edit", for: .normal);
        editButton.setTitleColor(UIColor.black, for: .normal);
        editButton.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 16);
        editButton.layer.cornerRadius = 3;
        return editButton;
    }()
    
    lazy var popUp: SubscriptionPopUp = {
        let popUp = SubscriptionPopUp();
        popUp.translatesAutoresizingMaskIntoConstraints = false;
        popUp.profileSubscriptionPage = self;
        return popUp;
    }()
    
    lazy var darkView: UIView = {
        let darkView = UIView();
        darkView.translatesAutoresizingMaskIntoConstraints = false;
        darkView.backgroundColor = UIColor.black;
        darkView.alpha = 0;
        darkView.isUserInteractionEnabled = true;
        return darkView;
    }()
    
    override func viewDidLoad() {
        self.title = "Subscription";
        self.view.backgroundColor = UIColor.white;
        
        self.view.addSubview(ordersView);
        ordersView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        ordersView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        ordersView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50).isActive = true;
        ordersView.heightAnchor.constraint(equalToConstant: 50).isActive = true;
        
        self.ordersView.addSubview(numberOfOrdersTitle);
        numberOfOrdersTitle.leftAnchor.constraint(equalTo: self.ordersView.leftAnchor).isActive = true;
        numberOfOrdersTitle.topAnchor.constraint(equalTo: self.ordersView.topAnchor).isActive = true;
        numberOfOrdersTitle.widthAnchor.constraint(equalToConstant: self.view.frame.width/2).isActive = true;
        numberOfOrdersTitle.heightAnchor.constraint(equalToConstant: 50).isActive = true;
        
        self.ordersView.addSubview(numberOfOrders);
        numberOfOrders.leftAnchor.constraint(equalTo: self.numberOfOrdersTitle.rightAnchor).isActive = true;
        numberOfOrders.rightAnchor.constraint(equalTo: self.ordersView.rightAnchor).isActive = true;
        numberOfOrders.topAnchor.constraint(equalTo: self.ordersView.topAnchor).isActive = true;
        numberOfOrders.heightAnchor.constraint(equalToConstant: 50).isActive = true;
        
        self.view.addSubview(subscriptionView);
        subscriptionView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        subscriptionView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        subscriptionView.topAnchor.constraint(equalTo: self.ordersView.bottomAnchor).isActive = true;
        subscriptionView.heightAnchor.constraint(equalToConstant: 50).isActive = true;
        
        self.subscriptionView.addSubview(subscriptionTypeLabel);
        subscriptionTypeLabel.leftAnchor.constraint(equalTo: self.subscriptionView.leftAnchor).isActive = true;
        subscriptionTypeLabel.topAnchor.constraint(equalTo: self.subscriptionView.topAnchor).isActive = true;
        subscriptionTypeLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width/2).isActive = true;
        subscriptionTypeLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true;
        
        self.subscriptionView.addSubview(subscriptionPayingLabel);
        subscriptionPayingLabel.leftAnchor.constraint(equalTo: self.subscriptionTypeLabel.rightAnchor).isActive = true;
        subscriptionPayingLabel.rightAnchor.constraint(equalTo: subscriptionView.rightAnchor).isActive = true;
        subscriptionPayingLabel.topAnchor.constraint(equalTo: self.subscriptionView.topAnchor).isActive = true;
        subscriptionPayingLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true;
        
        self.view.addSubview(perMonthChargeView);
        perMonthChargeView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        perMonthChargeView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        perMonthChargeView.topAnchor.constraint(equalTo: self.subscriptionView.bottomAnchor).isActive = true;
        perMonthChargeView.heightAnchor.constraint(equalToConstant: 50).isActive = true;
        
        self.perMonthChargeView.addSubview(perMonthChargeLabel);
        perMonthChargeLabel.leftAnchor.constraint(equalTo: self.perMonthChargeView.leftAnchor).isActive = true;
        perMonthChargeLabel.topAnchor.constraint(equalTo: self.perMonthChargeView.topAnchor).isActive = true;
        perMonthChargeLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width/2).isActive = true;
        perMonthChargeLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true;
        
        self.perMonthChargeView.addSubview(perMonthChargeAmount);
        perMonthChargeAmount.leftAnchor.constraint(equalTo: self.perMonthChargeLabel.rightAnchor).isActive = true;
        perMonthChargeAmount.rightAnchor.constraint(equalTo: self.perMonthChargeView.rightAnchor).isActive = true;
        perMonthChargeAmount.topAnchor.constraint(equalTo: self.perMonthChargeView.topAnchor).isActive = true;
        perMonthChargeAmount.heightAnchor.constraint(equalToConstant: 50).isActive = true;
        
        self.view.addSubview(editButton);
        editButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true;
        editButton.topAnchor.constraint(equalTo: self.perMonthChargeView.bottomAnchor, constant: 30).isActive = true;
        editButton.widthAnchor.constraint(equalToConstant: 150).isActive = true;
        editButton.heightAnchor.constraint(equalToConstant: 40).isActive = true;
        editButton.addTarget(self, action: #selector(showPopUp), for: .touchUpInside);
        
        self.view.addSubview(darkView);
        darkView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        darkView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        darkView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true;
        darkView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true;
        darkView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissPopUp)));
        
        self.view.addSubview(popUp);
        popUp.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        popUp.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        popUpTopAnchor = popUp.topAnchor.constraint(equalTo: self.view.bottomAnchor);
        popUpTopAnchor.isActive = true;
        popUp.heightAnchor.constraint(equalToConstant: 140).isActive = true;
        
        setupText();
        
    }
    
    func setupText(){
        numberOfOrders.text = "\(user!.freeOrders!)";
        subscriptionPayingLabel.text = user!.subscriptionPlan!;
        switch(user!.subscriptionPlan!){
        case "Standard":
            self.perMonthChargeAmount.text = "$7.99";
            break;
        case "Premium":
            self.perMonthChargeAmount.text = "$10.99";
            break;
        case "Executive":
            self.perMonthChargeAmount.text = "$14.99";
            break;
        default:
            self.perMonthChargeAmount.text = "None";
            break;
        }
    }
    
    @objc func showPopUp(){
        //show the pop up
        UIView.animate(withDuration: 0.3) {
            self.darkView.alpha = 0.7;
            self.popUpTopAnchor.constant -= 140;
            self.view.layoutIfNeeded();
        }
        
    }
    
    @objc func dismissPopUp(){
        UIView.animate(withDuration: 0.3) {
            self.darkView.alpha = 0;
            self.popUpTopAnchor.constant = 0;
            self.view.layoutIfNeeded();
        }
    }
    
    @objc func toUpgradePage(){
        let upgradePage = SubscriptionUpgradePage();
        self.navigationController?.pushViewController(upgradePage, animated: true);
    }
    
    @objc func cancelPlan(){
        if(user!.subscriptionPlan! != "NONE"){
            let alert = UIAlertController(title: "Cancel Subscription", message: "Are you sure you want to cancel your subscription?", preferredStyle: .alert);
            alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (result) in
                //remove sub plan, send to server that they are no longer subscribed, keep orders
                user!.subscriptionPlan = "NONE";
                let conn = Conn();
                let postBody = "UserID=\(user!.userID!)";
                conn.connect(fileName: "cancelSubscription.php", postString: postBody, completion: { (result) in
                })
                self.showConfirmationAlert();
            }))
            alert.addAction(UIAlertAction(title: "No", style: .default, handler: {(result) in
                
            }))
            self.present(alert, animated: true, completion: nil);
        }else{
            dismissPopUp();
        }
    }
    
    private func cancelSubscriptionPlan(){
        let url = URL(string: "https://onDeliveryinc.com/cancelSubscription.php");
        var request: URLRequest = URLRequest(url: url!);
        let postBody = "UserID=\(user!.userID!)"
        request.httpMethod = "POST";
        request.httpBody = postBody.data(using: String.Encoding.utf8);
        let task = URLSession.shared.dataTask(with: request) { (data, response, errorOrNil) in
            if let error = errorOrNil{
                switch error{
                case URLError.networkConnectionLost, URLError.notConnectedToInternet:
                    print("no network connection");
                    break;
                case URLError.cannotFindHost:
                    print("can't find host");
                    break;
                default: print("unknown error");
                }
            }
        }
        task.resume()
        
    }
    
    private func showConfirmationAlert(){
        let alert = UIAlertController(title: "Subscription Canceled", message: "Your subscription has been canceled. You still get to keep your remaining free orders though!", preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: { (result) in
            self.navigationController?.popToRootViewController(animated: true);
        }))
        self.present(alert, animated: true, completion: nil);
    }
}
