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

class HomePage: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate, UITextFieldDelegate, UIGestureRecognizerDelegate, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    lazy var selectedDarkView: UIView = {
        let selectedDarkView = UIView();
        
        selectedDarkView.translatesAutoresizingMaskIntoConstraints = false;
        selectedDarkView.backgroundColor = UIColor.black;
        selectedDarkView.alpha = 0;
        return selectedDarkView;
    }()
    
    lazy var spinner: SpinningView = {
        let spinner = SpinningView();
        spinner.translatesAutoresizingMaskIntoConstraints = false;
        spinner.circleLayer.strokeColor = UIColor.white.cgColor;
        return spinner;
    }()
    
    lazy var message: UILabel = {
        let message = UILabel();
        message.translatesAutoresizingMaskIntoConstraints = false;
        message.text = "Loading...";
        message.font = UIFont(name: "Montserrat-Regular", size: 14);
        message.textAlignment = .center;
        message.textColor = UIColor.white;
        return message;
    }()
    
    //MARK: Variables
    private var darkView: UIView = {
        let darkView = UIView();
        darkView.translatesAutoresizingMaskIntoConstraints = false;
        darkView.backgroundColor = UIColor.black;
        darkView.alpha = 0.0;
        return darkView;
    }()
    fileprivate var scrollView: UIScrollView!;//scrollview for the top of the screen
    fileprivate var restList: UICollectionView!;
    var scrollViewView: UIView!;
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
    fileprivate var pageControl: UIPageControl!;
    
    //MARK: Location Variable set
    var locManager: CLLocationManager!;
    var placeMark: CLPlacemark!;
    
    private let identifier = "two";
    private let cellReusueIdentifier = "restCell";
    private let cellReusueIdentifier2 = "noCell";
    private var scrollViewWidth: CGFloat!;
    private var scrollViewHeight: CGFloat!;
    
    private var timer: Timer!;
    private var scrollViewPageNum = 0;
    
    //MARK: Views
    var scrollViewAdvertised: MainPageAdvertismentView!;
    var view2: MainPageAdvertismentView!;
    var view3: MainPageAdvertismentView!;
    var view4: MainPageAdvertismentView!;
    var view5: MainPageAdvertismentView!;
    
    var image:UIImage!;
//
//    //DATA Elements
    var restaurants: [Restaurant]?
    var advertisedRestaurants: [Restaurant]?//for the auto moving scrollView
    var searchedRestaurants = [Restaurant]();
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.automaticallyAdjustsScrollViewInsets = false;

        self.setUpScrollView();
        self.continueSetup();
    }
    
    private func loadImage(urlString: String)-> UIImage{
//        print("urlString:\(urlString)");
        let url = URL(string: urlString);
//        print(url);
        let data = try? Data(contentsOf: url!);
        let image = UIImage(data: data!);
        return image!;
    }
    
    private func continueSetup(){
        let flowLayout = UICollectionViewFlowLayout();
        flowLayout.itemSize = CGSize(width: self.view.frame.width, height: 105);
        flowLayout.scrollDirection = .vertical;
        restList = UICollectionView(frame: .zero, collectionViewLayout: flowLayout);
        restList.delegate = self;
        restList.dataSource = self;
        restList.backgroundColor = UIColor.white;
        restList.translatesAutoresizingMaskIntoConstraints = false;
        restList.register(MainPageListCell.self, forCellWithReuseIdentifier: cellReusueIdentifier);
        restList.register(NoRestaurantsCell.self, forCellWithReuseIdentifier: cellReusueIdentifier2);
        self.view.addSubview(restList);
        restList.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        restList.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true;
        restList.topAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true;
        restList.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true;
        
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.nextPic), userInfo: nil, repeats: true);
        
        //pageControl
        pageControl = UIPageControl();
        pageControl.translatesAutoresizingMaskIntoConstraints = false;
        pageControl.numberOfPages = self.advertisedRestaurants!.count;
        pageControl.currentPage = 0;
        self.view.addSubview(pageControl);
        //need x,y,width,height
        pageControl.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true;
        pageControl.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true;
        pageControl.widthAnchor.constraint(equalToConstant: 50).isActive = true;
        pageControl.heightAnchor.constraint(equalToConstant: 20).isActive = true;
        
        //MARK: DarkView
