//
//  SearchBarView.swift
//  YummyV1
//
//  Created by Brandon In on 9/3/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

let searchBarFirstResponder = "SearchBarStartFirstResponder";
let searchBarResignResponder = "SearchBarResignFirstResponder";

class SearchBarView: UIView, UITextFieldDelegate{
    
    var searchedRestaurants = [Restaurant]();
    
    var timer = Timer();
    
    fileprivate var searchBar: TextFieldPadded = {
        let searchBar = TextFieldPadded()
        searchBar.translatesAutoresizingMaskIntoConstraints = false;
        searchBar.layer.cornerRadius = 5;
        searchBar.backgroundColor = UIColor.veryLightGray;
        searchBar.font = UIFont(name: "Montserrat-Regular", size: 12);
        searchBar.alpha = 0.7;
        searchBar.placeholder = "Restaurants Near Me";
        return searchBar;
    }()
    
    fileprivate var cancelButton: UIButton = {
        let cancelButton = UIButton();
        cancelButton.translatesAutoresizingMaskIntoConstraints = false;
        cancelButton.setTitle("cancel", for: .normal);
        cancelButton.setTitleColor(UIColor.black, for: .normal);
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
    
    fileprivate var bottomBorder: UIView = {
        let border = UIView();
        border.translatesAutoresizingMaskIntoConstraints = false;
        border.backgroundColor = UIColor.lightGray;
        return border;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.backgroundColor = UIColor.white;
        setupSearchBar();
        setupSearchButton();
        setupCancelButton();
        setupBorder();
        addObserver();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self);
    }
    
    fileprivate func addObserver(){
        let name = Notification.Name(rawValue: searchTableSelected);
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleCancel), name: name, object: nil);
    }
    
    fileprivate func setupSearchBar(){
        let frameSize = UIApplication.shared.keyWindow?.frame.width;
        self.addSubview(searchBar);
        searchBar.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true;
        searchBar.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        searchBar.widthAnchor.constraint(equalToConstant: frameSize!*(3/4)).isActive = true;
        searchBar.heightAnchor.constraint(equalToConstant: 30).isActive = true;
        
        searchBar.delegate = self;
        searchBar.addTarget(self, action: #selector(self.changedText), for: .editingChanged);
    }
    
    fileprivate func setupSearchButton(){
        self.addSubview(searchButton);
        searchButton.leftAnchor.constraint(equalTo: searchBar.rightAnchor, constant: 10).isActive = true;
        searchButton.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor).isActive = true;
        searchButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true;
        searchButton.heightAnchor.constraint(equalToConstant: 30).isActive = true;
        
    }
    
    fileprivate func setupCancelButton(){
        self.addSubview(cancelButton);
        cancelButton.leftAnchor.constraint(equalTo: searchBar.rightAnchor, constant: 10).isActive = true;
        cancelButton.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor).isActive = true;
        cancelButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true;
        cancelButton.heightAnchor.constraint(equalToConstant: 30).isActive = true;
        cancelButton.addTarget(self, action: #selector(self.handleCancel), for: .touchUpInside);
    }
    
    fileprivate func setupBorder(){
        self.addSubview(bottomBorder);
        bottomBorder.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        bottomBorder.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        bottomBorder.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        bottomBorder.heightAnchor.constraint(equalToConstant: 0.3).isActive = true;
    }
    
}

extension SearchBarView{
    @objc private func changedText(){
        //fire timer for 0.3 seconds
        timer.invalidate();
        timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.changedTextSend), userInfo: nil, repeats: false);
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.cancelButton.isHidden = false;
        self.searchButton.isHidden = true;
        let name = Notification.Name(rawValue: searchBarFirstResponder);
        NotificationCenter.default.post(name: name, object: nil);
    }
    
    @objc func handleCancel(){
        self.cancelButton.isHidden = true;
        self.searchButton.isHidden = false;
        
        let name = Notification.Name(rawValue: searchBarResignResponder);
        NotificationCenter.default.post(name: name, object: nil);
        
        let resetName = Notification.Name(rawValue: searchTableReset);
        NotificationCenter.default.post(name: resetName, object: nil);
        
        self.searchBar.text = "";
        self.searchBar.resignFirstResponder();
    }
    
    @objc private func changedTextSend(){
        //send the character to the server
                print("sent");
        self.searchedRestaurants.removeAll();
        if(searchBar.text!.count > 0){
            let searchText = self.searchBar.text!
            let conn = Conn();
            let postBody = "Search=\(searchText)&Latitude=\(userLatitude!)&Longitude=\(userLongtiude!)&City=\(userCurrentCity!)";
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
                            let name = Notification.Name(rawValue: searchTableReloadNotification);
                            let info = ["searchResults":self.searchedRestaurants];
                            NotificationCenter.default.post(name: name, object: nil, userInfo: info);
                        }
                    }catch{
                        print("error");
                    }
                }
                
            })
            
        }else{
            let name = Notification.Name(rawValue: searchTableReloadNotification);
            NotificationCenter.default.post(name: name, object: nil);
        }
    }
}
