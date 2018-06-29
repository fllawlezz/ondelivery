//
//  SelectAddress.swift
//  YummyV1
//
//  Created by Brandon In on 12/22/17.
//  Copyright © 2017 Rendered Co.RaftPod. All rights reserved.
//

import Foundation
import UIKit

class SelectAddress: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    //MARK: UI elements
    var mainAddress: UILabel!;
    var addAddressButton: UIButton!;
    var addressList: UICollectionView!;
    var listHeader: UILabel!;
    var newAddress: UIButton!;
    var currentLocation: UILabel!;
    var currentLocationButton: UIButton!;
//    var addressListDataSource = ["141 Felix Street","228 Orange Drive","888 poker way"];
//    var addressListDataSource = [NSManaged]
    
    //reuse identifier
    let reuse = "one";
    let reuse2 = "two";
    
    override func viewDidLoad() {
        //title
        self.navigationItem.title = "Select Address";
        
        //collectionView with different addresses and an add address button
        self.view.backgroundColor = UIColor.white;
        
        let leftBackButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil);
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = leftBackButton;
//        self.navigationItem.rightBarButtonItem = currentLocationButton;
        
//        buttonItem.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Helvetica-Bold", size: 26.0)!,NSForegroundColorAttributeName: UIColor.greenColor()],
//                                          forState: UIControlState.Normal)
        setup();
        //button targets
        getData();
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.addressList.reloadData();
    }
    
    private func getData(){
        
    }
    
    @objc private func clear(){
        self.navigationController?.dismiss(animated: true, completion: nil);
    }
    
    private func setup(){
        
        //add current Location Button
//        currentLocationButton = UIButton(type: .system);
//        currentLocationButton.translatesAutoresizingMaskIntoConstraints = false;
//        currentLocationButton.setTitle("+", for: .normal);
//        currentLocationButton.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 14);
//        currentLocationButton.setTitleColor(UIColor.black, for: .normal);
//        currentLocationButton.backgroundColor = UIColor.appYellow;
//        currentLocationButton.layer.cornerRadius = 5;
//        self.view.addSubview(currentLocationButton);
//        currentLocationButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true;
//        currentLocationButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10).isActive = true;
//        currentLocationButton.widthAnchor.constraint(equalToConstant: 30).isActive = true;
//        currentLocationButton.heightAnchor.constraint(equalToConstant: 30).isActive = true;
//        currentLocationButton.addTarget(self, action: #selector(self.useCurrentLocation), for: .touchUpInside);
        
//        currentLocation = UILabel();
//        currentLocation .translatesAutoresizingMaskIntoConstraints = false;
//        //        mainAddress.text = "3421 13th Ave ";
//        currentLocation .font = UIFont(name: "Copperplate", size: 16);
//        currentLocation .textColor = UIColor.blue;
//        currentLocation.text = "Current Location";
//        self.view.addSubview(currentLocation );
//        //need x,y,width,height
//        currentLocation .leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true;
//        currentLocation .centerYAnchor.constraint(equalTo: self.currentLocationButton.centerYAnchor).isActive = true;
//        currentLocation .rightAnchor.constraint(equalTo: self.currentLocationButton.leftAnchor, constant: -5).isActive = true;
//        currentLocation .heightAnchor.constraint(equalToConstant: 25).isActive = true;
        
        //add address button
        addAddressButton = UIButton(type: .system);
        addAddressButton.translatesAutoresizingMaskIntoConstraints = false;
        addAddressButton.setTitle("+", for: .normal);
        addAddressButton.titleLabel?.font = UIFont(name: "Copperplate", size: 14);
        addAddressButton.setTitleColor(UIColor.black, for: .normal);
        addAddressButton.backgroundColor = UIColor.appYellow;
        addAddressButton.layer.cornerRadius = 5;
        self.view.addSubview(addAddressButton);
        addAddressButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true;
        addAddressButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive = true;
        addAddressButton.widthAnchor.constraint(equalToConstant: 30).isActive = true;
        addAddressButton.heightAnchor.constraint(equalToConstant: 30).isActive = true;
        addAddressButton.addTarget(self, action: #selector(self.addMainAddress), for: .touchUpInside);
        
        if(addresses.count==0){
            addAddressButton.isHidden = true;
        }
        
        mainAddress = UILabel();
        mainAddress.translatesAutoresizingMaskIntoConstraints = false;
//        mainAddress.text = "3421 13th Ave ";
        mainAddress.font = UIFont(name: "Montserrat-Regular", size: 16);
        mainAddress.textColor = UIColor.black;
        self.view.addSubview(mainAddress);
        //need x,y,width,height
        mainAddress.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true;
        mainAddress.centerYAnchor.constraint(equalTo: self.addAddressButton.centerYAnchor).isActive = true;
        mainAddress.rightAnchor.constraint(equalTo: self.addAddressButton.leftAnchor, constant: -5).isActive = true;
        mainAddress.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        
        //get the first from addresses, which shoudl be the main address
        if(addresses.count > 0){
            let address = addresses[0];
            mainAddress.text = address.value(forKey: "address") as? String;
        }
        
        let border = UIView();
        border.translatesAutoresizingMaskIntoConstraints = false;
        border.backgroundColor = UIColor.gray;
        self.view.addSubview(border);
        border.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        border.topAnchor.constraint(equalTo: self.mainAddress.bottomAnchor, constant: 10).isActive = true;
        border.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true;
        border.heightAnchor.constraint(equalToConstant: 0.5).isActive = true;
        
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
        listHeader.topAnchor.constraint(equalTo: border.bottomAnchor, constant: 10).isActive = true;
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
        newAddress.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 14);
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
    
    //MARK: useCurrentLocation
    @objc func useCurrentLocation(){
        //get current Location
        addressUserText = self.currentLocation.text;
        addressIDText = "none";
        self.navigationController?.popViewController(animated: true);
    }
    
    @objc func addNewAddress(){
        let newAddress = NewAddress();
        newAddress.selectAddress = self;
        self.navigationController?.pushViewController(newAddress, animated: true);
    }
    
    @objc private func addMainAddress(){
        
        let address = addresses[0];
        addressUserText = address.value(forKey: "address") as? String;
        addressIDText = address.value(forKey: "addressID") as? String;
        self.navigationController?.popViewController(animated: true);
    }
    
    private class AddressListCell: UICollectionViewCell{
        
        var address: UILabel!;
        var addButton: UIButton!;
        var btnTapAction: (()->())?;//callback method
        
        override init(frame: CGRect) {
            super.init(frame: frame);
            self.backgroundColor = UIColor.white;
            setup();
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError()
        }
        
        private func setup(){
            //addButton
            addButton = UIButton(type: .system);
            addButton.translatesAutoresizingMaskIntoConstraints = false;
            addButton.setTitle("+", for: .normal);
            addButton.setTitleColor(UIColor.black, for: .normal);
            addButton.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 14);
            addButton.layer.cornerRadius = 5;
            addButton.backgroundColor = UIColor.appYellow;
            self.addSubview(addButton);
            //need x,y,width,height
            addButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true;
            addButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
            addButton.widthAnchor.constraint(equalToConstant: 25).isActive = true;
            addButton.heightAnchor.constraint(equalToConstant: 25).isActive = true;
            addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside);
            
            //addressLabel
            address = UILabel();
            address.translatesAutoresizingMaskIntoConstraints = false;
            address.text = "11880 Valencia Drive";
            address.textColor = UIColor.black;
            address.font = UIFont(name: "Montserrat-Regular", size: 12);
            self.addSubview(address);
            //need x,y,width,height
            address.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true;
            address.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
            address.rightAnchor.constraint(equalTo: addButton.leftAnchor, constant: -5).isActive = true;
            address.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true;
            
        }
        
        @objc func addButtonTapped(){
            btnTapAction?()
        }
        
        func setAddress(addressString: String!){
            self.address.text = addressString;
        }
    }
}

//MARK: CollectionView
extension SelectAddress{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(addresses.count > 1){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuse, for: indexPath) as! AddressListCell
    //        cell.setAddress(addressString: addressListDataSource[indexPath.row]);
            let address = addresses[indexPath.row+1];
            cell.setAddress(addressString: address.value(forKey: "address") as? String);
            cell.btnTapAction = {
                () in
                let address = addresses[indexPath.row+1];
                addressUserText = address.value(forKey: "address") as? String;
                addressIDText = address.value(forKey: "addressID") as? String;
                self.navigationController?.popViewController(animated: true);
            }
            return cell;
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuse2, for: indexPath) as! OneAddressCell
            return cell;
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width, height: 50);
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return addresses.count-1;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
}

extension SelectAddress{
    
    private class OneAddressCell:UICollectionViewCell{
        override init(frame: CGRect) {
            super.init(frame: frame);
            self.backgroundColor = UIColor.white;
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError();
        }
        
    }
}