//        let frameDarkView = self.view.frame;
        self.view.addSubview(darkView);
        darkView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        darkView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        darkView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true;
        darkView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true;
        
        self.view.addSubview(searchBar);
        //need x,y,width,and height
        searchBar.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 5).isActive = true;
        searchBar.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10).isActive = true;
        searchBar.widthAnchor.constraint(equalToConstant: self.view.frame.size.width*(3/4)).isActive = true;
        searchBar.heightAnchor.constraint(equalToConstant: 30).isActive = true;
        searchBar.addTarget(self, action:#selector(self.changedText), for: .editingChanged);
        searchBar.delegate = self;
        
        searchResults = UITableView();
        searchResults.translatesAutoresizingMaskIntoConstraints = false;
        searchResults.delegate = self;
        searchResults.dataSource = self;
        searchResults.register(SearchResultRow.self, forCellReuseIdentifier: identifier);
        searchResults.backgroundColor = UIColor.veryLightGray;
        self.view.addSubview(searchResults);
        searchResults.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        searchResults.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        searchResults.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor, constant: 10).isActive = true;
        searchResults.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true;
        searchResults.isHidden = true;
        
        self.view.addSubview(cancelButton);
        cancelButton.leftAnchor.constraint(equalTo: self.searchBar.rightAnchor, constant: 10).isActive = true;
        cancelButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10).isActive = true;
        cancelButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true;
        cancelButton.heightAnchor.constraint(equalToConstant: 30).isActive = true;
        
        self.view.addSubview(searchButton);
        searchButton.leftAnchor.constraint(equalTo: searchBar.rightAnchor, constant: 10).isActive = true;
        searchButton.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor).isActive = true;
        searchButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true;
        searchButton.heightAnchor.constraint(equalToConstant: 30).isActive = true;
        
        setupLoadingViews();
        
        //MARK: Targets
        cancelButton.addTarget(self, action: #selector(self.cancel), for: .touchUpInside);
    }
    
    fileprivate func setupLoadingViews(){
        self.view.addSubview(selectedDarkView);
        selectedDarkView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        selectedDarkView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        selectedDarkView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true;
        selectedDarkView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true;
        
        selectedDarkView.addSubview(spinner);
        spinner.centerXAnchor.constraint(equalTo: selectedDarkView.centerXAnchor).isActive = true;
        spinner.centerYAnchor.constraint(equalTo: selectedDarkView.centerYAnchor).isActive = true;
        spinner.widthAnchor.constraint(equalToConstant: 50).isActive = true;
        spinner.heightAnchor.constraint(equalToConstant: 50).isActive = true;
        
        selectedDarkView.addSubview(message);
        message.centerXAnchor.constraint(equalTo: selectedDarkView.centerXAnchor).isActive = true;
        message.bottomAnchor.constraint(equalTo: spinner.topAnchor, constant: -10).isActive = true;
        message.widthAnchor.constraint(equalToConstant: 150).isActive = true;
        message.heightAnchor.constraint(equalToConstant: 25).isActive = true;
    }
    
    //MARK: changeText
    @objc private func changedText(){
        //fire timer for 0.3 seconds
        timer.invalidate();
        timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.changedTextSend), userInfo: nil, repeats: false);
