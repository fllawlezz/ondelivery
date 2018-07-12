//
//  UserInfoTableView.swift
//  YummyV1
//
//  Created by Brandon In on 7/7/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class UserInfoTableView: UITableView, UITableViewDelegate, UITableViewDataSource{
    var reviewPage: ReviewPage?
    
    var reuseIdentifier = "reuseIdentifier";
    var userAddress: UserAddress?
    var deliveryTime: String?
    var paymentCard: PaymentCard?
    
    var customer: Customer?
    
    let tableTitles = ["Address","Delivery Time","Payment","Name","Telephone","Email"];
    let tableImages = ["home","clock","creditCard","profile","phone","email"];
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: .zero, style: .plain);
        
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.register(OptionsCell.self, forCellReuseIdentifier: reuseIdentifier);
        self.backgroundColor = UIColor.white;
        self.delegate = self;
        self.dataSource = self;
        self.alwaysBounceVertical = false;
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! OptionsCell
        cell.setTitle(name: tableTitles[indexPath.item]);
        cell.setImage(url: tableImages[indexPath.item]);
        if(indexPath.row == 0 && self.userAddress != nil){
            cell.setUserText(text: self.userAddress!.address!);
        }else if(indexPath.row == 1 && self.deliveryTime != nil){
            cell.setUserText(text: self.deliveryTime!);
        }else if(indexPath.row == 2 && self.paymentCard != nil){
            cell.setUserText(text: "...\(self.paymentCard!.last4!)");
        }else if(indexPath.row == 3){
            cell.setUserText(text:  "\(customer!.customerName!)");
        }else if(indexPath.row == 4){
            cell.setUserText(text: "\(customer!.customerPhone!)");
        }else if(indexPath.row == 5){
            cell.setUserText(text: "\(customer!.customerEmail!)")
        }
        return cell;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(user != nil){
            return 3;
        }else{
            return 6;
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch(indexPath.item){
        case 0: toSelectAddress();break;
        case 1: toDeliveryTime();break;
        case 2: toSelectPayments();break;
        case 3: toEnterName(index: indexPath);break;
        case 4: toEnterTelephone(index: indexPath);break;
        case 5: toEnterEmail(index: indexPath);break;
        default: break;
        }
        tableView.deselectRow(at: indexPath, animated: true);
    }
    
    func setAddress(){
        self.userAddress = reviewPage?.userAddress;
        let cell = self.cellForRow(at: IndexPath(item: 0, section: 0)) as! OptionsCell
        cell.setUserText(text: self.userAddress!.address!);
    }
    
    func toSelectAddress(){
        //Address
        let selectAddress = SelectAddress();
        selectAddress.reviewPage = self.reviewPage;
        self.reviewPage?.navigationController?.pushViewController(selectAddress, animated: true);
    }
    
    func toDeliveryTime(){
        //delivery time
        let deliveryTime = DeliveryTimePage();
        deliveryTime.reviewPage = self.reviewPage;
        self.reviewPage?.navigationController?.pushViewController(deliveryTime, animated: true);
    }
    
    func toSelectPayments(){
        let payments = SelectPaymentPage();
        payments.reviewPage = self.reviewPage;
        self.reviewPage?.navigationController?.pushViewController(payments, animated: true);
    }
    
    func toEnterName(index: IndexPath!){
        let alert = UIAlertController(title: "Enter Your Name", message: "Enter Name:", preferredStyle: .alert);
        alert.addTextField { (textField) in
            let textField = alert.textFields![0];
            textField.placeholder = "Your Name";
        }
        alert.addAction(UIAlertAction(title: "Enter", style: .default, handler: { (result) in
            let textField = alert.textFields![0];
            if(textField.text!.count > 3){
                self.customer!.customerName = textField.text!;
                DispatchQueue.main.async {
                    let cell = self.cellForRow(at: IndexPath(item: 3, section: 0)) as! OptionsCell;
                    cell.setUserText(text: self.customer!.customerName!);
                }
            }
        }))
        self.reviewPage?.present(alert, animated: true, completion: nil);
    }
    
    func toEnterTelephone(index: IndexPath!){
        let alert = UIAlertController(title: "Enter Your Telephone #", message: "Enter Telephone:", preferredStyle: .alert);
        alert.addTextField { (textField) in
            let textField = alert.textFields![0];
            textField.placeholder = "Your Number";
            textField.keyboardType = .numberPad;
        }
        alert.addAction(UIAlertAction(title: "Enter", style: .default, handler: { (result) in
            let textField = alert.textFields![0];
            if(textField.text!.count > 6){
                self.customer!.customerPhone = textField.text!;
                DispatchQueue.main.async {
                    let cell = self.cellForRow(at: IndexPath(item: 4, section: 0)) as! OptionsCell;
                    cell.setUserText(text: self.customer!.customerPhone!);
                }
            }
        }))
        self.reviewPage?.present(alert, animated: true, completion: nil);
    }
    
    func toEnterEmail(index: IndexPath!){
        let alert = UIAlertController(title: "Enter Your Email Address", message: "Enter Email to get your reciept:", preferredStyle: .alert);
        alert.addTextField { (textField) in
            let textField = alert.textFields![0];
            textField.placeholder = "Email";
            textField.keyboardType = .emailAddress;
        }
        alert.addAction(UIAlertAction(title: "Enter", style: .default, handler: { (result) in
            let textField = alert.textFields![0];
            if(textField.text!.count > 6){
                self.customer!.customerEmail = textField.text!;
                DispatchQueue.main.async {
                    let cell = self.cellForRow(at: IndexPath(item: 5, section: 0)) as! OptionsCell;
                    cell.setUserText(text: self.customer!.customerEmail!);
                }
            }
        }))
        self.reviewPage?.present(alert, animated: true, completion: nil);
    }
    
    func handleReloadTable(){
        self.userAddress = self.reviewPage?.userAddress
        self.customer = self.reviewPage?.customer;
        self.deliveryTime = self.reviewPage?.deliveryTime;
        self.paymentCard = self.reviewPage?.paymentCard;
        self.reloadData();
    }
}
