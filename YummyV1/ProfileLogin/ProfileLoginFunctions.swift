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
    func checkPassword(telephone: String, password: String){
        self.loadingTitle.text = "Checking Password";
        let conn = Conn();
        let postString = "telephone=\(telephone)&password=\(password)";
        conn.connect(fileName: "Login.php", postString: postString) { (re) in
            let result = re as String;
            if(result == "failure"){// if result is failure, then unhide wrongPassword Label and reset passwordField
                DispatchQueue.main.async {
                    self.spinner.animating = false;
                    self.spinner.updateAnimation();
                    UIView.animate(withDuration: 0.3, animations: {
                        self.darkView.alpha = 0;
                    })
                    let alert = UIAlertController(title: "No Match", message: "Email and Password doesn't match", preferredStyle: .alert);
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil));
                    self.present(alert, animated: true, completion: nil);
                }
            }else{
                //if can't be parsed to result, then parse to json
                do{
                    self.jsonresult = try JSONSerialization.jsonObject(with: urlData, options: .allowFragments) as! NSDictionary;
                    //jsonResult into NSARRAY
                    if let items = self.jsonresult["results"] as? NSArray{
                        let userID = (items[0] as? String)!;//userID save global
                        let firstName = (items[1] as? String)!;//firstName global save
                        let lastName = (items[2] as? String)!;//lastName global save
                        let email = (items[3] as? String)!;//email global save
                        let subplan = (items[5] as? String)!;//subscription plan
                        let stringItem = (items[6] as? String)!;
                        let freeOrdersInteger = Int(stringItem)!;
                        
                        let newUser = User(firstName: firstName, lastName: lastName, userID: userID, email: email, telephone: telephone, subscriptionPlan: subplan, freeOrders: freeOrdersInteger);
                        user = newUser;
                        saveDefaults(defaults: defaults);
                        DispatchQueue.main.sync {
//                            print("getAddresses");
                            self.locManager = CLLocationManager();
                            self.locManager.delegate = self;
                            
                            let locStatus = CLLocationManager.authorizationStatus();
                            if(locStatus == .notDetermined){
                                //ask for location
                                self.locManager.requestAlwaysAuthorization();
                                self.locManager.requestWhenInUseAuthorization();
                            }else if(locStatus == .denied){
                                self.presentNeedLocation();
                            }else if(locStatus == .authorizedAlways || locStatus == .authorizedWhenInUse){
//                                self.getAddresses();
                            }
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
        self.loadingTitle.text = "Getting Addreses";
        // first address will always be your main
        let conn = Conn();
        let postString = "UserID=\(user!.userID!)"
        conn.connect(fileName: "GetAddresses.php", postString: postString, completion: { (re) in
            let result = re as String;
            if(result == "none"){
                self.getCardsAndOrders();
            }else{
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
                        
                        self.userAddresses.append(newAddress);
                        
                        count+=1;
                    }
                    
                    self.getCardsAndOrders();//get CardsAndOrders
                    
                    //save to core data the items, and then get out of dispatchGroup
                    
                }catch{
                    print("getAddress error");
                    print(error)
                    fatalError();
                }
            }
        })
    }
    
    func getCardsAndOrders(){
        let conn = Conn();
        let postBody = "UserID=\(user!.userID!)"
        conn.connect(fileName: "GetCardsAndOrders.php", postString: postBody) { (re) in
            let result = re as String;
            if(result == "none"){
                DispatchQueue.main.async {
                    if(self.fromStartUpPage){
                        self.getLocation();
                    }else{
                        self.coreDataSaveAll();
                        self.customTabController?.selectedIndex = 3;
                        self.dismiss(animated: true, completion: nil);
                    }
                }
            }else{
                do{
                    let json = try JSONSerialization.jsonObject(with: urlData!, options: .allowFragments) as! NSDictionary;
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
        let image = UIImage(data: data!);
        return image!;
    }
    
    func getCards(json: NSDictionary){
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
        
        self.customTabController?.selectedIndex = 2;
        
        if let orderPage = self.customTabController?.orderPage{
//            orderPage.pastOrders = self.pastOrders;
            orderPage.collectionView?.reloadData();
        }
        
        print(addresses.count);
        print(cCards.count);
        print(orders.count);
        
        
        if(self.fromStartUpPage){
            self.getLocation();
        }else{
            self.dismiss(animated: true, completion: nil);
        }
    }
    
    func coreDataSaveAll(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext;
        var count = 0;
        var entity = NSEntityDescription.entity(forEntityName: "Address", in: managedContext);
        while(count<self.userAddresses.count){
            let address = NSManagedObject(entity: entity!, insertInto: managedContext);
            let userAddressObject = self.userAddresses[count];
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
            
            addresses.append(address);
            count+=1;
        }
        
        entity = NSEntityDescription.entity(forEntityName: "Order", in: managedContext)!;
        count = 0;
        while(count < self.pastOrders.count){
            let order = NSManagedObject(entity: entity!, insertInto: managedContext);
            let pastOrder = pastOrders[count];
            order.setValue(pastOrder.restaurantName, forKey: "restaurantName");
            order.setValue(Double(pastOrder.totalSum!), forKey: "price");
            order.setValue(pastOrder.orderID!, forKey: "orderID");
            order.setValue(pastOrder.orderDate!, forKey: "date");
            order.setValue(pastOrder.restaurantID!, forKey: "restaurantID");
            let data:NSData = UIImageJPEGRepresentation(pastOrder.restaurantPic!, 75)! as NSData;
            order.setValue(data, forKey: "image");
            
            do{
                try managedContext.save();
            }catch{
                print("error");
                fatalError();
            }
            orders.append(order);
            count+=1;
        }
        count = 0;
        entity = NSEntityDescription.entity(forEntityName: "Card", in: managedContext)!;
        while(count < cards.count){
            let cardObject = NSManagedObject(entity: entity!, insertInto: managedContext);
            let paymentCard = self.cards[count]
            
            cardObject.setValue(paymentCard.cardNumber!, forKey: "cardNum");
            cardObject.setValue(paymentCard.cvcNumber!, forKey: "cvc");
            cardObject.setValue(paymentCard.expirationDate!, forKey: "expiration");
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
            cCards.append(cardObject);
            count+=1;
        }
        
    }
}
