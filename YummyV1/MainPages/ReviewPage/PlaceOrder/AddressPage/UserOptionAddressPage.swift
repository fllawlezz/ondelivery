//
//  UserOptionAddressPage.swift
//  YummyV1
//
//  Created by Brandon In on 7/24/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

protocol UserAddressPageDelegate{
    func didSelectAddress(selectedAddress: UserAddress);
}

class UserOptionAddressPage: UIViewController,AddressListDelegate, NewAddressPageDelegate{
    
    var delegate: UserAddressPageDelegate?;
    
    lazy var addressList: AddressList = {
        let layout = UICollectionViewFlowLayout();
        let addressList = AddressList(frame: .zero, collectionViewLayout: layout);
        return addressList;
    }();
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.white;
        setupAddressList();
        setupNavBar();
    }
    
    fileprivate func setupNavBar(){
        self.navigationItem.title = "Address Page";
        
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil);
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton;
        
        let addAddressButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(self.handleToAddAddressPage));
        self.navigationItem.rightBarButtonItem = addAddressButton;
    }
    
    fileprivate func setupAddressList(){
        self.view.addSubview(addressList);
        addressList.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        addressList.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        addressList.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true;
        addressList.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true;
        
        addressList.addressListDelegate = self;
    }
    
}

extension UserOptionAddressPage{
//    func didSelectAddress(addressTitle: String, addressDetails: String) {
//        let selectedAddress = SelectedAddress();
//        selectedAddress.addressTitle = addressTitle;
//        selectedAddress.addressDetails = addressDetails;
//
//        self.delegate?.didSelectAddress(selectedAddress: selectedAddress);
//        self.navigationController?.popViewController(animated: true);
//    }
    
    func didSelectAddress(address: String, city: String, zipcode: String, state: String) {
        let userAddress = UserAddress();
        userAddress.address = address;
        userAddress.city = city;
        userAddress.zipcode = zipcode;
        userAddress.state = state;
        
        self.delegate?.didSelectAddress(selectedAddress: userAddress);
        self.navigationController?.popViewController(animated: true);
    }
    
    
    @objc func handleToAddAddressPage(){
        let addAddressPage = NewAddress();
        addAddressPage.newAddressPageDelegate = self;
        self.navigationController?.pushViewController(addAddressPage, animated: true);
    }
    
    func reloadAddresses() {
        self.addressList.reloadData();
    }
    
}
