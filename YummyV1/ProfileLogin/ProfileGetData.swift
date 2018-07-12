//
//  ProfileGetData.swift
//  YummyV1
//
//  Created by Brandon In on 4/17/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit
import MapKit

extension ProfileLogin{
    func getData(){
        self.loadingTitle.text = "Loading Restaurants";
        //load TestRest
        let conn = Conn();
        let postRequest = "Latitude=\(userLatitude!)&Longitude=\(userLongtiude!)&City=\(userCurrentCity!)";
        //        dispatch.enter();
        conn.connect(fileName: "LoadRestaurants.php", postString: postRequest) { (re) in
            if urlData != nil{
                do{
                    let json = try JSONSerialization.jsonObject(with: urlData!, options: .allowFragments) as! NSDictionary;
                    
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
                    
                    print(restaurantNames.count);
                    
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
                        let foodPicURL = restaurant.restaurantAdvertisedFoodURL!;
                        let image = self.loadImage(urlString: foodPicURL);
                        restaurant.restaurantAdvertisedFoodImage = image;
                    }
                    
                    DispatchQueue.main.async {
                        defaults.set("wentThroughStartup", forKey: "startup");
                        
                        if(self.signingUp){
                            let subscriptionController = SubscriptionPage();
                            subscriptionController.fromStartUp = true;
                            subscriptionController.customTabBar = self.customTabController;
                            
                            subscriptionController.restaurants = self.restaurants;
                            subscriptionController.advertisedRestaurants = self.advertisedRestaurants;
                            
                            
                            self.navigationController?.pushViewController(subscriptionController, animated: true);
                        }else{
                            let customTabBar = CustomTabBarController();
                            let mainPage = customTabBar.mainPage;
                            let recommendedPage = customTabBar.recomendedMainPage;
                            let orderPage = customTabBar.orderPage;
                            let profilePage = customTabBar.profilePage
                            
                            mainPage?.restaurants = self.restaurants;
                            mainPage?.advertisedRestaurants = self.advertisedRestaurants;
                            
                            recommendedPage?.restaurants = self.restaurants;
                            recommendedPage?.advertisedRestaurants = self.advertisedRestaurants;
                            
                            orderPage?.pastOrders = self.pastOrders;
                            
//                            print("user address:\(self.userAddresses.count)")
//                            print("user address:\(self.userAddresses[0].value(forKey: "address") as! String)")
                            
                            profilePage?.addresses = self.userAddresses;
                            profilePage?.cards = self.cards;
                            
                            self.present(customTabBar, animated: true, completion: nil);
                        }
                    }
                }catch{
                    print("json parse error");
                }
            }
        }
    }
    
    //MARK: Get Locations
    func getLocation(){
        //get the user's position
        self.loadingTitle.text = "Getting Location"
        locManager.desiredAccuracy = kCLLocationAccuracyBest;
        locManager.delegate = self;
        //        self.dispatch.enter();
        locManager.requestLocation();
        print("getting location");
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
