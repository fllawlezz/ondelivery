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
    
    var logo: UIImageView = {
        let logo = UIImageView();
        logo.translatesAutoresizingMaskIntoConstraints = false;
        logo.image = UIImage(named: "OnDeliveryLogo");
        return logo;
    }()
    
    lazy var spinningView: SpinningView = {
        let spinningView = SpinningView();
        spinningView.frame = CGRect(x: (self.view.frame.width/2)-25, y: (self.view.frame.height/2)-25, width: 50, height: 50);
        return spinningView;
    }()
    
    var coreDataRestaurants = [NSManagedObject]();
    var restaurantIDs = [String]();
    var lastUpdateDates = [String]();
    var advertisedRestaurants = [Restaurant]();
    var homePageRestaurants = [Restaurant]();
    var locManager: CLLocationManager!
    var userCity: String?{
        didSet{
            //load core data
            userCurrentCity = userCity!;
            self.loadCoreData();
        }
    }

    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.appYellow;
        setupLogo();
        setupSpinningView();
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
//        let context = appDelegate.persistentContainer.viewContext;
//        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "RestaurantData");
//
//        let request = NSBatchDeleteRequest(fetchRequest: fetch);
//        do{
//            try context.execute(request);
//            try context.save();
//        }catch{
//            print("Error");
//        }
        
        //get the user's position
        if(CLLocationManager.locationServicesEnabled()){
            self.getLocation();
        }
    }
    
    fileprivate func setupLogo(){
        self.view.addSubview(logo);
        logo.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true;
        logo.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80).isActive = true;
        logo.widthAnchor.constraint(equalToConstant: 150).isActive = true;
        logo.heightAnchor.constraint(equalToConstant: 150).isActive = true;
    }
    
    fileprivate func setupSpinningView(){
        self.view.addSubview(spinningView);
        spinningView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true;
        spinningView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true;
        spinningView.widthAnchor.constraint(equalToConstant: 50).isActive = true;
        spinningView.heightAnchor.constraint(equalToConstant: 50).isActive = true;
    }
    
    fileprivate func showInternetConnectionError(){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Ugh-Oh!", message: "There was a problem with your connection!! Please try again later", preferredStyle: .alert);
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil));
            self.present(alert, animated: true, completion: nil);
        }
    }
    
    fileprivate func showServerSideError(){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Ugh-Oh!", message: "We are having a problem with our servers! We will fix thsi problem as soon as we can! Sorry for the inconvenience! :( ", preferredStyle: .alert);
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil));
            self.present(alert, animated: true, completion: nil);
        }
    }
    
    fileprivate func getCity(){
        let url: URL = URL(string: "https://onDeliveryinc.com/cityLookUp.php")!;
        let postBody = "UserLatitude=\(userLatitude!)&UserLongitude=\(userLongtiude!)";
        var request:URLRequest = URLRequest(url: url);
        request.httpMethod = "POST";
        request.httpBody = postBody.data(using: String.Encoding.utf8);
        let task = URLSession.shared.dataTask(with: request) { (data, response, errorOrNil) in
            if let error = errorOrNil{
                print("error");
                switch error{
                case URLError.networkConnectionLost, URLError.notConnectedToInternet:
                    self.showInternetConnectionError();
                    return;
                default: self.showServerSideError();
                return;
                }
            }
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!;
            DispatchQueue.main.async {
                self.userCity = responseString as String;
            }
            
            //            print(responseString);
            
            
        }
        task.resume();
    }
    
    private func loadCoreData(){
        //load addresses from core data
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext;
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Address");
        let fetchOrders = NSFetchRequest<NSManagedObject>(entityName: "Order");
        let fetchRestaurants = NSFetchRequest<NSManagedObject>(entityName: "RestaurantData");
        let sortOrders = NSSortDescriptor(key: "date", ascending: false);
        fetchOrders.sortDescriptors = [sortOrders];
        fetchOrders.fetchLimit = 10;
        
        if let userCity = self.userCity{
//            print(userCity);
            let city = "Santa Cruz"
            let sortRestaurants = NSPredicate(format: "city == %@", city);
            fetchRestaurants.predicate = sortRestaurants;
        }
        
        let fetchCards = NSFetchRequest<NSManagedObject>(entityName: "Card");
        
        do{
            addresses = try managedContext.fetch(fetchRequest);
            orders = try managedContext.fetch(fetchOrders);
            cCards = try managedContext.fetch(fetchCards);
            coreDataRestaurants = try managedContext.fetch(fetchRestaurants);
        }catch{
            print("could not load addresses,orders,cards");
        }
        
//        print(addresses.count);
//        print(coreDataRestaurants.count);
//        for restaurant in coreDataRestaurants{
//            print(restaurant.value(forKey: "restaurantID") as! String);
//        }
//        print(coreDataRestaurants[0].value(forKey: "lastUpdateDate"));
        
        //once it fetches, check to see if restaurants are up to date, etc.
        sortRestaurantData();
        updateRestaurants();
        
    }
    
    fileprivate func removeRestaurantFromList(deleteRestaurantID: String){
        print(deleteRestaurantID);
        
        print("coreDataCount:\(coreDataRestaurants.count)");
        
        var count = 0;
        while(count<restaurantIDs.count){
            let restaurantID = restaurantIDs[count];
            if(deleteRestaurantID == restaurantID){
                self.coreDataRestaurants.remove(at: count);
                return;
            }
            
            count += 1;
        }
        
//        while(count<coreDataRestaurants.count){
////            print(count);f
//
//            print(coreDataRestaurants[count].value(forKey: "restaurantID") as! String);
//
//            let restaurantID = coreDataRestaurants[count].value(forKey: "restaurantID") as! String;
//            if(restaurantID == deleteRestaurantID){
//                coreDataRestaurants.remove(at: count);
//                return;
//            }
//            count += 1;
//        }
    }
    
    fileprivate func sortRestaurantData(){
        for restaurantData in coreDataRestaurants{
            restaurantIDs.append(restaurantData.value(forKey: "restaurantID") as! String);
            lastUpdateDates.append(restaurantData.value(forKey: "lastUpdateDate") as! String);
        }
        
    }
    
    fileprivate func deleteOldRestaurantData(restaurantID: String){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext;
        
        let fetchPredicate = NSPredicate(format: "restaurantID == %@", restaurantID);
        let fetchRestaurant = NSFetchRequest<NSManagedObject>(entityName: "RestaurantData");
        fetchRestaurant.predicate = fetchPredicate;
        fetchRestaurant.returnsObjectsAsFaults = false;
        
        do{
            let restaurantArray = try managedContext.fetch(fetchRestaurant);
            for restaurantObject in restaurantArray{
                managedContext.delete(restaurantObject);
            }
            
            try managedContext.save();
        }catch{
            print("loading found RestaurantError");
        }
    }
    
    fileprivate func appendRestaurant(name: String, address: String, id: String, advertised: String, telephone: String, openHour: String, closeHour: String, picURL: String, city: String, distance: Double, buildingImage: UIImage, updateDate: String) -> Restaurant{
        
        let newRestaurant = Restaurant();
        
        newRestaurant.restaurantTitle = name;
        newRestaurant.restaurantAddress = address
        newRestaurant.restaurantID = id
        newRestaurant.restaurantIsAdvertised = advertised
        newRestaurant.restaurantTelephone = telephone
        newRestaurant.restaurantOpenHour = openHour
        newRestaurant.restaurantCloseHour = closeHour
        newRestaurant.restaurantBuildingPicURL = picURL
        newRestaurant.restaurantCity = city
        newRestaurant.restaurantDistance = distance
        newRestaurant.restaurantBuildingImage = buildingImage
        newRestaurant.updateDate = updateDate;
        
        self.homePageRestaurants.append(newRestaurant);
        
        return newRestaurant;
        
    }
    
    fileprivate func saveCoreData(newRestaurant: Restaurant){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext;
        
        var buildingImageData: Data?
        
        if let buildingImage = newRestaurant.restaurantBuildingImage{
            buildingImageData = UIImagePNGRepresentation(buildingImage);
        }
        
        let entity = NSEntityDescription.entity(forEntityName: "RestaurantData", in: managedContext)!;
        let restaurantObject = NSManagedObject(entity: entity, insertInto: managedContext);
        restaurantObject.setValue(newRestaurant.restaurantTitle!, forKey: "restaurantName");
        restaurantObject.setValue(newRestaurant.restaurantID!, forKey: "restaurantID");
        restaurantObject.setValue(newRestaurant.restaurantAddress!, forKey: "restaurantAddress");
        restaurantObject.setValue(newRestaurant.restaurantIsAdvertised!, forKey: "restaurantAdvertised");
        restaurantObject.setValue(newRestaurant.restaurantTelephone!, forKey: "restaurantTelephone");
        restaurantObject.setValue(newRestaurant.restaurantOpenHour!, forKey: "restaurantOpenTime");
        restaurantObject.setValue(newRestaurant.restaurantCloseHour!, forKey: "restaurantCloseTime");
        restaurantObject.setValue(newRestaurant.restaurantBuildingPicURL!, forKey: "restaurantPicUrl");
        restaurantObject.setValue(newRestaurant.restaurantCity!, forKey: "city");
        restaurantObject.setValue(newRestaurant.restaurantDistance!, forKey: "distance");
        restaurantObject.setValue(newRestaurant.updateDate!, forKey: "lastUpdateDate");
        
        if let buildingImageData = buildingImageData{
            restaurantObject.setValue(buildingImageData, forKey: "restaurantBuildingImage");
        }
        
        do{
            try managedContext.save();
            //set object
        }catch{
            fatalError();
        }
    }
    
    //MARK: LOAD IMAGE
    private func loadImage(urlString: String)-> UIImage{
        let url = URL(string: urlString);
        let data = try? Data(contentsOf: url!);
        let image = UIImage(data: data!);
        return image!;
    }

    fileprivate func handleToHomePage(){
        DispatchQueue.main.async {
            let customTabController = CustomTabBarController();
            
            customTabController.mainPage.advertisedRestaurants = self.advertisedRestaurants;
            customTabController.mainPage.restaurants = self.homePageRestaurants;
            
            self.present(customTabController, animated: true, completion: nil);
        }
    }
    
}

