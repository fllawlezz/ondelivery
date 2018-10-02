//
//  HomePage.swift
//  YummyV1
//
//  Created by Brandon In on 11/15/17.
//  Copyright © 2017 Rendered Co.RaftPod. All rights reserved.
//

import UIKit
import CoreLocation;

//MARK: public

class HomePage: UIViewController,UIScrollViewDelegate, UITextFieldDelegate, UIGestureRecognizerDelegate, CLLocationManagerDelegate, HomePageCollectionViewDelegate {
    
    var searchBarView: SearchBarView = {
        let searchBarView = SearchBarView();
        return searchBarView;
    }()
    
    var searchTable: SearchTable = {
        let searchTable = SearchTable();
        return searchTable;
    }()
    
    var loadingView: LoadingView = {
        let loadingView = LoadingView();
        return loadingView;
    }()
    
    var errorAlertController: ErrorAlertController = {
        let errorAlertController = ErrorAlertController();
        errorAlertController.modalPresentationStyle = .overCurrentContext;
        return errorAlertController;
    }()
    
    var darkView: UIView = {
        let darkView = UIView();
        darkView.translatesAutoresizingMaskIntoConstraints = false;
        darkView.alpha = 0;
        darkView.backgroundColor = UIColor.black;
        return darkView;
    }()
    
    fileprivate var searchBar: TextFieldPadded = {
        let searchBar = TextFieldPadded()
        searchBar.translatesAutoresizingMaskIntoConstraints = false;
        searchBar.layer.cornerRadius = 5;
        searchBar.backgroundColor = UIColor.white;
        searchBar.font = UIFont(name: "Montserrat-Regular", size: 12);
        searchBar.alpha = 0.7;
        searchBar.placeholder = "Restaurants Near Me";
        return searchBar;
    }()
    private var searchResults: UITableView!;
    
    
    fileprivate var cancelButton: UIButton = {
        let cancelButton = UIButton();
        cancelButton.translatesAutoresizingMaskIntoConstraints = false;
        cancelButton.setTitle("cancel", for: .normal);
        cancelButton.setTitleColor(UIColor.white, for: .normal);
        cancelButton.isHidden = true;
        return cancelButton;
    }()
    fileprivate var searchButton: UIButton = {
        let searchButton = UIButton(type: .system)
        searchButton.translatesAutoresizingMaskIntoConstraints = false;
        searchButton.backgroundColor = UIColor.appYellow;
        searchButton.setTitle("Search", for: .normal);
        searchButton.setTitleColor(UIColor.black, for: .normal);
        searchButton.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 12);
        searchButton.layer.cornerRadius = 3;
        searchButton.alpha = 0.7;
        return searchButton;
    }()
    
    var homePageCollectionView: HomePageCollectionView = {
        let flowLayout = UICollectionViewFlowLayout();
        let homePageCollectionView = HomePageCollectionView(frame: .zero, collectionViewLayout: flowLayout);
        return homePageCollectionView;
    }()
    
    var timer = Timer();
    
    //MARK: Location Variable set
    var locManager: CLLocationManager!;
    var placeMark: CLPlacemark!;
    

    private let cellReusueIdentifier = "restCell";
    private let cellReusueIdentifier2 = "noCell";
//
//    //DATA Elements
    var restaurants: [Restaurant]?
    var advertisedRestaurants: [Restaurant]?//for the auto moving scrollView
    var searchedRestaurants = [Restaurant]();
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.automaticallyAdjustsScrollViewInsets = false;
        addObservers();
        setupSearchBar();
        setupHomePageCollectionView();
