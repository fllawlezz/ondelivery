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
            self.customer = reviewPage?.customer;
            self.orderTotalSum = reviewPage!.orderTotal;
        }
    }
    
    var restaurant: Restaurant?
    
    var customer: Customer?
    
    var deliveryTime: String?;
    var userAddress: UserAddress?;
    var paymentCard: PaymentCard?;
    var deliveryCharge: Double?
    
    var orderTotalSum: Double!;
    var numberOfFreeOrders: Int?;
    var mainItems:[MainItem]?;
    
    //arrays for items
    var optionIDs = [[[Int]]]();
    var mainFoodIDs = [Int]();
    var mainFoodQuantities = [Int]();
    var mainFoodHasOptions = [String]();
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        setup();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setup(){
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.titleLabel?.font = UIFont.montserratSemiBold(fontSize: 18);
        self.setTitleColor(UIColor.black, for: .normal);
        self.backgroundColor = UIColor.appYellow;
//        self.target(forAction: #selector(self.nextPush), withSender: self);
        self.addTarget(self, action: #selector(self.nextPush), for: .touchUpInside);
    }
    
    func setTitle(buttonTitle: String){
//        self.setTitle(buttonTitle: buttonTitle);
        self.setTitle(buttonTitle, for: .normal);
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
    
    fileprivate func setDate()->String{
        let time = Date();
        let timeFormatter = DateFormatter();
        timeFormatter.dateFormat = "MM/dd/yyy hh:mm a";
        timeFormatter.amSymbol = "AM";
        timeFormatter.pmSymbol = "PM";
        let date = timeFormatter.string(from: time);
        return date;
    }
    
    @objc func nextPush(){
        //        print("pushed");
        renewOrderData();
        if(self.customer?.customerEmail != nil && self.customer?.customerName != nil && self.customer?.customerPhone != nil){
            
            if(user?.userID == nil && customer!.customerPhone! == "none" && customer!.customerName! == "none"){
                let alert = UIAlertController(title: "Fill out all required fields", message: "Fill out Address, Payment, etc..", preferredStyle: .alert);
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil));
                self.reviewPage?.present(alert, animated: true, completion: nil);
            }else{
                if(paymentCard == nil || self.userAddress == nil || self.deliveryTime == nil){
                    let alert = UIAlertController(title: "Fill out all required fields", message: "Fill out Address, Payment, etc..", preferredStyle: .alert);
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil));
                    self.reviewPage?.present(alert, animated: true, completion: nil);
                }else{
                    print("stage 2");
                    if(user == nil){
                        formatTelephone();
                        user = User(firstName: self.customer!.customerName!, lastName: "Checkout", userID: "1", email: self.customer!.customerEmail!, telephone: self.customer!.customerPhone!, subscriptionPlan: "NONE", freeOrders: 0);
                        
                    }
                    sendToken();
                    
                    
                }
            }
        }
    }
    
    fileprivate func formatTelephone(){
        var numberString = self.customer!.customerPhone!
        numberString.insert("(", at: numberString.startIndex);
        numberString.insert(")", at: numberString.index(numberString.startIndex, offsetBy: 4));
        numberString.insert("-", at: numberString.index(numberString.startIndex, offsetBy: 5));
        numberString.insert("-", at: numberString.index(numberString.startIndex, offsetBy: 9));
        
        self.customer!.customerPhone = numberString;
//        print(self.customer!.customerPhone!);

    }
    
    fileprivate func renewOrderData(){
//        print("renew");
        self.customer = reviewPage!.customer;
        self.paymentCard = reviewPage!.paymentCard;
        self.userAddress = reviewPage!.userAddress;
        self.deliveryTime = reviewPage!.deliveryTime;
        self.mainItems = reviewPage?.mainItems;
        self.orderTotalSum = reviewPage?.orderTotal;
        self.restaurant = reviewPage?.selectedRestaurant;
        self.deliveryCharge = reviewPage?.deliveryPrice;
        
    }
    
    fileprivate func sendToken(){
//        print("placed order");
        //create stripe Token, send to server, save to core data, alert view
        //MARK: Create Token
        let cardParams = STPCardParams();
        cardParams.number = self.paymentCard!.cardNumber!;
        let expirationArray = self.paymentCard!.expirationDate!.components(separatedBy: "/");
        
        cardParams.expMonth = UInt((expirationArray[0] as NSString).integerValue);
        cardParams.expYear = UInt((expirationArray[1] as NSString).integerValue);
        cardParams.cvc = self.paymentCard!.cvcNumber!;
        
        STPAPIClient.shared().createToken(withCard: cardParams) { (token: STPToken?, error: Error?) in
//            print("make token");
            guard let token = token, error == nil else {
                // Present error to user...
                return;
            }
//            print(token);
            let orderCharge = String(format: "%.2f", self.orderTotalSum!);
            let postBody = "stripeToken=\(token)&totalSum=\(orderCharge)&email=\(self.customer!.customerEmail!)"
//            print(postBody);
            let conn = Conn();
            conn.connect(fileName: "stripeOrder.php", postString: postBody, completion: { (result) in
            })
//            print(token);
            self.handlePlaceOrder();
        }
    }
    
    fileprivate func handlePlaceOrder(){
        
        if(user!.freeOrders! > 0 && self.orderTotalSum! <= 20.0){
            user!.freeOrders! = user!.freeOrders! - 1;
        }
        
        let date = self.setDate();
        let infoArray = [user?.userID!, date, self.userAddress!.addressID!, self.deliveryTime!, self.customer!.customerPhone!, self.customer!.customerName!, self.userAddress?.address!];
        let json:[String: Any] = ["userInfo":infoArray,"deliveryCharge":self.deliveryCharge!,"totalSum":(self.orderTotalSum),"foodQuantity":self.mainFoodQuantities, "foodIDs":self.mainFoodIDs,"optionIDs":self.optionIDs,"hasOptions":self.mainFoodHasOptions,"restID":self.restaurant!.restaurantID!, "freeOrders":user!.freeOrders!];
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted);
        let jsonString = try? JSONSerialization.jsonObject(with: jsonData!, options: .allowFragments);
        print(jsonString!);
        print(self.optionIDs.count);
        
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
                    print(re);
                    
                    if(user!.userID! != "1"){
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
                        let context = appDelegate.persistentContainer.viewContext;
                        let entity = NSEntityDescription.entity(forEntityName: "Order", in: context)!;
                        let order = NSManagedObject(entity: entity, insertInto: context);
                        //restaurant, price, orderID,image,date
                        
                        order.setValue(self.restaurant!.restaurantTitle!, forKey: "restaurantName");
                        order.setValue(self.orderTotalSum, forKey: "price");
                        order.setValue(re, forKey: "orderID");
                        order.setValue(date, forKey: "date");
                        order.setValue(self.restaurant!.restaurantID!, forKey: "restaurantID");
                        
                        let imageData = (UIImagePNGRepresentation(self.restaurant!.restaurantBuildingImage!) as Data?);
                        order.setValue(imageData, forKey: "image");
                        
                        //convert arrays to data
                        //                                let  = NSKeyedArchiver.archivedData(withRootObject: self.names);
                        //                                let dataFoodPrices = NSKeyedArchiver.archivedData(withRootObject: self.prices);
                        //                                let dataFoodQuantity = NSKeyedArchiver.archivedData(withRootObject: self.quantity);
                        //                                let dataFoodIDs = NSKeyedArchiver.archivedData(withRootObject: self.quantity);
                        
                        do{
                            try context.save();
                            orders.append(order);
                        }catch{
                            print("error");
                        }
                        
                        if(user!.freeOrders! > 0){
                            user!.freeOrders! -= 1;
                        }
                        saveDefaults(defaults: defaults!);
                    }
                    
                    if(user!.userID! == "1"){
                        user = nil;
                        //                                addresses.removeAll();
                        //                                cCards.removeAll();
                    }
                    
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
