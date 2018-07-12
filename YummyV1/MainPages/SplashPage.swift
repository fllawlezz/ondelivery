//
//  SplashPage.swift
//  YummyV1
//
//  Created by Brandon In on 2/8/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import CoreLocation

//load data for home page
// and load data for first recommended page


class SplashPage: UIViewController, CLLocationManagerDelegate{
    
    var logo: UIImageView!;
    var addresses = [NSManagedObject]();
    var orders = [NSManagedObject]();
    var cards = [NSManagedObject]();
    
    var pastOrders = [PastOrder]();
    var userCards = [PaymentCard]();
    var userAddresses = [UserAddress]();
    
    lazy var spinningView: SpinningView = {
        let spinningView = SpinningView();
        spinningView.frame = CGRect(x: (self.view.frame.width/2)-25, y: (self.view.frame.height/2)-25, width: 50, height: 50);
        return spinningView;
    }()
    
    var dispatch = DispatchGroup();
    var locManager: CLLocationManager!
    var placeMark: CLPlacemark!;
    
    //DATA Elements
    
    var restaurants = [Restaurant]();
    var advertisedRestaurants = [Restaurant]();
    var userID: String?
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.appYellow;
        
        if(userID != nil){
            loadCoreData()
        }
//        getData();
        logo = UIImageView();
        logo.translatesAutoresizingMaskIntoConstraints = false;
        logo.image = UIImage(named: "OnDeliveryLogo");
        self.view.addSubview(logo);
        logo.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true;
        logo.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80).isActive = true;
        logo.widthAnchor.constraint(equalToConstant: 150).isActive = true;
        logo.heightAnchor.constraint(equalToConstant: 150).isActive = true;
        
        self.view.addSubview(spinningView);
        spinningView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true;
        spinningView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true;
        spinningView.widthAnchor.constraint(equalToConstant: 50).isActive = true;
        spinningView.heightAnchor.constraint(equalToConstant: 50).isActive = true;
        
        //get the user's position
        if(CLLocationManager.locationServicesEnabled()){
            self.getLocation();
        }
    }
    
    
    private func loadCoreData(){
//        populateDefaults(defaults: defaults);
        //load addresses from core data
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext;
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Address");
        let fetchOrders = NSFetchRequest<NSManagedObject>(entityName: "Order");
        let sortOrders = NSSortDescriptor(key: "date", ascending: false);
        fetchOrders.sortDescriptors = [sortOrders];
        fetchOrders.fetchLimit = 10;
        let fetchCards = NSFetchRequest<NSManagedObject>(entityName: "Card");
        
        //load image
        do{
            self.addresses = try managedContext.fetch(fetchRequest);
            self.orders = try managedContext.fetch(fetchOrders);
            self.cards = try managedContext.fetch(fetchCards);
            
            //transfer image data into images and add to picOrdersArray
            for order in orders{
                let pastOrder = PastOrder();
                let restaurantName = order.value(forKey: "restaurantName") as! String;
                let totalSumDouble = order.value(forKey: "price") as! Double;
                let totalSumString = String(totalSumDouble);
                let orderDate = order.value(forKey: "date") as! String;
                let orderID = order.value(forKey: "orderID") as! String;
                
//                print(restaurantName);
                
                pastOrder.restaurantName = restaurantName;
                pastOrder.totalSum = totalSumString;
                pastOrder.orderDate = orderDate;
                pastOrder.orderID = orderID;
                
                pastOrders.append(pastOrder);
            }
//            print("cards");
            for card in cards{
                let userCard = PaymentCard();
                
                let cardNum = card.value(forKey: "cardNum") as! String;
                let cvcNum = card.value(forKey: "cvc") as! String;
                let expirationDate = card.value(forKey: "expiration") as! String;
                let last4Nums = card.value(forKey: "last4") as! String;
                let cardID = card.value(forKey: "cardID") as! String;
                let nickName = card.value(forKey: "nickName") as! String;
                let mainCard = card.value(forKey: "mainCard") as! String;
                
                userCard.cardNumber = cardNum;
                userCard.cvcNumber = cvcNum;
                userCard.expirationDate = expirationDate;
                userCard.last4 = last4Nums;
                userCard.cardID = cardID;
                userCard.nickName = nickName;
                userCard.mainCard = mainCard;
                
//                print(cardNum);
                
                self.userCards.append(userCard);
                
            }
            
            print("finished");
        }catch{
            print("error");
        }
        
    }
    //getData on this page to speed up user experience
    
    //MARK: Get data HomeScreen
    //get the data for homescreen and the recommended.
    private func getData(){
        //load TestRest
        let conn = Conn();
        let postRequest = "Latitude=\(userLatitude!)&Longitude=\(userLongtiude!)&City=\(userCurrentCity!)";
        //        dispatch.enter();
        conn.connect(fileName: "LoadRestaurants.php", postString: postRequest) { (re) in
        if urlData != nil{
                do{
                    let json = try JSONSerialization.jsonObject(with: urlData!, options: .allowFragments) as! NSDictionary;
//                    let results = json["results"] as! NSArray;
                    
                    let restaurantNames = json["results"] as! NSArray;
                    let restaurantIDs = json["restIDs"] as! NSArray;
                    let restaurantAddresses = json["restAddresses"] as! NSArray;
                    let restaurantTelephones = json["telephone"] as! NSArray;
                    let restaurantOpenHours = json["open"] as! NSArray;
                    let restaurantCloseHours = json["close"] as! NSArray;
                    let restaurantBuildingPics = json["urls"] as! NSArray;
                    let restaurantIsAdvertiseds = json["advertise"] as! NSArray;
                    let restaurantAdvertisedFoodPics = json["advertisePics"] as! NSArray;
                    let restaurantDistances = json["distance"] as! NSArray;

                    var count = 0;
                    while(count < restaurantNames.count){
                        let newRestaurant = Restaurant();
                        newRestaurant.restaurantTitle = restaurantNames[count] as? String;
                        newRestaurant.restaurantID = restaurantIDs[count] as? String;
                        newRestaurant.restaurantAddress = restaurantAddresses[count] as? String;
                        newRestaurant.restaurantTelephone = restaurantTelephones[count] as? String;
                        newRestaurant.restaurantOpenHour = restaurantOpenHours[count] as? String;
                        newRestaurant.restaurantCloseHour = restaurantCloseHours[count] as? String;
                        newRestaurant.restaurantBuildingPicURL = restaurantBuildingPics[count] as? String;
                        newRestaurant.restaurantIsAdvertised = restaurantIsAdvertiseds[count] as? String;
                        newRestaurant.restaurantAdvertisedFoodURL = restaurantAdvertisedFoodPics[count] as? String;
                        newRestaurant.restaurantDistance = restaurantDistances[count] as? Double
                        
                        if(newRestaurant.restaurantIsAdvertised == "Y"){
                            self.advertisedRestaurants.append(newRestaurant);
                        }
                        
                        self.restaurants.append(newRestaurant);
                        count+=1;
                    }
                    
                    //loading restaurant Building Pics
                    for restaurant in self.restaurants{
                        let url = restaurant.restaurantBuildingPicURL!
                        let image = self.loadImage(urlString: url);
                        restaurant.restaurantBuildingImage = image;
                    }
                    
                    for restaurant in self.advertisedRestaurants{
//                        print("advertised");
                        let foodPicURL = restaurant.restaurantAdvertisedFoodURL!;
                        let image = self.loadImage(urlString: foodPicURL);
                        restaurant.restaurantAdvertisedFoodImage = image;
                    }
                    
                    DispatchQueue.main.async {
                        let customTabBar = CustomTabBarController();
                        let mainPage = customTabBar.mainPage;
                        let recommendedPage = customTabBar.recomendedMainPage;
                        let orderPage = customTabBar.orderPage;
                        let profilePage = customTabBar.profilePage;
                        
                        mainPage?.restaurants = self.restaurants;
                        mainPage?.advertisedRestaurants = self.advertisedRestaurants;
                        
                        recommendedPage?.restaurants = self.restaurants;
                        recommendedPage?.advertisedRestaurants = self.advertisedRestaurants;
                        
                        orderPage?.pastOrders = self.pastOrders;
                        
//                        print(self.userCards.count);
                        profilePage?.cards = self.userCards;
                        profilePage?.addresses = self.addresses;
                        
                        self.present(customTabBar, animated: true, completion: nil);
                    }
                }catch{
                    print("json parse error");
                }
            }
        }
    }
    
    //MARK: LOAD IMAGE
    private func loadImage(urlString: String)-> UIImage{
        let url = URL(string: urlString);
        let data = try? Data(contentsOf: url!);
        let image = UIImage(data: data!);
        return image!;
    }
    
    //MARK: Get Locations
    func getLocation(){
        //get the user's position
        locManager = CLLocationManager();
        locManager.requestWhenInUseAuthorization();
        locManager.desiredAccuracy = kCLLocationAccuracyBest;
        locManager.delegate = self;
        locManager.requestLocation();
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error);
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.locManager.stopUpdatingLocation();
        self.locManager.delegate = nil;
        let locValue:CLLocationCoordinate2D = (locManager.location?.coordinate)!;
        let location = locManager.location!;
        userLatitude = String(format: "%f",locValue.latitude);
        userLongtiude = String(format: "%f",locValue.longitude);
        
        //        dispatch.enter();
        let geoCoder = CLGeocoder();
        geoCoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if(error == nil && placemarks!.count > 0){
                //                print("getLocation");
                self.placeMark = placemarks?.last;
                userCurrentCity = self.placeMark.locality;
                self.locManager.stopUpdatingLocation();
                self.getData();
            }
        }
    }
    
    
}
