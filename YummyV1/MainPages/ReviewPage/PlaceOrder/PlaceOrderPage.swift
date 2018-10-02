//
//  PlaceOrderPage.swift
//  YummyV1
//
//  Created by Brandon In on 7/24/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit
import Stripe
import CoreData

class PlaceOrderPage: UIViewController, UserOptionsTableDelegate, PlaceOrderButtonDelegate {
    
    lazy var userOptionsTable: UserOptionsTable = {
        let layout = UICollectionViewFlowLayout();
        let userOptionsTable = UserOptionsTable(frame: .zero, collectionViewLayout: layout);
        return userOptionsTable;
    }()
    
    lazy var placeOrderButton: PlaceOrderButton = {
        let placeOrderButton = PlaceOrderButton(backgroundColor: UIColor.appYellow, title: "Place Order", font: UIFont.montserratSemiBold(fontSize: 16), fontColor: UIColor.black);
        return placeOrderButton;
    }()
    
    var menuItemArray: [MainItem]?;
    
    var totalSum: Double?;
    var deliveryCharge: Double?;
    var taxAndFees: Double?;
    var tipTotal: Double?;
    
    var userAddress: UserAddress?;
    var deliveryTime: String?;
    var paymentCard: PaymentCard?;
    var customer: Customer?;
    
    var restaurant: Restaurant?;
    
    var optionIDs = [[[Int]]]();
    var mainFoodIDs = [Int]();
    var mainFoodQuantities = [Int]();
    var mainFoodHasOptions = [String]();
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.white;
        addObservers();
        setupNavBar();
        setupUserOptionsTable();
        setupPlaceOrderButton();
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self);
    }
    
    fileprivate func addObservers(){
        let name = Notification.Name(rawValue: updateTipsValueNotification);
        let showAlertName = Notification.Name(rawValue: showTipsAlert);
        
        NotificationCenter.default.addObserver(self, selector: #selector(setTipTotal(notification:)), name: name, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(self.showTipAlert), name: showAlertName, object: nil);
    }
    
    fileprivate func setupNavBar(){
        self.title = "Place Order";
        self.navigationItem.title = "PlaceOrder";
        
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil);
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton;
    }
    
    fileprivate func setupUserOptionsTable(){
        self.view.addSubview(userOptionsTable);
        userOptionsTable.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 5).isActive = true;
        userOptionsTable.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -5).isActive = true;
        userOptionsTable.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 5).isActive = true;
        if #available(iOS 11.0, *) {
            userOptionsTable.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -65).isActive = true
        } else {
            // Fallback on earlier versions
            userOptionsTable.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -65).isActive = true;
        };
        userOptionsTable.userOptionsDelegate = self;
        userOptionsTable.orderTotal = self.totalSum;
        userOptionsTable.deliveryCharge = self.deliveryCharge;
        userOptionsTable.taxesAndFees = self.taxAndFees;
        
    }
    
    fileprivate func setupPlaceOrderButton(){
        self.view.addSubview(placeOrderButton);
        placeOrderButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true;
        placeOrderButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true;
        if #available(iOS 11.0, *) {
            placeOrderButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        } else {
            // Fallback on earlier versions
            placeOrderButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -10).isActive = true;
        };
        
        placeOrderButton.heightAnchor.constraint(equalToConstant: 50).isActive = true;
        placeOrderButton.delegate = self;
    }
    
}

extension PlaceOrderPage{
    func toAddressPage() {
        let addressPage = UserOptionAddressPage();
        addressPage.delegate = userOptionsTable;
        self.navigationController?.pushViewController(addressPage, animated: true);
    }
    
    func toDeliveryTimePage(){
        let deliveryTimePage = DeliveryTimePage();
        deliveryTimePage.deliveryTimeDelegate = userOptionsTable;
        self.navigationController?.pushViewController(deliveryTimePage, animated: true);
    }
    
    func toPaymentPage(){
        let paymentPage = PaymentPage();
        paymentPage.paymentPageDelegate = userOptionsTable;
        self.navigationController?.pushViewController(paymentPage, animated: true);
    }
    
    func toCredentialsPage(){
        let credentialsPage = CustomerCredentialsPage();
        credentialsPage.customerCredentialsPageDelegate = userOptionsTable;
        self.navigationController?.pushViewController(credentialsPage, animated: true);
    }
    
