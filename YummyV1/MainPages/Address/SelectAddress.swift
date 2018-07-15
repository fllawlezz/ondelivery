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
    
    var reviewPage: ReviewPage?;
    var selectedAddress: UserAddress?;
    var profilePage: ProfilePage?;
    //MARK: UI elements
    var addressList: UICollectionView!;
    
    var listHeader: UILabel = {
        let listHeader = UILabel();
        listHeader.translatesAutoresizingMaskIntoConstraints = false;
        listHeader.adjustsFontSizeToFitWidth = true;
        listHeader.numberOfLines = 1;
        listHeader.minimumScaleFactor = 0.1;
        listHeader.text = "Addresses:";
        listHeader.font = UIFont(name: "Montserrat-Regular", size: 16);
        listHeader.textColor = UIColor.lightGray;
        return listHeader;
    }()
    
    var currentLocation: UILabel!;
    var currentLocationButton: UIButton!;
    //reuse identifier
    let reuse = "one";
    let reuse2 = "two";
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white;
        setupNavBar();
        setup();
    }
    
    fileprivate func setupNavBar(){
        self.navigationItem.title = "Select Address";
        
        let leftBackButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil);
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = leftBackButton;
        
        let addAddressButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(self.addNewAddress));
        self.navigationItem.rightBarButtonItem = addAddressButton;
//        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = addAddressButton;
    }
    
    @objc private func clear(){
        self.navigationController?.dismiss(animated: true, completion: nil);
    }
    
    private func setup(){
        //listLabel
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
        
    }
    
    @objc func addNewAddress(){
        let newAddress = NewAddress();
        newAddress.selectAddress = self;
        self.navigationController?.pushViewController(newAddress, animated: true);
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuse, for: indexPath) as! AddressListCell
            let address = addresses[indexPath.row];
        
            cell.setAddress(addressString: address.value(forKey: "address") as? String);
            cell.setID(addressID: address.value(forKey: "addressID") as? String);
            cell.selectAddressPage = self;
        
            if(profilePage != nil){
                cell.addButton.isHidden = true;
            }
        
            return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width, height: 50);
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return addresses.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
}

