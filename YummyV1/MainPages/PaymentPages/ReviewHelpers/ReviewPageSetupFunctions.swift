//
//  ReviewPageSetupFunctions.swift
//  YummyV1
//
//  Created by Brandon In on 3/14/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import Foundation
import UIKit

//MARK: TableView
extension ReviewPage{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuse2) as! OptionsCell
        cell.setTitle(name: tableTitles[indexPath.item]);
        cell.setImage(url: tableImages[indexPath.item]);
        if(indexPath.row == 0 && addressUserText != nil){
            cell.setUserText(text: addressUserText!);
        }else if(indexPath.row == 1 && deliveryTimeUserText != nil){
            cell.setUserText(text: deliveryTimeUserText!);
        }else if(indexPath.row == 2 && paymentUserText != nil){
            cell.setUserText(text: "...\(paymentUserText!)");
        }else if(indexPath.row == 3){
            cell.setUserText(text:  "\(customerName!)");
        }else if(indexPath.row == 4){
            cell.setUserText(text: "\(customerPhone!)");
        }else if(indexPath.row == 5){
            cell.setUserText(text: "\(customerEmail!)")
        }
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch(indexPath.item){
        case 0: toSelectAddress();break;
        case 1: toDeliveryTime();break;
        case 2: toSelectPayments();break;
        case 3: toEnterName(index: indexPath);break;
        case 4: toEnterTelephone(index: indexPath);break;
        case 5: toEnterEmail(index: indexPath);break;
        default: break;
        }
        tableView.deselectRow(at: indexPath, animated: true);
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(userID != nil){
            return 3;
        }else{
            return 6;
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50;
    }
}

//MARK: CollectionView
extension ReviewPage{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuse, for: indexPath) as! ReviewCell;
        cell.setName(name: names[indexPath.item]);
        cell.setQuantity(quant: quantity[indexPath.item]);
        cell.setPrice(price: prices[indexPath.item]);
        return cell;
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuItemArray.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width, height: 50);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
}