//        changedTextSend();
    }
    
    @objc private func changedTextSend(){
        //send the character to the server
//        print("sent");
        self.searchedRestaurants.removeAll();
        if(searchBar.text!.count > 0){
            let searchText = self.searchBar.text!
            let conn = Conn();
            let postBody = "Search=\(searchText)&Latitude=\(userLatitude!)&Longitude=\(userLongtiude!)";
            conn.connect(fileName: "SearchRestaurant.php", postString: postBody, completion: { (re) in
                if(re != "none"){
                    do{
                        let json = try JSONSerialization.jsonObject(with: urlData!, options: .allowFragments) as! NSDictionary;
                        let restaurantNames = json["restNames"] as! NSArray;
                        let restaurantIDs = json["restIDs"] as! NSArray;
                        let restaurantAddresses = json["restAddress"] as! NSArray;
                        let restaurantDistances = json["distance"] as! NSArray;
                        let restaurantTelephones = json["telephone"] as! NSArray;
                        let restaurantOpenHours = json["open"] as! NSArray;
                        let restaurantCloseHours = json["close"] as! NSArray;
                        
                        var count = 0;
                        while(count < restaurantNames.count){
                            let newRestaurant = Restaurant();
                            newRestaurant.restaurantTitle = restaurantNames[count] as? String;
                            newRestaurant.restaurantID = restaurantIDs[count] as? String;
                            newRestaurant.restaurantAddress = restaurantAddresses[count] as? String;
                            
                            newRestaurant.restaurantDistance = restaurantDistances[count] as? Double;
                            
                            newRestaurant.restaurantTelephone = restaurantTelephones[count] as? String;
                            newRestaurant.restaurantOpenHour = restaurantOpenHours[count] as? String;
                            newRestaurant.restaurantCloseHour = restaurantCloseHours[count] as? String;
                            
                            self.searchedRestaurants.append(newRestaurant);
                            
                            count+=1;
                        }
                        
                        DispatchQueue.main.async {
//                            print(self.searchResultsNames.count);
                            self.searchResults.reloadData();
                        }
                    }catch{
                        print("error");
                    }
                }
                
            })
            
        }else{
            self.searchResults.reloadData();
        }
    }
    
    //MARK: SetU Functions
    func setUpScrollView(){
        
        let multiplyNumber = CGFloat((self.advertisedRestaurants?.count)!);
        
        let frameScrollView = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height/3);
        self.scrollView = UIScrollView(frame: frameScrollView);
        
        self.scrollViewWidth = scrollView.frame.width;
        self.scrollViewHeight = scrollView.frame.height;
        
        self.scrollView.delegate = self;
        self.scrollView.contentSize = CGSize(width: scrollViewWidth*multiplyNumber, height: scrollViewHeight);
        self.scrollView.isPagingEnabled = true;
        self.scrollView.alwaysBounceVertical = false;
        self.scrollView.alwaysBounceHorizontal = false;
        self.scrollView.showsVerticalScrollIndicator = false;
        self.scrollView.showsHorizontalScrollIndicator = false;
        self.scrollView.bounces = false;
        self.scrollView.isScrollEnabled = true;
        self.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0);
        
        //set up frames based on the scrollViewSize
        var count = 0;
        print(advertisedRestaurants?.count);
        while(count < advertisedRestaurants!.count){
            let restaurant = advertisedRestaurants![count];
            let frame = CGRect(x: 0+(scrollViewWidth*CGFloat(count)), y: 0, width: scrollViewWidth, height: scrollViewHeight);
            let scrollViewView = MainPageAdvertismentView(frame: frame);
            scrollView.addSubview(scrollViewView);
            
            scrollViewView.imageView.image = restaurant.restaurantAdvertisedFoodImage!;
            
            count+=1;
        }
        
        self.view.addSubview(self.scrollView);
        let gesture = UITapGestureRecognizer();
        gesture.delegate = self;
        gesture.addTarget(self, action: #selector(self.tappedScrollView));
        scrollView.addGestureRecognizer(gesture);
    }
    
    @objc func tappedScrollView(){
        //link picture with top 5 restaurants in the area
        if(scrollViewPageNum < self.advertisedRestaurants!.count){
            //index is page -1;
            let index = scrollViewPageNum;
            loadMenu(index: index,advertised: true);
        }else{
            print("tapped");
        }
    }
    
    //MARK: Swap Pics
    @objc private func nextPic(){
        scrollViewPageNum+=1;
        if(scrollViewPageNum < advertisedRestaurants!.count){
            if(scrollViewPageNum == 0){
                let offset = CGPoint(x: 0, y: 0);
                self.scrollView.setContentOffset(offset, animated: true);
            }else if(scrollViewPageNum == 1){
                let offset = CGPoint(x: self.scrollViewWidth, y: 0);
                self.scrollView.setContentOffset(offset, animated: true);
            }else if(scrollViewPageNum == 2){
                let offset = CGPoint(x: self.scrollViewWidth*2, y: 0);
                self.scrollView.setContentOffset(offset, animated: true);
            }else if(scrollViewPageNum == 3){
                let offset = CGPoint(x: self.scrollViewWidth*3, y: 0);
                self.scrollView.setContentOffset(offset, animated: true);
            }else if(scrollViewPageNum == 4){
                let offset = CGPoint(x: self.scrollViewWidth*4, y: 0);
                self.scrollView.setContentOffset(offset, animated: true);
            }
        }else{
            let offset = CGPoint(x: 0, y: 0);
            self.scrollView.setContentOffset(offset, animated: true);
            scrollViewPageNum = 0;
            
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        timer.invalidate();
        let pageOffset = scrollView.contentOffset.x/scrollView.frame.size.width;
        let roundedNumber = round(pageOffset);
        pageControl.currentPage = Int(roundedNumber);
        scrollViewPageNum = Int(roundedNumber);
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.nextPic), userInfo: nil, repeats: true);
    }
    
    //MARK: Cancel button
    @objc func cancel(){
        UIView.animate(withDuration: 0.3) {
            self.darkView.alpha = 0;
            self.searchBar.alpha = 0.7;
            self.cancelButton.isHidden = true;
            self.searchResults.isHidden = true;
            self.searchButton.isHidden = false;
        }
        self.searchBar.text = "";
        self.searchBar.resignFirstResponder();
        //removing all the search results
        self.searchedRestaurants.removeAll();
    }
    
    //MARK: TextField
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.3) {
            self.darkView.alpha = 0;
            self.searchBar.alpha = 0.7;
            self.cancelButton.isHidden = true;
            self.searchButton.isHidden = false;
            self.searchResults.isHidden = true;
        }
        self.searchBar.text = "";
        self.searchBar.resignFirstResponder();
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField == self.searchBar){
            //go
        }
        return true;
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.cancelButton.isHidden = false;
        self.searchButton.isHidden = true;
        UIView.animate(withDuration: 0.3, animations: {
            self.darkView.alpha = 0.7;
            self.searchBar.alpha = 1;
            self.searchResults.isHidden = false;
            })
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if(self.restaurants!.count > 0){
            
            let cell = self.restList.dequeueReusableCell(withReuseIdentifier: self.cellReusueIdentifier, for: indexPath) as! MainPageListCell;
            let restaurant = self.restaurants![indexPath.item];
            cell.setNameAndAddress(name: restaurant.restaurantTitle!, address: restaurant.restaurantAddress!);
            cell.setPrice(price: 3.99);
            cell.cellImage.image = restaurant.restaurantBuildingImage;
            cell.setDistance(dist: restaurant.restaurantDistance!);
            cell.btnTapAction = {
                self.loadMenu(index: indexPath.item, advertised: false);
            }
            return cell;
        }else{
            let cell = self.restList.dequeueReusableCell(withReuseIdentifier: self.cellReusueIdentifier2, for: indexPath) as! NoRestaurantsCell;
            return cell;
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(self.restaurants!.count > 0){
            return self.restaurants!.count;
        }else{
            return 1;
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;//only one section, resturaunts
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(self.restaurants!.count > 0){
            return CGSize(width: self.view.frame.width, height: 105);
        }else{
            return CGSize(width: self.view.frame.width, height: 130);
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        loadMenu(index: indexPath.item, advertised: false);
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchedRestaurants.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        print(indexPath);
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! SearchResultRow
        let restaurant = self.searchedRestaurants[indexPath.item];
        cell.setDistance(distance: restaurant.restaurantDistance!);
        cell.setName(name: restaurant.restaurantTitle!);
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //go to menu, and load
        loadMenu(index: indexPath.item, advertised: false);
        tableView.deselectRow(at: indexPath, animated: true);
        self.cancel();
    }
    
    private func loadMenu(index: Int!,advertised: Bool){
        self.searchBar.resignFirstResponder();
        self.spinner.animating = true;
        self.spinner.updateAnimation();
        
        UIView.animate(withDuration: 0.3) {
            self.selectedDarkView.alpha = 0.7;
        }
        
        //index to search restaurants
        var selectedRestaurant:Restaurant
        if(advertised){
            selectedRestaurant = self.advertisedRestaurants![index];
        }else{
            selectedRestaurant = self.restaurants![index];
        }
        let restaurantID = selectedRestaurant.restaurantID!;
        
        //load menu data
        let conn = Conn();
        let postBody = "RestID=\(restaurantID)";
        
        conn.connect(fileName: "LoadMenu.php", postString: postBody) { (re) in
            if(urlData != nil){
                do{
                    let json = try JSONSerialization.jsonObject(with: urlData!, options: .allowFragments) as! NSDictionary;
                    
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
                        let menu = MenuPage();
                        menu.hidesBottomBarWhenPushed = true;
                        
                        menu.menu = newMenu;
                        
                        menu.selectedRestaurant = selectedRestaurant;
                        
                        
                        self.navigationController?.pushViewController(menu, animated: true);
                        
                        self.selectedDarkView.alpha = 0.0;
                        self.spinner.animating = false;
                        self.spinner.updateAnimation();
                    }
                }catch{
                    print("Error parsing json");
                }
            }
        }
    }
}














