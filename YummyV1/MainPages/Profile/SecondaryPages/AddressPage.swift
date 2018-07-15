//
//  AddressPage.swift
//  YummyV1
//
//  Created by Brandon In on 1/29/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class AddressPage: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    //MARK: UI elements
    var mainAddress: UILabel!;
//    var addAddressButton: UIButton!;
    var addressList: UICollectionView!;
    var listHeader: UILabel!;
    var newAddress: UIButton!;
    
    //reuse identifier
    let reuse = "one";
    let reuse2 = "two";
    
    var userID: String?
    
    override func viewDidLoad() {
        //title
        self.navigationItem.title = "Address List";
//        print(addresses?.count);
//        print(addresses![0].value(forKey: "address") as! String);
        //collectionView with different addresses and an add address button
        self.view.backgroundColor = UIColor.white;
        
        let leftBackButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil);
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = leftBackButton;
//        print(addresses.count);
        setup();
        //button targets
        let longHold = UILongPressGestureRecognizer();
//        longHold.delegate = self;
        longHold.addTarget(self, action: #selector(deleteAddress));
        self.addressList.addGestureRecognizer(longHold);
    }
    
    @objc private func deleteAddress(gesture: UILongPressGestureRecognizer!){
        let point = gesture.location(in: self.addressList);
        var address: String!;
        let alert = UIAlertController(title: "Delete", message: "Delete address?", preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (action) in
            if let indexPath = self.addressList.indexPathForItem(at: point){
                let cell = self.addressList.cellForItem(at: indexPath) as! AddressListCell;
                address = cell.address.text;
                
                //delete from core data
                let delegate = UIApplication.shared.delegate as? AppDelegate;
                let context = delegate?.persistentContainer.viewContext;
                //get from addresses where address.address = address
                var object: NSManagedObject!;
                var count = 0;
                
                for item in addresses{
                    if((item.value(forKey: "address") as! String) == address){
                        object = item;
                        break;
                    }
                    count+=1;
                }
                
                //delete from server
                let addressID = object.value(forKey: "addressID");
                self.deleteAddressServer(addressID: addressID as! String);
                
                //delete object
                context?.delete(object);
                do{
                    try context?.save();
                }catch{
                    
                }
        
                addresses.remove(at: count);
                self.addressList.deleteItems(at: [indexPath]);
                self.addressList.reloadData();
               
                
                
            }
        }))
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil));
        self.present(alert, animated: true, completion: nil);
        
        //delete from core data
        
    }
    
    private func deleteAddressServer(addressID: String!){
        let conn = Conn();
        let postString = "UserID=\(userID!)&AddressID=\(addressID!)";
        conn.connect(fileName: "DeleteAddress.php", postString: postString) { (re) in
        }
    }
    
    @objc private func clear(){
        self.navigationController?.dismiss(animated: true, completion: nil);
    }
    
    private func setup(){
        
        //listLabel
        listHeader = UILabel();
        listHeader.translatesAutoresizingMaskIntoConstraints = false;
        listHeader.adjustsFontSizeToFitWidth = true;
        listHeader.numberOfLines = 1;
        listHeader.minimumScaleFactor = 0.1;
        listHeader.text = "Addresses:";
        listHeader.font = UIFont(name: "Montserrat-Regular", size: 16);
        listHeader.textColor = UIColor.lightGray;
        self.view.addSubview(listHeader);
        //need x,y,width,height
        listHeader.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true;
        listHeader.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10).isActive = true;
        listHeader.widthAnchor.constraint(equalToConstant: self.view.frame.size.width/4).isActive = true;
        listHeader.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        
        //address List
        let layout = UICollectionViewFlowLayout()
        addressList = UICollectionView(frame: .zero, collectionViewLayout: layout);
        addressList.translatesAutoresizingMaskIntoConstraints = false;
        addressList.backgroundColor = UIColor.white;
        addressList.delegate = self;
        addressList.dataSource = self;
        addressList.register(AddressListCell.self, forCellWithReuseIdentifier: reuse);
        addressList.register(OneAddressCell.self, forCellWithReuseIdentifier: reuse2);
        self.view.addSubview(addressList);
        addressList.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        addressList.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        addressList.topAnchor.constraint(equalTo: listHeader.bottomAnchor).isActive = true;
        addressList.heightAnchor.constraint(equalToConstant: 200).isActive = true;
        
        //add button
        newAddress = UIButton(type: .system);
        newAddress.translatesAutoresizingMaskIntoConstraints = false;
        newAddress.setTitle("Add Address", for: .normal);
        newAddress.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 12);
        newAddress.backgroundColor = UIColor.appYellow;
        newAddress.setTitleColor(UIColor.black, for: .normal);
        newAddress.layer.cornerRadius = 5;
        self.view.addSubview(newAddress);
        //need x,y,width,height
        newAddress.centerXAnchor.constraint(equalTo: addressList.centerXAnchor).isActive = true;
        newAddress.topAnchor.constraint(equalTo: addressList.bottomAnchor, constant: 10).isActive = true;
        newAddress.widthAnchor.constraint(equalToConstant: 100).isActive = true;
        newAddress.heightAnchor.constraint(equalToConstant: 30).isActive = true;
        newAddress.addTarget(self, action: #selector(self.addNewAddress), for: .touchUpInside);
        
    }
    
    @objc func addNewAddress(){
        let newAddress = NewAddress();
        self.navigationController?.pushViewController(newAddress, animated: true);
    }
    
    private class AddressListCell: UICollectionViewCell{
        
        var address: UILabel!;
        
        override init(frame: CGRect) {
            super.init(frame: frame);
            self.backgroundColor = UIColor.white;
            setup();
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError()
        }
        
        private func setup(){
            
            //addressLabel
            address = UILabel();
            address.translatesAutoresizingMaskIntoConstraints = false;
            address.text = "11880 Valencia Drive";
            address.textColor = UIColor.black;
            address.font = UIFont(name: "Montserrat-Regular", size: 14);
            self.addSubview(address);
            //need x,y,width,height
            address.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true;
            address.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
            address.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
            address.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true;
            
        }
        
        func setAddress(addressString: String!){
            self.address.text = addressString;
        }
    }
}

extension AddressPage{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if(addresses!.count > 1){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuse, for: indexPath) as! AddressListCell
            //        cell.setAddress(addressString: addressListDataSource[indexPath.row]);
            let address = addresses[indexPath.row];
            cell.setAddress(addressString: address.value(forKey: "address") as? String);
            return cell;
//        }
//        else{
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuse2, for: indexPath) as! OneAddressCell
//            return cell;
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width, height: 50);
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if(addresses!.count > 1){
        return addresses.count;
//        }else{
//            return 0;
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
}

extension AddressPage{
    
    private class OneAddressCell:UICollectionViewCell{
        override init(frame: CGRect) {
            super.init(frame: frame);
            self.backgroundColor = UIColor.white;
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError();
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.addressList.reloadData();
    }
}
