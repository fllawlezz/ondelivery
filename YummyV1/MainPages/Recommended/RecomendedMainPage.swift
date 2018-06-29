//
//  RecomendedMainPage.swift
//  YummyV1
//
//  Created by Brandon In on 11/16/17.
//  Copyright © 2017 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class RecomendedMainPage: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private let cellReusueIdentifier = "restCell";
    private let indentifier = "one";
    private let identifier2 = "two";
    private let identifier3 = "three";
    
    var filtersData: FiltersDataModel?
    var restaurants:[Restaurant]?
    var advertisedRestaurants:[Restaurant]?
    
    private var dispatch = DispatchGroup();
//    private var spinner: UIActivityIndicatorView!;
    
    //MARK: Views
    var recommendedList: UICollectionView!;
    
    //MARK: Slider setup
    var json: NSDictionary!;
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad();
//         self.mainSetup();
        self.setup();
        let filtersButton = UIBarButtonItem(title: "Filters", style: .plain, target: self, action: #selector(handleFiltersShow));
        self.navigationItem.rightBarButtonItem = filtersButton;
    }
    
    @objc func handleFiltersShow(){
        let filtersPage = FiltersPage();
        filtersPage.recommendedPage = self;
        filtersPage.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(filtersPage, animated: true);
    }
    
    private func setup(){
//        getPics();//gets pics
        let flowLayout = UICollectionViewFlowLayout();
        recommendedList = UICollectionView(frame: .zero, collectionViewLayout: flowLayout);
        recommendedList.translatesAutoresizingMaskIntoConstraints = false;
        recommendedList.delegate = self;
        recommendedList.dataSource = self;
        recommendedList.backgroundColor = UIColor.white;
        recommendedList.register(RecommendedBottomView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: identifier2);
        recommendedList.register(MainPageListCell.self, forCellWithReuseIdentifier: cellReusueIdentifier);
        recommendedList.register(NoRestaurantsCell.self, forCellWithReuseIdentifier: identifier3);
        self.view.addSubview(recommendedList)
        self.recommendedList.leftAnchor.constraint(equalTo:self.view.leftAnchor).isActive = true;
        self.recommendedList.bottomAnchor.constraint(equalTo:self.view.bottomAnchor).isActive = true;
        self.recommendedList.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true;
        self.recommendedList.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        
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
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(self.restaurants!.count > 0){
            let cell = self.recommendedList.dequeueReusableCell(withReuseIdentifier: cellReusueIdentifier, for: indexPath) as! MainPageListCell
            
            let restaurant = restaurants![indexPath.item];
            
            cell.setNameAndAddress(name: restaurant.restaurantTitle!, address: restaurant.restaurantAddress!);
            cell.cellImage.image = restaurant.restaurantBuildingImage!;
            cell.setPrice(price: 3.99);
            cell.setDistance(dist: restaurant.restaurantDistance!);
            //            cell.seeMenu.addTarget(self, action: #selector(self.tappedCell), for: .touchUpInside);
            cell.btnTapAction = {
                self.tappedCell(index: indexPath);
            }
            return cell;
        }else{
            let cell = self.recommendedList.dequeueReusableCell(withReuseIdentifier: identifier3, for: indexPath) as! NoRestaurantsCell;
            return cell;
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if(self.restaurants!.count<10){
            return CGSize(width: self.view.frame.width, height: 0);
        }else{
            return CGSize(width: self.view.frame.width, height: 80);
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: identifier2, for: indexPath) as! RecommendedBottomView
        footerView.frame.size.height = 80;
        footerView.backgroundColor = UIColor.white;
        footerView.callBackBtn = {
            self.callBack();
        }
        return footerView;
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 105);
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        tappedCell(index: indexPath);
    }
    
    private func callBack(){
        //        print("footerPressed");
        //load more, or the next view
    }
    
    @objc private func tappedCell(index: IndexPath){
        self.spinner.animating = true;
        self.spinner.updateAnimation();
        
        UIView.animate(withDuration: 0.3) {
            self.selectedDarkView.alpha = 0.7;
        }
        
        //index to search restaurants
        let selectedRestaurant = self.restaurants![index.item];
        let restaurantID = selectedRestaurant.restaurantID!;
        
        //load menu data
        let conn = Conn();
        //        let postBody = "RestID=\(self.restaurantIDs[index])";
        let postBody = "RestID=\(restaurantID)";
        
        //        dispatch.enter();
        conn.connect(fileName: "LoadMenu.php", postString: postBody) { (re) in
            if(urlData != nil){
                do{
                    let json = try JSONSerialization.jsonObject(with: urlData!, options: .allowFragments) as! NSDictionary;
                    //                    print(json);
                    
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
                    
                    let sectionAsInt = Int(section[0] as! String);
                    
                    let newMenu = Menu();
                    newMenu.menuID = menuID[0] as? String;
                    newMenu.numberOfSections = sectionAsInt!;
                    //                    menu.sectionNames = sectNames;
                    var count = 0;
                    while(count < sectNames.count){
                        let sectionItem = SectionItem();
                        sectionItem.sectionNumber = sectSection[count] as? Int;
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
    
    private func loadImage(urlString: String)-> UIImage{
        let url = URL(string: urlString);
        let data = try? Data(contentsOf: url!);
        let image = UIImage(data: data!);
        return image!;
    }
}


