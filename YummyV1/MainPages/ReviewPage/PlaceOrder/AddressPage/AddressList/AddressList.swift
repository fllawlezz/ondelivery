//
//  AddressList.swift
//  YummyV1
//
//  Created by Brandon In on 7/24/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

protocol AddressListDelegate{
    func didSelectAddress(address: String, city: String, zipcode: String, state: String);
}

class AddressList: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    var addressListDelegate: AddressListDelegate?;
    
    var reuseOne = "One";
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout);
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.backgroundColor = UIColor.white;
        self.delegate = self;
        self.dataSource = self;
        self.register(UserOptionAddressCell.self, forCellWithReuseIdentifier: reuseOne);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseOne, for: indexPath) as! UserOptionAddressCell
//        cell.setAddressTitle(addressTitle: "3421 13th Ave");
//        cell.setAddressDetails(addressDetails: "Oakland,CA 94610");
        let addressObject = addresses[indexPath.item];
        let address = addressObject.value(forKey: "address") as! String;
        let city = addressObject.value(forKey: "city") as! String;
        let state = addressObject.value(forKey: "state") as! String;
        let zipcode = addressObject.value(forKey: "zipcode") as! String;
        
        cell.setAddressTitle(address: address);
        cell.setAddressDetails(city: city, zipcode: zipcode, state: state);
        
//        cell.setAddressTitle(addressTitle: address);
//        cell.setAddressDetails(addressDetails: "\(city),\(state) \(zipcode)")
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! UserOptionAddressCell;
//        self.addressListDelegate?.didSelectAddress(addressTitle: cell.addressTitleString!, addressDetails: cell.addressDetailsString!);
        self.addressListDelegate?.didSelectAddress(address: cell.address!, city: cell.city!, zipcode: cell.zipcode!, state: cell.state!);
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(addresses.count > 0){
            return addresses.count;
        }else{
            return 0;
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.size.width, height: 50);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0);
    }
    
}