extension SplashPage{
    
    //MARK: Get Locations
    func getLocation(){
        //get the user's position
        locManager = CLLocationManager();
        locManager.requestWhenInUseAuthorization();
        locManager.desiredAccuracy = kCLLocationAccuracyBest;
        locManager.delegate = self;
        locManager.requestLocation();
//        print("getting Location");
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error);
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.locManager.stopUpdatingLocation();
        self.locManager.delegate = nil;
        let locValue:CLLocationCoordinate2D = (locManager.location?.coordinate)!;
        userLatitude = String(format: "%f",locValue.latitude);
        userLongtiude = String(format: "%f",locValue.longitude);
        self.getCity();
    }
}

extension SplashPage{
    //MARK: Updating restaurants;
    //MARK: Get data HomeScreen
    //get the data for homescreen and the recommended.
    private func updateRestaurants(){
//        print(self.userCity!);
        
        if let userCity = self.userCity{
//            print("restaurantIds:\(self.restaurantIDs.count)")
            
            let city = "Santa Cruz";
            userCurrentCity = "Santa Cruz"
            let userInfoArray = [userLatitude!,userLongtiude!,city];
            
            let jsonArray:[String:Any] = ["restaurantIDs":restaurantIDs,"restaurantUpdateDates":lastUpdateDates,"userInfo":userInfoArray];
            
            let jsonData = try? JSONSerialization.data(withJSONObject: jsonArray, options: .prettyPrinted);
            
            let url: URL = URL(string: "https://ondeliveryinc.com/UpdateRestaurantData.php")!;
            var request:URLRequest = URLRequest(url: url);
            request.httpMethod = "POST";
            request.httpBody = jsonData;
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, errorOrNil) in
                if let error = errorOrNil{
                    print("error");
                    
                    switch error{
                    case URLError.networkConnectionLost, URLError.notConnectedToInternet:
                        self.showInternetConnectionError()
                        return;
                    default: self.showServerSideError();return;
                    }
                }
                
                let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)! as String;
                if(responseString != "none"){
                    DispatchQueue.main.async {
                        do{
                            let restaurantJsonArray = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSDictionary
                            
//                            print(restaurantJsonArray);
                            
                            let updateRestaurantIDs = restaurantJsonArray["updateRestaurantIDs"] as! NSArray;
                            let restaurantNames = restaurantJsonArray["restaurantNames"] as! NSArray;
                            let restaurantAddress = restaurantJsonArray["restaurantAddresses"] as! NSArray;
                            let restaurantAdvertises = restaurantJsonArray["restaurantAdvertises"] as! NSArray;
                            let restaurantTelephones = restaurantJsonArray["restaurantTelephones"] as! NSArray;
                            let restaurantOpens = restaurantJsonArray["restaurantOpens"] as! NSArray;
                            let restaurantCloses = restaurantJsonArray["restaurantCloses"] as! NSArray;
                            let restaurantPicUrls = restaurantJsonArray["restaurantPics"] as! NSArray;
                            let restaurantCities = restaurantJsonArray["restaurantCity"] as! String;
                            let restaurantDistance = restaurantJsonArray["restaurantDistance"] as! NSArray;
                            let updateDates = restaurantJsonArray["lastUpdate"] as! NSArray;
                            
                            //search through restaurantIDs and match the ones with updateRestaurantIDs, delete them for coreData, and then resave the data with url pic
                            var count = 0;
                            while(count<updateRestaurantIDs.count){
                                let newRestaurantID = updateRestaurantIDs[count] as! String
                                let exists = self.restaurantIDs.contains(newRestaurantID);//returns true or fales if the arrya contains the item
                                
                                let name = restaurantNames[count] as! String;
                                let address = restaurantAddress[count] as! String;
                                let id = updateRestaurantIDs[count] as! String;
                                let advertised = restaurantAdvertises[count] as! String;
                                let telephone = restaurantTelephones[count] as! String;
                                let openHour = restaurantOpens[count] as! String;
                                let closeHour = restaurantCloses[count] as! String;
                                let picURL = restaurantPicUrls[count] as! String;
                                let city = restaurantCities;
                                let distance = restaurantDistance[count] as! Double
                                let updateDate = updateDates[count] as! String;
                                
                                //                            let distance = Double(restaurantDistance[count] as! Double)!;
                                let buildingPic = self.loadImage(urlString: restaurantPicUrls[count] as! String);
                                
                                if(exists){
                                    //update the data
                                    self.deleteOldRestaurantData(restaurantID: newRestaurantID);
                                    self.removeRestaurantFromList(deleteRestaurantID: newRestaurantID);
                                    let newRestaurant = self.appendRestaurant(name: name, address: address, id: id, advertised: advertised, telephone: telephone, openHour: openHour, closeHour: closeHour, picURL: picURL, city: city, distance: distance, buildingImage: buildingPic, updateDate: updateDate);
                                    self.saveCoreData(newRestaurant: newRestaurant);
                                }else{
                                    //doesn't exist
                                    let newRestaurant = self.appendRestaurant(name: name, address: address, id: id, advertised: advertised, telephone: telephone, openHour: openHour, closeHour: closeHour, picURL: picURL, city: city, distance: distance, buildingImage: buildingPic, updateDate: updateDate);
                                    self.saveCoreData(newRestaurant: newRestaurant);
                                }
                                
                                
                                
                                count+=1;
                            }
                            
                            self.appendCoreDataRestaurants();
                            self.sortAdvertisedRestaurants();
                            self.handleToHomePage();
                            
                        }catch{
                            print("jsonArray error");
                        }
                    }
                    
                }else{
                    print("none");
                    DispatchQueue.main.async {
                        self.appendCoreDataRestaurants();
                        self.sortAdvertisedRestaurants();
                        self.handleToHomePage();
                    }
                }
                
            }
            task.resume();
        }
    }
    
    fileprivate func appendCoreDataRestaurants(){
        //add the rest of the original restaurants
        for restaurant in coreDataRestaurants{
            let name = restaurant.value(forKey: "restaurantName") as! String;
            let address = restaurant.value(forKey: "restaurantAddress") as! String;
            let id = restaurant.value(forKey: "restaurantID") as! String;
            let advertised = restaurant.value(forKey: "restaurantAdvertised") as! String;
            let telephone = restaurant.value(forKey: "restaurantTelephone") as! String;
            let openHour = restaurant.value(forKey: "restaurantOpenTime") as! String;
            let closeHour = restaurant.value(forKey: "restaurantCloseTime") as! String;
            let picURL = restaurant.value(forKey: "restaurantPicUrl") as! String;
            let city = restaurant.value(forKey: "city") as! String;
            let distance = restaurant.value(forKey: "distance") as! Double;
            let buildingPic = UIImage(data: restaurant.value(forKey: "restaurantBuildingImage") as! Data)
            let updateDate = restaurant.value(forKey: "lastUpdateDate") as! String;
            
            
            _ = appendRestaurant(name: name, address: address, id: id, advertised: advertised, telephone: telephone, openHour: openHour, closeHour: closeHour, picURL: picURL, city: city, distance: distance, buildingImage: buildingPic!, updateDate: updateDate);
        }
        
//        print(self.homePageRestaurants.count);
        
    }
    
    fileprivate func sortAdvertisedRestaurants(){
        
        for restaurant in homePageRestaurants{
            if(restaurant.restaurantIsAdvertised! == "Y"){
                self.advertisedRestaurants.append(restaurant);
            }
        }
        
    }
}
