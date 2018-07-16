//
//  OrderPage.swift
//  YummyV1
//
//  Created by Brandon In on 11/20/17.
//  Copyright © 2017 Rendered Co.RaftPod. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class OrderPage: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    private let reuseCell = "cell";
    private let reuseCell2 = "cell2";
    
    var pastOrders: [PastOrder]?
    var timer: Timer!;
    
    override func viewDidLoad() {
        self.collectionView?.register(OrderPageCell.self, forCellWithReuseIdentifier: reuseCell);
        self.collectionView?.register(OrderPageNone.self, forCellWithReuseIdentifier: reuseCell2);
        self.collectionView?.backgroundColor = UIColor.gray;
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(orders.count > 0){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseCell, for: indexPath) as! OrderPageCell
            let pastOrder = orders[indexPath.item];
            cell.setTitle(title: pastOrder.value(forKey: "restaurantName") as! String);
            cell.setPrice(priceValue: pastOrder.value(forKey: "price") as! Double);
            cell.setDate(dateString: pastOrder.value(forKey: "date") as! String);
            cell.setImage(imageData: pastOrder.value(forKey: "image") as! NSData);
            return cell;
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseCell2, for: indexPath) as! OrderPageNone
            return cell;
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //get foodList from server
//        print("ok");
        self.getPastOrder(indexPath: indexPath);
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(orders.count > 0){
            return orders.count;
        }else{
            return 1;
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 150)
    }
    
    private func loadImages(url: String!)-> UIImage{
        let url = URL(string: url);
        let data = try? Data(contentsOf: url!);
        let image = UIImage(data: data!);
        return image!;
        
    }
    
    func getPastOrder(indexPath: IndexPath){
        let conn = Conn();
        let pastOrder = orders[indexPath.item];
        let postBody = "OrderID=\(pastOrder.value(forKey: "orderID") as! String)";
        conn.connect(fileName: "LoadPastOrder.php", postString: postBody) { (result) in
            if(urlData != nil){
                
                let jsonData = try? JSONSerialization.jsonObject(with: urlData!, options: .allowFragments) as! NSDictionary;
                let foodNames = jsonData!["foodNames"] as! NSArray;
                let foodQuantities = jsonData!["foodQuantities"] as! NSArray;
                DispatchQueue.main.async {
                    var count = 0;
                    var orderFoods = [OrderHistoryItem]();
                    while(count < foodNames.count){
                        let orderItem = OrderHistoryItem();
                        orderItem.foodName = (foodNames[count] as! String);
                        let stringFoodQuantity = foodQuantities[count] as! String;
                        let intFoodQuantity = Int(stringFoodQuantity);
                        orderItem.foodQuantity = intFoodQuantity;
                        orderFoods.append(orderItem);
                        count+=1;
                    }
                    
                    let orderPageDetails = OrderDetailsPage();
                    orderPageDetails.date = pastOrder.value(forKey: "date") as? String;
                    orderPageDetails.orderSum = pastOrder.value(forKey: "price") as? Double;
                    orderPageDetails.restaurantName = pastOrder.value(forKey: "restaurantName") as? String;
                    orderPageDetails.orderFoods = orderFoods;
                    
                    self.navigationController?.pushViewController(orderPageDetails, animated: true);
                }
                
            }
        }
    }
    
    
}