    @objc fileprivate func setTipTotal(notification: NSNotification){
        if let info = notification.userInfo{
            let tipTotal = info["tipTotal"] as! Double;
            self.tipTotal = tipTotal;
        }
    }
    
    func setAddress(userAddress: UserAddress) {
        let address = UserAddress();
        address.address = userAddress.address;
        address.addressID = userAddress.addressID;
        address.city = userAddress.city;
        address.state = userAddress.state;
        address.zipcode = userAddress.zipcode;
        
        self.userAddress = address;
    }
    
    func setDeliveryTime(deliveryTime: String) {
        self.deliveryTime = deliveryTime;
    }
    
    func setPaymentCard(paymentCard: PaymentCard) {
        let card = PaymentCard();
        card.cardNumber = paymentCard.cardNumber;
        card.cvcNumber = paymentCard.cvcNumber;
        card.expirationDate = paymentCard.expirationDate;
        card.cardID = paymentCard.cardID;
        
        self.paymentCard = card;
    }
    
    
    @objc fileprivate func showTipAlert(){
        let tipAlert = UIAlertController(title: "Tip", message: "Enter the tip amount: ", preferredStyle: .alert);
        tipAlert.addTextField { (textField) in
            textField.placeholder = "0.00";
            textField.keyboardType = .numberPad;
            textField.textAlignment = .center;
        }
        tipAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            let textField = tipAlert.textFields![0];
            if(textField.text!.count > 0){
                let name = Notification.Name(rawValue: updateTipsValueNotification);
                let textFieldStringDouble = Double(textField.text!)!;
                let info = ["tipTotal":textFieldStringDouble];
                NotificationCenter.default.post(name: name, object: nil, userInfo: info);
            }
        }))
        self.present(tipAlert, animated: true, completion: nil);
    }
}

extension PlaceOrderPage{
    func placeOrder(){
//        print("place order");
        if(user == nil){
            //get customer data
            self.customer = userOptionsTable.customer;
            if let customer = self.customer{
                let checkNil = customer.isNil();
                if(checkNil){//if customer is nil
                    self.showUserCredentialsAlert();
                    return;
                }
                self.customer!.customerPhone = formatTelephone(telephone: self.customer!.customerPhone!);
                handlePlaceOrder();
            }
        }else{
            //check for all data
            if(self.deliveryTime == nil || self.paymentCard == nil || self.userAddress == nil){
                self.showUserCredentialsAlert();
                return;
            }
            //create customer
            //update user orders
            updateUserOrders();
            createCustomer();
            //place order
            handlePlaceOrder();
        }
    }
    
    fileprivate func createCustomer(){
        let customer = Customer();
        customer.customerEmail = user!.email!;
        customer.customerName = user!.firstName!;
        customer.customerPhone = formatTelephone(telephone: user!.telephone!);
        customer.customerID = user!.userID!;
        
        self.customer = customer;
    }
    
    fileprivate func updateUserOrders(){
        if(totalSum! > 20 && user!.freeOrders! > 0){
            user!.freeOrders! -= 1;
        }
    }
    
    func showUserCredentialsAlert(){
        let alert = UIAlertController(title: "Ugh-Oh!", message: "Please fill out all required fields to place your order!!", preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil));
        self.present(alert, animated: true, completion: nil);
    }
}

extension PlaceOrderPage{
    fileprivate func setDate()->String{
        let time = Date();
        let timeFormatter = DateFormatter();
        timeFormatter.dateFormat = "MM/dd/yyy hh:mm a";
        timeFormatter.amSymbol = "AM";
        timeFormatter.pmSymbol = "PM";
        let date = timeFormatter.string(from: time);
        return date;
    }
    
