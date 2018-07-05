//
//  ReviewPageGeneralFunctions.swift
//  YummyV1
//
//  Created by Brandon In on 3/14/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import Stripe

extension ReviewPage{
    //MARK: Button Funcs
    @objc func nextPush(){
        if(userID == nil && customerPhone == "none" && customerName == "none"){
            let alert = UIAlertController(title: "Fill out all required fields", message: "Fill out Address, Payment, etc..", preferredStyle: .alert);
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil));
            self.present(alert, animated: true, completion: nil);
        }else{
            if(paymentUserText == "none" || addressUserText == nil || deliveryTimeUserText == nil){
                let alert = UIAlertController(title: "Fill out all required fields", message: "Fill out Address, Payment, etc..", preferredStyle: .alert);
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil));
                self.present(alert, animated: true, completion: nil);
            }else{
                if(userID == nil){
                    userID = "1";
                    addressIDText = "1";
                    
                }
                
                if(email == nil){
                    email = "ondeliveryllc@gmail.com";
                }
                //create stripe Token, send to server, save to core data, alert view
                //MARK: Create Token
                let cardParams = STPCardParams();
                cardParams.number = paymentFullCard!;
                cardParams.expMonth = UInt((cardExpMonth! as NSString).integerValue);
                cardParams.expYear = UInt((cardExpYear! as NSString).integerValue);
                cardParams.cvc = cardCvc!;

                
                STPAPIClient.shared().createToken(withCard: cardParams) { (token: STPToken?, error: Error?) in
                    guard let token = token, error == nil else {
                        // Present error to user...
                        return
                    }
                    print(token);
                    
                    let conn = Conn();
                    let postString = "stripeToken=\(token)&totalSum=\(self.orderTotal)&email=\(self.email!)";
                    print(postString);
                    conn.connect(fileName: "stripeOrder.php", postString: postString, completion: { (result) in
    //                    print(result);
                    })
                }
                
                if(self.freeOrders! > 0 && self.totalPrice! <= 20.0){
                    self.freeOrders = freeOrders! - 1;
                }
                
                let time = Date();
                let timeFormatter = DateFormatter();
                timeFormatter.dateFormat = "MM/dd/yyy hh:mm a";
                timeFormatter.amSymbol = "AM";
                timeFormatter.pmSymbol = "PM";
                let string = timeFormatter.string(from: time);
//                orderTotal = 0.0;
                let infoArray = [self.userID!, string, addressIDText!, deliveryTimeUserText!, self.customerPhone!, self.customerName!, addressUserText!];//delivery can be "ASAP" or another time
                let json:[String: Any] = ["userInfo":infoArray,"totalSum":(orderTotal),"foodNames":self.names, "foodPrices":self.prices, "foodQuantity":self.quantity, "foodIDs":self.id, "restID":self.restaurantID, "freeOrders":freeOrders!];
                            print(json);
                let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted);

                let url: URL = URL(string: "https://onDeliveryinc.com/OrderPlaced.php")!;
                var request:URLRequest = URLRequest(url: url);
                request.httpMethod = "POST";
                request.httpBody = jsonData;
                let task = URLSession.shared.dataTask(with: request){
                    data,response,error in
                    if data != nil{
                        let re = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!;
                        DispatchQueue.main.async {
                            //save order in core data
                            if(self.userID != "1"){
                                let appDelegate = UIApplication.shared.delegate as! AppDelegate;
                                let context = appDelegate.persistentContainer.viewContext;
                                let entity = NSEntityDescription.entity(forEntityName: "Order", in: context)!;
                                let order = NSManagedObject(entity: entity, insertInto: context);
                                //restaurant, price, orderID,image,date
                                //re = orderID

                                order.setValue(self.restaurantName, forKey: "restaurantName");
                                order.setValue(self.orderTotal, forKey: "price");
                                order.setValue(re, forKey: "orderID");
                                order.setValue(string, forKey: "date");
                                order.setValue(self.restaurantID, forKey: "restaurantID");
                                
                                let imageData = (UIImagePNGRepresentation(self.restaurantPic) as Data?);
                                order.setValue(imageData, forKey: "image");

                                //convert arrays to data
                                let dataFoodNames = NSKeyedArchiver.archivedData(withRootObject: self.names);
                                let dataFoodPrices = NSKeyedArchiver.archivedData(withRootObject: self.prices);
                                let dataFoodQuantity = NSKeyedArchiver.archivedData(withRootObject: self.quantity);
                                let dataFoodIDs = NSKeyedArchiver.archivedData(withRootObject: self.quantity);

                                do{
                                    try context.save();
                                    orders.append(order);
                                    
//                                    picOrdersArray = picOrdersArray.reversed();
//                                    ordersNameArray = ordersNameArray.reversed();
//                                    ordersPriceArray = ordersPriceArray.reversed();
//                                    ordersDateArray = ordersDateArray.reversed();
//
//                                    picOrdersArray.append(self.restaurantPic);
//                                    ordersNameArray.append(self.restaurantName);
//                                    ordersPriceArray.append(self.orderTotal);
//                                    ordersDateArray.append(string);
//
//                                    picOrdersArray = picOrdersArray.reversed();
//                                    ordersNameArray = ordersNameArray.reversed();
//                                    ordersPriceArray = ordersPriceArray.reversed();
//                                    ordersDateArray = ordersDateArray.reversed();
                                }catch{
                                    print("error");
                                }

                                order.setValue(dataFoodNames, forKey: "foodNames");
                                order.setValue(dataFoodPrices, forKey: "foodPrices");
                                order.setValue(dataFoodQuantity, forKey: "foodQuantity");
                                order.setValue(dataFoodIDs, forKey: "foodIDs");
                                finalDeliveryPrice = 0;
                                
                                saveSubscription(defaults: defaults!, subscriptionPlan: self.subPlan!, freeOrders: self.freeOrders!);
                            }
                            
                            if(self.userID == "1"){
                                self.userID = nil;
                                addresses.removeAll();
                                cCards.removeAll();
                            }
                            
                            addressUserText = nil;
                            addressIDText = nil;
                            
                            let alert = UIAlertController(title: "Order Placed", message: "Your order has been placed!", preferredStyle: UIAlertControllerStyle.alert);
                            alert.addAction(UIAlertAction(title: "Ok!", style: UIAlertActionStyle.default, handler: { (result) in
                                self.navigationController?.popToRootViewController(animated: true);
                            }))
                            self.present(alert, animated: true, completion: nil);
                            
    //                        self.navigationController?.popToRootViewController(animated: true);
                        }

                    }
                }
                task.resume();
            }
        }
    }
    
    //MARK: NewNavControllers
    func toSelectAddress(){
        //Address
        let selectAddress = SelectAddress();
        self.navigationController?.pushViewController(selectAddress, animated: true);
    }
    
    func toDeliveryTime(){
        //delivery time
        let deliveryTime = DeliveryTimePage();
        self.navigationController?.pushViewController(deliveryTime, animated: true);
    }
    
    func toSelectPayments(){
        let payments = SelectPaymentPage();
        self.navigationController?.pushViewController(payments, animated: true);
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
                self.customerName = textField.text!;
                DispatchQueue.main.async {
                    let cell = self.tableView.cellForRow(at: index) as! OptionsCell;
                    cell.setUserText(text: self.customerName);
                }
            }
        }))
        self.present(alert, animated: true, completion: nil);
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
                self.customerPhone = textField.text!;
                DispatchQueue.main.async {
                    let cell = self.tableView.cellForRow(at: index) as! OptionsCell;
                    cell.setUserText(text: self.customerPhone);
                }
            }
        }))
        self.present(alert, animated: true, completion: nil);
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
                self.customerEmail = textField.text!;
                self.email = textField.text!;
                DispatchQueue.main.async {
                    let cell = self.tableView.cellForRow(at: index) as! OptionsCell;
                    cell.setUserText(text: self.customerEmail);
                }
            }
        }))
        self.present(alert, animated: true, completion: nil);
    }
    //-----------------------------------------------
    
    @objc func clear(){
        self.newNavController.dismiss(animated: true, completion: nil);
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData();
    }
    
    //MARK: GetTableInfo
    func getTableInfo(){
        for item in cCards{
            if((item.value(forKey: "mainCard") as! String) == "Y"){
                //card number = the global card
                let expirationString = item.value(forKey: "expiration") as! String;
                let expirationStringArray = expirationString.components(separatedBy: "/");
                cardExpMonth = expirationStringArray[0];
                cardExpYear = expirationStringArray[1];
                cardCvc = item.value(forKey: "cvc") as! String;
                paymentFullCard = item.value(forKey: "cardNum") as! String;
                let text = item.value(forKey: "last4") as! String;
                paymentUserText = "...\(text)"
            }
        }
    }
    
    //MARK: GetInfo
    func getCollectionViewInfo(){
        //extract all data from MenuitemArray
//        for item in menuItemArray{
//            names.append(item.name);
//            prices.append(item.price);
//            quantity.append(item.quantity);
//            id.append(item.id);
//        }
    }
}
