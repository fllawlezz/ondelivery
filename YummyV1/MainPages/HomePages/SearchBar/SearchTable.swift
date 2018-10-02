//
//  SearchTableView.swift
//  YummyV1
//
//  Created by Brandon In on 9/4/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

let searchTableReloadNotification = "searchTableReload";
let searchTableReset = "SearchTableReset";
let searchTableSelected = "SelectedSearchRestaurant";

class SearchTable: UITableView, UITableViewDelegate, UITableViewDataSource{
    
    private let identifier = "two";
    var searchedRestaurants:[Restaurant]?;
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style);
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.backgroundColor = UIColor.white;
        self.delegate = self;
        self.dataSource = self;
        self.register(SearchResultRow.self, forCellReuseIdentifier: identifier);
        addObservers();
        
        self.separatorStyle = .none;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchedRestaurants != nil {
            return self.searchedRestaurants!.count;
        }else{
            return 0;
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        print(indexPath);
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! SearchResultRow
        let restaurant = self.searchedRestaurants![indexPath.item];
        cell.setDistance(distance: restaurant.restaurantDistance!);
        cell.setName(name: restaurant.restaurantTitle!);
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //go to menu, and load
        let selectedRestaurant = self.searchedRestaurants![indexPath.item];
        let info = ["selectedRestaurant":selectedRestaurant];
        let name = Notification.Name(rawValue: searchTableSelected);
        NotificationCenter.default.post(name: name, object: nil, userInfo: info);
        
        let searchBarResignName = Notification.Name(rawValue: searchBarResignResponder);
        NotificationCenter.default.post(name: searchBarResignName, object: nil);
        
        tableView.deselectRow(at: indexPath, animated: true);
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self);
    }
    
    fileprivate func addObservers(){
        let name = Notification.Name(rawValue: searchTableReloadNotification);
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadTable(_:)), name: name, object: nil);
        
        let resetName = Notification.Name(rawValue: searchTableReset);
        NotificationCenter.default.addObserver(self, selector: #selector(self.resetTable), name: resetName, object: nil);
    }
    
}

extension SearchTable{
    @objc func reloadTable(_ notification: NSNotification){
        if let info = notification.userInfo{
            let searchResultsObject = info["searchResults"];//array of restaurants
            if let searchResults = searchResultsObject as? [Restaurant]{
                print("passed");
                self.searchedRestaurants = searchResults;
                self.reloadData();
                return;
            }
        }
        
        resetTable();
        
    }
    
    @objc func resetTable(){
        self.searchedRestaurants = nil;
        self.reloadData();
    }
}
