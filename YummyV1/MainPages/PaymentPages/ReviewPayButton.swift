//
//  ReviewPayButton.swift
//  YummyV1
//
//  Created by Brandon In on 7/5/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit
import Stripe
import CoreData

class ReviewPayButton: UIButton{
    var reviewPage: ReviewPage?{
        didSet{
            self.userID = reviewPage?.userID!;
            self.customerPhone = reviewPage?.customerPhone;
            self.customerName = reviewPage?.customerName;
            self.mainItems = reviewPage?.mainItems;
        }
    }
    
    var userID: String?
    var customerPhone: String!;
    var customerName: String!
    var customerEmail: String?;
    var orderTotalSum: Double!;
    var numberOfFreeOrders: Int?;
    var mainItems:[MainItem]?;
    
    //arrays for items
    var optionIDs = [[[Int]]]();
    var mainFoodIDs = [Int]();
    var mainFoodQuantities = [Int]();
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        setup();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setup(){
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 20);
        self.setTitleColor(UIColor.black, for: .normal);
        self.backgroundColor = UIColor.appYellow;
        self.target(forAction: #selector(self.nextPush), withSender: self);
    }
    
    func setTitle(buttonTitle: String){
        self.setTitle(buttonTitle: buttonTitle);
    }
    
    fileprivate func getOrderDetails(){
        var count = 0;
        while(count < mainItems!.count){
            let mainItem = mainItems![count];
            if(mainItem.hasOptions){
                //loop through foodItems and get each of the specialoptions and add them to an array
                let itemOptions = getSpecialOptions(mainItem: mainItem);
                self.mainFoodIDs.append(Int(mainItem.id)!);
                self.mainFoodQuantities.append(mainItem.quantity);
                self.optionIDs.append(itemOptions);
            }else{
                //get foodID and quantity
                self.mainFoodQuantities.append(mainItem.quantity);
                self.mainFoodIDs.append(Int(mainItem.id)!);
            }
            count+=1;
        }
    }
    
    fileprivate func getSpecialOptions(mainItem: MainItem)->[[Int]]{
        var count = 0;
        var mainItemOptions = [[Int]]();
        while(count<mainItem.foodItems.count){
            let foodItem = mainItem.foodItems[count];
            let foodOptions = foodItem.options;
            let itemOptionIDs = revealOptions(options: foodOptions);
            mainItemOptions.append(itemOptionIDs);
            count+=1;
        }
        return mainItemOptions;
    }
    
    fileprivate func revealOptions(options:[SpecialOption])->[Int]{
        var count = 0;
        var optionIDs = [Int]();
        while(count < options.count){
            let foodOption = options[count]//specialOption
            optionIDs.append(foodOption.specialOptionID!);
            count+=1;
        }
        return optionIDs;
    }
    
    
    @objc func nextPush(){
        getOrderDetails();
        
        if(userID == nil && customerPhone == "none" && customerName == "none"){
            let alert = UIAlertController(title: "Fill out all required fields", message: "Fill out Address, Payment, etc..", preferredStyle: .alert);
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil));
            self.reviewPage?.present(alert, animated: true, completion: nil);
        }else{
            if(paymentUserText == "none" || addressUserText == nil || deliveryTimeUserText == nil){
                let alert = UIAlertController(title: "Fill out all required fields", message: "Fill out Address, Payment, etc..", preferredStyle: .alert);
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil));
                self.reviewPage?.present(alert, animated: true, completion: nil);
            }else{
                if(userID == nil){
                    userID = "1";
                    addressIDText = "1";
                    
                }
                
                if(self.customerEmail == nil){
                    customerEmail = "ondeliveryllc@gmail.com";
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
                    let postString = "stripeToken=\(token)&totalSum=\(self.orderTotalSum)&email=\(self.customerEmail!)";
                    print(postString);
                    conn.connect(fileName: "stripeOrder.php", postString: postString, completion: { (result) in
                    })
                }
                
                if(self.numberOfFreeOrders! > 0 && self.orderTotalSum! <= 20.0){
                    self.numberOfFreeOrders = numberOfFreeOrders! - 1;
                }
                
                let time = Date();
                let timeFormatter = DateFormatter();
                timeFormatter.dateFormat = "MM/dd/yyy hh:mm a";
                timeFormatter.amSymbol = "AM";
                timeFormatter.pmSymbol = "PM";
                let string = timeFormatter.string(from: time);
                let infoArray = [self.userID!, string, addressIDText!, deliveryTimeUserText!, self.customerPhone!, self.customerName!, addressUserText!];//delivery can be "ASAP" or another time
                let json:[String: Any] = ["userInfo":infoArray,"totalSum":(orderTotalSum),"foodNames":self.names, "foodPrices":self.prices, "foodQuantity":self.quantity, "foodIDs":self.id, "restID":self.restaurantID, "freeOrders":numberOfFreeOrders!];
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
                                }catch{
                                    print("error");
                                }
                                
                                order.setValue(dataFoodNames, forKey: "foodNames");
                                order.setValue(dataFoodPrices, forKey: "foodPrices");
                                order.setValue(dataFoodQuantity, forKey: "foodQuantity");
                                order.setValue(dataFoodIDs, forKey: "foodIDs");
                                
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
                                self.reviewPage?.navigationController?.popToRootViewController(animated: true);
                            }))
                            self.reviewPage?.present(alert, animated: true, completion: nil);
                            
                        }
                        
                    }
                }
                task.resume();
            }
        }
    }
    
}
