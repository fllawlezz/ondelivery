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
    
    
    
}