    fileprivate func formatTelephone(telephone: String)->String{
        var numberString = telephone
        numberString.insert("(", at: numberString.startIndex);
        numberString.insert(")", at: numberString.index(numberString.startIndex, offsetBy: 4));
        numberString.insert("-", at: numberString.index(numberString.startIndex, offsetBy: 5));
        numberString.insert("-", at: numberString.index(numberString.startIndex, offsetBy: 9));
        
//        self.customer!.customerPhone = numberString;
        //        print(self.customer!.customerPhone!);
        return numberString;
        
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
    
    fileprivate func getOrderDetails(){
        var count = 0;
        while(count < menuItemArray!.count){
            let mainItem = menuItemArray![count];
            if(mainItem.hasOptions){
                self.mainFoodHasOptions.append("Y");
                //loop through foodItems and get each of the specialoptions and add them to an array
                let itemOptions = getSpecialOptions(mainItem: mainItem);
                self.mainFoodIDs.append(Int(mainItem.id)!);
                self.mainFoodQuantities.append(mainItem.quantity);
                self.optionIDs.append(itemOptions);
            }else{
                //get foodID and quantity
                self.mainFoodHasOptions.append("N");
                var count = 0;
                var itemOptions = [[Int]]();
                while(count < mainItem.quantity){
                    let fakeOption = [0];
                    itemOptions.append(fakeOption);
                    count+=1;
                }
                self.mainFoodQuantities.append(mainItem.quantity);
                self.mainFoodIDs.append(Int(mainItem.id)!);
                self.optionIDs.append(itemOptions);
            }
            count+=1;
        }
    }
    
    fileprivate func sendToken(){
        //create stripe Token, send to server, save to core data, alert view
        //MARK: Create Token
        let cardParams = STPCardParams();
        cardParams.number = self.paymentCard!.cardNumber!;
        let expirationArray = self.paymentCard!.expirationDate!.components(separatedBy: "/");
        
        cardParams.expMonth = UInt((expirationArray[0] as NSString).integerValue);
        cardParams.expYear = UInt((expirationArray[1] as NSString).integerValue);
        cardParams.cvc = self.paymentCard!.cvcNumber!;
        
        STPAPIClient.shared().createToken(withCard: cardParams) { (token: STPToken?, error: Error?) in
            guard let token = token, error == nil else {
                // Present error to user...
                return;
            }
            let orderCharge = String(format: "%.2f", self.totalSum!);
            let postBody = "stripeToken=\(token)&totalSum=\(orderCharge)&email=\(self.customer!.customerEmail!)"
            let conn = Conn();
            conn.connect(fileName: "stripeOrder.php", postString: postBody, completion: { (result) in
            })
            self.handlePlaceOrder();
        }
    }
    
    fileprivate func handlePlaceOrder(){
        let date = self.setDate();
        let infoArray = [self.customer!.customerID!, date, self.userAddress!.addressID!, self.deliveryTime!, self.customer!.customerPhone!, self.customer!.customerName!, self.userAddress?.address!];
        
        let json:[String: Any] = ["userInfo":infoArray,"deliveryCharge":self.deliveryCharge!,"totalSum":(self.totalSum!),"tip":self.tipTotal!,"foodQuantity":self.mainFoodQuantities, "foodIDs":self.mainFoodIDs,"optionIDs":self.optionIDs,"hasOptions":self.mainFoodHasOptions,"restID":self.restaurant!.restaurantID!, "freeOrders":user!.freeOrders!];
        
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
                    if(user != nil){
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
                        let context = appDelegate.persistentContainer.viewContext;
                        let entity = NSEntityDescription.entity(forEntityName: "Order", in: context)!;
                        let order = NSManagedObject(entity: entity, insertInto: context);
                        //restaurant, price, orderID,image,date
                        
                        order.setValue(self.restaurant!.restaurantTitle!, forKey: "restaurantName");
                        order.setValue(self.totalSum!, forKey: "price");
                        order.setValue(re, forKey: "orderID");
                        order.setValue(date, forKey: "date");
                        order.setValue(self.restaurant!.restaurantID!, forKey: "restaurantID");
                        
                        let imageData = (UIImagePNGRepresentation(self.restaurant!.restaurantBuildingImage!) as Data?);
                        order.setValue(imageData, forKey: "image");
                        
                        do{
                            try context.save();
                            orders.append(order);
                        }catch{
                            print("error");
                        }
                    }
                    
                    let alert = UIAlertController(title: "Order Placed", message: "Your order has been placed!", preferredStyle: UIAlertControllerStyle.alert);
                    alert.addAction(UIAlertAction(title: "Ok!", style: UIAlertActionStyle.default, handler: { (result) in
                        self.navigationController?.popToRootViewController(animated: true);
                    }))
                    self.present(alert, animated: true, completion: nil);
                    
                }
                
            }
        }
        task.resume();
    }
}


