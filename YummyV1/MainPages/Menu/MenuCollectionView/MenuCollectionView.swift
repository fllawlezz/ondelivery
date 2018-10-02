//
//  MenuCollectionView.swift
//  YummyV1
//
//  Created by Brandon In on 9/7/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

protocol MenuCollectionViewDelegate{
    func makeCall();
}

class MenuCollectionView: UICollectionView,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, InfoCellDelegate, MenuNavBarDelegate{
    
    var menuCollectionViewDelegate: MenuCollectionViewDelegate?
    
    var pageNum = 0;
    
    let reuseIdentifier = "one";
    let reuseIdentifier2 = "two";
    let reuseIdentifier3 = "third";
    
    var foods:[[Food]]?
    var selectedRestaurant:Restaurant?
    var sectionItems:[SectionItem]?
    var menuItemArray: [MainItem]?
    var currentSection = 0;
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout);
        self.showsVerticalScrollIndicator = false;
        self.backgroundColor = UIColor.veryLightGray;
        
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.backgroundColor = UIColor.white;
        self.delegate = self;
        self.dataSource = self;
        self.register(MenuCell.self, forCellWithReuseIdentifier: self.reuseIdentifier);
        self.register(InfoCell.self, forCellWithReuseIdentifier: reuseIdentifier2);
        self.register(CollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: reuseIdentifier3);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if(pageNum == 2){
            return CGSize(width: self.frame.width, height: 30);
        }else{
            return CGSize(width: self.frame.width, height: 30);
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //Page Num is not 3
        if foods != nil{
            if(self.pageNum != 2){
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MenuCell;
                cell.hideButton();//hide the minus and the label
                cell.setQuantity(quantity: 0);//reset the quantity to zero
                
                if(pageNum == 0){
                    //if hotFoods
                    let foodArray = foods![currentSection];
                    let food = foodArray[indexPath.item];
                    cell.setName(name: food.name!);
                    cell.setPrice(charge: food.price!);
                    cell.setFoodID(id: food.id!);
                    cell.foodImage.image = food.image!;
                    cell.setDescription(description: food.descript!);
                    if(food.options == "Y"){
                        cell.options = true;
                    }else{
                        cell.options = false;
                    }
                    //if food is selected then set orders and
                    
                }else if(pageNum == 1){
                    print(pageNum);
                    //do that
                    var count = 0;//count to run through array
                    while(count<foods!.count){
                        if(indexPath.section == count){
                            let sectionArray = foods![count];
                            let food = sectionArray[indexPath.item];
                            
                            cell.setName(name: food.name!);
                            cell.setPrice(charge: food.price!);
                            cell.setFoodID(id: food.id!);
                            cell.foodImage.image = food.image!;
                            cell.setDescription(description: food.descript!);
                            
                            if(food.options == "Y"){
                                cell.options = true;
                            }else{
                                cell.options = false;
                            }
                        }
                        count+=1;
                    }
                }
                
                if let menuItemArray = self.menuItemArray{
//                    print("updating collectionView=\(menuItemArray.count)");
                //MARK: Hide/unhide minus button and update quantity
                    for item in menuItemArray{//for every item in the menuItemArray
//                        print(item.name);
                        if(item.id == cell.foodID){//if the names are the same
                            if(item.quantity != 0){
                                cell.buttonShown = true;//shown = true to notify that the cell minus and plus are unhidden
                                cell.unhideAddButton();//make sure to unhide the minus and the quantity indicator
                                cell.setQuantity(quantity: item.quantity);//set the quantity to the actual menu Item quantity
                            }
                        }
                    }
                }
                
                return cell;
            }else{
//                print(pageNum);
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier2, for: indexPath) as! InfoCell;
                cell.delegate = self;
                if(indexPath.item == 0){
                    cell.setTitle(text: self.selectedRestaurant!.restaurantTelephone!);
                    cell.phoneImage.isHidden = false;
                }else if(indexPath.item == 1){
                    cell.setTitle(text: self.selectedRestaurant!.restaurantAddress!);
                    cell.phoneImage.isHidden = true;
                }else{
                    cell.setTitle(text: "\(self.selectedRestaurant!.restaurantOpenHour!)-\(self.selectedRestaurant!.restaurantCloseHour!)");
                    cell.phoneImage.isHidden = true;
                }
                
                return cell;
            }
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath);
            return cell;
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if(pageNum == 0){
            return 1;
        }else if(pageNum == 1){
            return foods!.count;
        }else if(pageNum == 2){
            return 1
        }else{
            return 1;
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(pageNum == 0){
            let array = foods![currentSection];
            return array.count;
        }else if(pageNum == 1){
            let array = foods![section];
            return array.count;
        }else if(pageNum == 2){
            return 3;
        }
        return 1;
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(pageNum != 2){
            return CGSize(width: self.frame.width, height: 110);
        }else{
            return CGSize(width: self .frame.width, height: 40);
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reuseIdentifier3, for: indexPath) as! CollectionViewHeader;
        headerView.frame.size.height = 30;
        headerView.backgroundColor = UIColor.veryLightGray;
        if(pageNum == 0){
            let sectionItem = self.sectionItems![self.currentSection];
            let sectionName = sectionItem.sectionTitle!;
            headerView.setTitle(string: sectionName);
        }else if(pageNum == 1){
            let index = indexPath.section;
            let sectionItem = self.sectionItems![index];
            let sectionName = sectionItem.sectionTitle!;
            headerView.setTitle(string: sectionName);
        }else{
            headerView.setTitle(string: "Restaurant Info");
        }
        return headerView;
    }
    
}

extension MenuCollectionView{
    func makeCall() {
        if let delegate = self.menuCollectionViewDelegate{
            delegate.makeCall();
        }
    }
    
    func handleChangedNavigationSection(section: Int) {
        switch(section){
        case 0:
            if(pageNum != 0){
                pageNum = 0;
                self.reloadData();
            }
            break;//reload table;
        case 1:
            if(pageNum != 1){
                pageNum = 1;
                self.reloadData();
            }
            break;
        case 2:
            if(pageNum != 2){
                pageNum = 2;
                self.reloadData();
            }
            break;
        default: break;
        }
    }
    
}
