//
//  ProfileLoginFunctions.swift
//  YummyV1
//
//  Created by Brandon In on 4/15/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit
import CoreData
import MapKit

extension ProfileLogin{
    func checkPassword(){
        self.loadingTitle.text = "Checking Password";
        let conn = Conn();
//        let postString = "telephone=\(loginTelephoneField.textField.text!)&password=\(loginPasswordField.textField.text!)";
        let postString = "hello";
//        print(postString);
        conn.connect(fileName: "Login.php", postString: postString) { (re) in
            let result = re as String;
            if(result == "failure"){// if result is failure, then unhide wrongPassword Label and reset passwordField
                DispatchQueue.main.async {
                    //                    print("notPassed");
                    self.spinner.animating = false;
                    self.spinner.updateAnimation();
                    UIView.animate(withDuration: 0.3, animations: {
                        self.darkView.alpha = 0;
                    })
//                    self.loginPasswordField.textField.text = "";
                    let alert = UIAlertController(title: "No Match", message: "Email and Password doesn't match", preferredStyle: .alert);
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil));
                    self.present(alert, animated: true, completion: nil);
//                    self.wrongPasswordLabel.isHidden = false;
                }
            }else{
                //if can't be parsed to result, then parse to json
                do{
                    self.jsonresult = try JSONSerialization.jsonObject(with: urlData, options: .allowFragments) as! NSDictionary;
                    //jsonResult into NSARRAY
                    if let items = self.jsonresult["results"] as? NSArray{
                        self.userID = (items[0] as? String)!;//userID save global
                        self.firstName = (items[1] as? String)!;//firstName global save
                        self.lastName = (items[2] as? String)!;//lastName global save
                        self.email = (items[3] as? String)!;//email global save
                        self.subPlan = (items[5] as? String)!;//subscription plan
//                        self.telephone = self.loginTelephoneField.textField.text!
                        let stringItem = (items[6] as? String)!;
                        let intVersion = Int(stringItem)!;
                        self.freeOrders = intVersion;
//                        self.password = self.loginPasswordField.textField.text!
                        DispatchQueue.main.sync {
//                            print("getAddresses");
                            self.locManager = CLLocationManager();
                            self.locManager.delegate = self;
                            //        locManager.requestAlwaysAuthorization();
                            
                            let locStatus = CLLocationManager.authorizationStatus();
                            if(locStatus == .notDetermined){
                                //ask for location
                                self.locManager.requestAlwaysAuthorization();
                            }else if(locStatus == .denied){
                                let alert = UIAlertController(title: "Need Location Services", message: "We need your location to determine what restaurants are around you. Allow location services to continue", preferredStyle: .alert);
                                alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { (result) in
                                    UIView.animate(withDuration: 0.3, animations: {
                                        self.darkView.alpha = 0.0;
                                        self.spinner.animating = false;
                                        self.spinner.updateAnimation();
                                    })
                                }))
                                self.present(alert, animated: true, completion: nil);
                            }else if(locStatus == .authorizedAlways || locStatus == .authorizedWhenInUse){
                                self.getAddresses();
                            }
//                            self.getAddresses();
                        }
                        
                    }
                }catch{
                    fatalError();
                }
            }
            
        }
    }
    
    
    //MARK: GetAddresses
    func getAddresses(){
        //ran on the main thread
        //        dispatchGroup.enter();
        self.loadingTitle.text = "Getting Addreses";
//        saveDefaults(defaults: defaults!, firstName: firstName!, lastName: lastName!, email: email!, phoneNumber: telephone!, password: self.loginPasswordField.textField.text!);
        saveSubscription(defaults: defaults!, subscriptionPlan: subPlan!, freeOrders: freeOrders!);
//        populateDefaults(defaults: defaults);
        
        // first address will always be your main
        let conn = Conn();
        let postString = "UserID=\(userID!)"
        //        print(postString);
        conn.connect(fileName: "GetAddresses.php", postString: postString, completion: { (re) in
            let result = re as String;
            if(result == "none"){
//                print("none");
                self.getCardsAndOrders();
            }else{
//                print("ok");
                do{
                    self.jsonresult = try JSONSerialization.jsonObject(with: urlData!, options: .allowFragments) as! NSDictionary;
                    //addresses
                    let userAddresses = self.jsonresult["addresses"] as! NSArray;
                    let userCities = self.jsonresult["city"] as! NSArray;
                    let userZipcodes = self.jsonresult["zipcode"] as! NSArray;
                    let userStates = self.jsonresult["state"] as! NSArray;
                    let userAddressIDs = self.jsonresult["id"] as! NSArray;
                    let userMains = self.jsonresult["main"] as! NSArray;
                    
                    var count = 0;
                    while(count < userAddresses.count){
                        let newAddress = UserAddress();
                        newAddress.address = userAddresses[count] as? String;
                        newAddress.city = userCities[count] as? String;
                        newAddress.zipcode = userZipcodes[count] as? String;
                        newAddress.state = userStates[count] as? String;
                        newAddress.addressID = userAddressIDs[count] as? String;
                        newAddress.mainAddress = userMains[count] as? String;
                        
                        self.addresses.append(newAddress);
                        
                        count+=1;
                    }
                    
                    self.getCardsAndOrders();//get CardsAndOrders
                    
                    //save to core data the items, and then get out of dispatchGroup
                    
                }catch{
                    print(error)
                    fatalError();
                }
            }
        })
    }
    
    func getCardsAndOrders(){
        let conn = Conn();
        let postBody = "UserID=\(userID!)"
//        print(postBody);
        conn.connect(fileName: "GetCardsAndOrders.php", postString: postBody) { (re) in
            let result = re as String;
            if(result == "none"){
                DispatchQueue.main.async {
                    if(self.fromStartUpPage){
                        self.getLocation();
                    }else{
                        self.coreDataSaveAll();
                        self.customTabController?.selectedIndex = 3;
//                        self.loginPasswordField.textField.resignFirstResponder();
                        self.dismiss(animated: true, completion: nil);
                    }
                }
            }else{
                do{
                    let json = try JSONSerialization.jsonObject(with: urlData!, options: .allowFragments) as! NSDictionary;
//                    print(json)
                    DispatchQueue.main.async {
                        self.getOrders(json: json);
                    }
                }catch{
                    fatalError();
                }
            }
            //load data in orders and cards
        }
    }
    
    //MARK: GetOrders and Get Cards
    //two persistant containers which is weird, change to one.
    
    func getOrders(json: NSDictionary){
        //on the main thread
        self.loadingTitle.text = "Loading Orders";
        
        //rest names
        let restaurantNames = json["restName"] as! NSArray;
        let restaurantIDs = json["restIDs"] as! NSArray;
        let restaurantPicURLs = json["urls"] as! NSArray;
        let orderTotals = json["totalSums"] as! NSArray;
        let orderIDs = json["orderIDs"] as! NSArray;
        let orderDates = json["dates"] as! NSArray;
        let foodNames = json["foodNames"] as! NSArray;
        let foodPrices = json["foodPrices"] as! NSArray;
        let foodQuantities = json["foodQuantities"] as! NSArray;
        let foodIDs = json["foodIDs"] as! NSArray;
        print(json);
        
        print(foodNames.count)
        print(foodIDs.count);
        
        var count = 0;
        while(count < restaurantNames.count){
            let newPastOrder = PastOrder();
            newPastOrder.restaurantName = restaurantNames[count] as? String;
            newPastOrder.restaurantID = restaurantIDs[count] as? String;
            newPastOrder.totalSum = orderTotals[count] as? String;
            newPastOrder.orderID = orderIDs[count] as? String;
            newPastOrder.orderDate = orderDates[count] as? String;
            newPastOrder.restaurantPic = self.loadImage(urlString: (restaurantPicURLs[count] as? String)!);
            
            var newPastOrderFoodList = [PastOrderFood]();
            let orderFoodNames = foodNames[count] as! NSArray;
            let orderFoodPrices = foodPrices[count] as! NSArray;
            let orderFoodQuantities = foodQuantities[count] as! NSArray;
            let orderFoodIDs = foodIDs[count] as! NSArray;
            
            
            var foodCounts = 0;
            while(foodCounts < orderFoodNames.count){
                let foodName = orderFoodNames[foodCounts] as? String;
                let foodPrice = orderFoodPrices[foodCounts] as? String;
                let foodQuantity = orderFoodQuantities[foodCounts] as? String;
                let foodID = orderFoodIDs[foodCounts] as? String;
                
                let pastOrderFood = PastOrderFood();
                pastOrderFood.foodName = foodName;
                pastOrderFood.foodPrice = foodPrice;
                pastOrderFood.foodQuantity = foodQuantity;
                pastOrderFood.foodID = foodID;
                
                newPastOrderFoodList.append(pastOrderFood);
                
                foodCounts += 1;
            }
            newPastOrder.foods = newPastOrderFoodList;
            self.pastOrders.append(newPastOrder);
            
            count+=1;
        }
        self.getCards(json: json);
    }
    
    //MARK: LOAD FoodImages
    func loadImage(urlString: String)-> UIImage{
        let url = URL(string: urlString);
        let data = try? Data(contentsOf: url!);
//        self.foodPicArray.append(data! as NSData);
        let image = UIImage(data: data!);
        return image!;
    }
    
    func getCards(json: NSDictionary){
        //        print("getCards");
        self.loadingTitle.text = "Loading Cards";
        
        let nickNames = json["nickName"] as! NSArray;
        let cardNumbers = json["cards"] as! NSArray;
        let expirationDates = json["expiration"] as! NSArray;
        let cvcNumbers = json["cvc"] as! NSArray;
        let mainCards = json["main"] as! NSArray;
        let cardIDs = json["cardID"] as! NSArray;
        
        var count = 0;
        while(count < nickNames.count){
            let paymentCard = PaymentCard();
            paymentCard.nickName = nickNames[count] as? String;
            paymentCard.cardNumber = cardNumbers[count] as? String;
            paymentCard.expirationDate = expirationDates[count] as? String;
            paymentCard.cvcNumber = cvcNumbers[count] as? String;
            paymentCard.mainCard = mainCards[count] as? String;
            paymentCard.cardID = cardIDs[count] as? String;
            
            let cardNum = paymentCard.cardNumber!
            let last4 = String(cardNum.suffix(4));
            
            paymentCard.last4 = last4;
            
            self.cards.append(paymentCard);
            count+=1;
        }
        
        self.coreDataSaveAll();
        
        self.customTabController?.selectedIndex = 3;
//        self.loginPasswordField.textField.resignFirstResponder();
        
        if let orderPage = self.customTabController?.orderPage{
            orderPage.pastOrders = self.pastOrders;
            orderPage.collectionView?.reloadData();
        }
        
        if let profilePage = self.customTabController?.profilePage{
            profilePage.addresses = self.userAddresses;
            profilePage.cards = self.cards;
        }
        
        if(self.fromStartUpPage){
            self.getLocation();
        }else{
            self.dismiss(animated: true, completion: nil);
        }
    }
    
    func coreDataSaveAll(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext;
//        print("start address");
//        let num = self.idArray.count;
        var count = 0;
        var entity = NSEntityDescription.entity(forEntityName: "Address", in: managedContext);
//        while(count<num){
        while(count<self.addresses.count){
            let address = NSManagedObject(entity: entity!, insertInto: managedContext);
            let userAddressObject = self.addresses[count];
            address.setValue(userAddressObject.address!, forKey: "address");
            address.setValue(userAddressObject.city!, forKey: "city");
            address.setValue(userAddressObject.zipcode!, forKey: "zipcode");
            address.setValue(userAddressObject.state!, forKey: "state");
            address.setValue(userAddressObject.addressID!, forKey: "addressID");
            
            do{
                try managedContext.save();
            }catch{
                print("error");
                
                fatalError();
            }
            
            self.userAddresses.append(address);
            count+=1;
//            addresses.append(address);//append address to the global addresses array
        }
//        print(userAddresses.count);
        
//        print("start orderes");
        entity = NSEntityDescription.entity(forEntityName: "Order", in: managedContext)!;
        count = 0;
//        while(count < self.orderIDArray.count){
        while(count < self.pastOrders.count){
            let order = NSManagedObject(entity: entity!, insertInto: managedContext);
            let pastOrder = pastOrders[count];
            order.setValue(pastOrder.restaurantName, forKey: "restaurantName");
            order.setValue(Double(pastOrder.totalSum!), forKey: "price");
            order.setValue(pastOrder.orderID!, forKey: "orderID");
            order.setValue(pastOrder.orderDate!, forKey: "date");
            order.setValue(pastOrder.restaurantID!, forKey: "restaurantID");
            
            do{
                try managedContext.save();
            }catch{
                print("error");
                fatalError();
            }
            count+=1;
        }
//        print("start Cards");
        count = 0;
        entity = NSEntityDescription.entity(forEntityName: "Card", in: managedContext)!;
//        while(count < nickNameArray.count){
        while(count < cards.count){
            let cardObject = NSManagedObject(entity: entity!, insertInto: managedContext);
            let paymentCard = self.cards[count]
            
            cardObject.setValue(paymentCard.cardNumber!, forKey: "cardNum");
            cardObject.setValue(paymentCard.cvcNumber!, forKey: "cvc");
            cardObject.setValue(paymentCard.expirationDate!, forKey: "expiration");
            //get the last 4 digits from cardArray[count]
//            let cardNum = paymentCard.cardNumber!
//            let last4 = String(cardNum.suffix(4));
            cardObject.setValue(paymentCard.last4!, forKey: "last4");
            cardObject.setValue(paymentCard.cardID!, forKey: "cardID");
            cardObject.setValue(paymentCard.nickName!, forKey: "nickName");
            cardObject.setValue(paymentCard.mainCard!, forKey: "mainCard");
            
            do{
                try managedContext.save();
            }catch{
                print("error");
                fatalError();
            }
//            cCards.append(cardObject);
            count+=1;
        }
        
    }
}