//        loadingView.showLoadingPage();
        setupSearchTable();
        setupDarkView();
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self);
    }
    
    private func loadImage(urlString: String)-> UIImage{
        let url = URL(string: urlString);
        let data = try? Data(contentsOf: url!);
        let image = UIImage(data: data!);
        return image!;
    }
    
    fileprivate func addObservers(){
        let name = Notification.Name(rawValue: errorCloseNotification);
        NotificationCenter.default.addObserver(self, selector: #selector(self.dismissDarkView), name: name, object: nil);
        
        let searchBarFirstResponderName = Notification.Name(rawValue: searchBarFirstResponder);
        NotificationCenter.default.addObserver(self, selector: #selector(self.showSearchTable), name: searchBarFirstResponderName, object: nil);
        
        let searchBarResignFirstResponderName = Notification.Name(rawValue: searchBarResignResponder);
        NotificationCenter.default.addObserver(self, selector: #selector(self.hideSearchTable), name: searchBarResignFirstResponderName, object: nil);
        
        let selectedSearchRestaurantName = Notification.Name(rawValue: searchTableSelected);
        NotificationCenter.default.addObserver(self, selector: #selector(self.selectedSearchRestaurant(_:)), name: selectedSearchRestaurantName, object: nil);
    }
    
    fileprivate func setupDarkView(){
        self.view.addSubview(darkView);
        darkView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        darkView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        darkView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true;
        darkView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true;
    }
    
    fileprivate func setupSearchBar(){
        self.view.addSubview(searchBarView);
        searchBarView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        searchBarView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        searchBarView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true;
        searchBarView.heightAnchor.constraint(equalToConstant: 45).isActive = true;
    }
    
    fileprivate func setupHomePageCollectionView(){
        self.view.addSubview(homePageCollectionView);
        homePageCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        homePageCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true;
        homePageCollectionView.topAnchor.constraint(equalTo: self.searchBarView.bottomAnchor).isActive = true;
        homePageCollectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true;
        
        homePageCollectionView.restaurants = self.restaurants;
        homePageCollectionView.homePageCollectionViewDelegate = self;
    }
    
    fileprivate func setupSearchTable(){
        self.view.addSubview(searchTable);
        searchTable.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        searchTable.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        searchTable.topAnchor.constraint(equalTo: self.searchBarView.bottomAnchor).isActive = true;
        searchTable.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true;
        
        searchTable.alpha = 0;
    }
    
    fileprivate func showConnectionError(){
        loadingView.showDarkView();
        
        if let window = UIApplication.shared.keyWindow{
            window.addSubview(self.errorAlertController.view);
            self.errorAlertController.view.frame = window.frame;
            self.errorAlertController.view.center.y = window.center.y+500;
            UIView.animate(withDuration: 0.3) {
                self.errorAlertController.view.center = window.center;
            }
        }
    }
}

extension HomePage{
    func didSelectItem(restaurant: Restaurant, restaurantID: String) {
        loadMenu(selectedRestaurant: restaurant, restaurantID: restaurantID);
    }
    
    @objc func dismissDarkView(){
        UIView.animate(withDuration: 0.3) {
            self.loadingView.dismissDarkView()
            self.errorAlertController.view.removeFromSuperview();
        }
    }
    
    @objc func showDarkView(){
        UIView.animate(withDuration: 0.3) {
            self.darkView.alpha = 0.5;
        }
    }
    
    @objc func showSearchTable(){
        UIView.animate(withDuration: 0.3) {
            self.searchTable.alpha = 1;
        }
    }
    
    @objc func hideSearchTable(){
        self.dismissDarkView();
        UIView.animate(withDuration: 0.3) {
            self.searchTable.alpha = 0;
        }
    }
    
    @objc func selectedSearchRestaurant(_ notification: NSNotification){
        if let info = notification.userInfo{
            if let selectedRestaurant = info["selectedRestaurant"] as? Restaurant{
                hideSearchTable();
                loadMenu(selectedRestaurant: selectedRestaurant, restaurantID: selectedRestaurant.restaurantID!);
            }
        }
        
        
    }
}

extension HomePage{
    func loadMenu(selectedRestaurant: Restaurant, restaurantID: String){
        
        loadingView.showLoadingPage();
        
        let url = URL(string: "https://onDeliveryinc.com/LoadMenu.php");
        var request: URLRequest = URLRequest(url: url!);
        let postBody = "RestID=\(restaurantID)"
        request.httpMethod = "POST";
        request.httpBody = postBody.data(using: String.Encoding.utf8);
        let task = URLSession.shared.dataTask(with: request) { (urlData, response, errorOrNil) in
            
            //test for error
            
            if errorOrNil != nil{
                DispatchQueue.main.async {
                    self.showConnectionError();
                }
            }
            
            if let data = urlData{
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! NSDictionary;
                    
                    let menuID = json["menuID"] as! NSArray;
                    let section = json["sections"] as! NSArray;
                    let foodNames = json["foodNames"] as! NSArray;
                    let foodSection = json["foodSection"] as! NSArray;
                    let foodPrices = json["foodPrice"] as! NSArray;
                    let foodIDs = json["foodID"] as! NSArray;
                    let sectNames = json["sectionNames"] as! NSArray;
                    let sectSection = json["sectionSection"] as! NSArray; //section section is the actual section that the section is: EX: section name: Chinese Food, Section section =  1;
                    let foodPicURLs = json["pics"] as! NSArray;
                    let hotFoods = json["hotFood"] as! NSArray;
                    let descript = json["description"] as! NSArray;
                    let options = json["options"] as! NSArray;
                    
                    let sectionAsInt = Int(section[0] as! String);
                    
                    let newMenu = Menu();
                    newMenu.menuID = menuID[0] as? String;
                    newMenu.numberOfSections = sectionAsInt!;
                    
                    var count = 0;
                    while(count < sectNames.count){
                        let sectionItem = SectionItem();
                        let sectionNumberString = sectSection[count] as? String;
                        let sectionNumberInt = Int(sectionNumberString!);
                        sectionItem.sectionNumber = sectionNumberInt;
                        sectionItem.sectionTitle = sectNames[count] as? String;
                        newMenu.sectionItems.append(sectionItem);
                        count+=1;
                    }
                    
                    
                    count = 0;
                    while(count < foodNames.count){
                        let newMenuDataItem = MenuDataItem();
                        newMenuDataItem.foodName = foodNames[count] as? String;
                        newMenuDataItem.foodID = foodIDs[count] as? String;
                        
                        let foodSectionString = foodSection[count] as? String;
                        let foodSectionInt = Int(foodSectionString!);
                        newMenuDataItem.foodSection = foodSectionInt;
                        
                        let foodPriceString = foodPrices[count] as! String;
                        let foodPriceDouble = Double(foodPriceString);
                        newMenuDataItem.foodPrice = foodPriceDouble;
                        
                        newMenuDataItem.foodPicURL = foodPicURLs[count] as? String;
                        
                        let foodImage = self.loadImage(urlString: newMenuDataItem.foodPicURL!);
                        newMenuDataItem.foodImage = foodImage;
                        
                        newMenuDataItem.foodIsHot = hotFoods[count] as? String;
                        newMenuDataItem.foodDescription = descript[count] as? String;
                        
                        let options = options[count] as? String;
                        newMenuDataItem.options = options;
                        
                        newMenu.menu.append(newMenuDataItem);
                        count+=1;
                    }
                    
                    DispatchQueue.main.async {
                        self.loadingView.dismissLoadingPage();
                        let menu = MenuPage();
                        menu.hidesBottomBarWhenPushed = true;
                        
                        menu.menu = newMenu;
                        menu.selectedRestaurant = selectedRestaurant;
                        self.navigationController?.pushViewController(menu, animated: true);
                    }
                }catch{
                    print("Error parsing json");
                    DispatchQueue.main.async {
                        self.loadingView.dismissLoadingPage();
                        self.showConnectionError();
                    }
                }
            }
            
        }
        task.resume();
    }//end of function
}














