//
//  AddressCell.swift
//  YummyV1
//
//  Created by Brandon In on 7/6/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class AddressListCell: UICollectionViewCell{
    
    var selectAddressPage: SelectAddress?
    
    var indexPath: IndexPath?
    
    var userAddress = UserAddress();
    
    var address: UILabel = {
        let address = UILabel();
        address.translatesAutoresizingMaskIntoConstraints = false;
        address.text = "11880 Valencia Drive";
        address.textColor = UIColor.black;
        address.font = UIFont(name: "Montserrat-Regular", size: 12);
        return address;
    }()
    
    var addButton: UIButton = {
        let addButton = UIButton(type: .system);
        addButton.translatesAutoresizingMaskIntoConstraints = false;
        addButton.setTitle("+", for: .normal);
        addButton.setTitleColor(UIColor.black, for: .normal);
        addButton.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 14);
        addButton.layer.cornerRadius = 5;
        addButton.backgroundColor = UIColor.appYellow;
        return addButton;
    }()
    
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
        self.addSubview(addButton);
        //need x,y,width,height
        addButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true;
        addButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        addButton.widthAnchor.constraint(equalToConstant: 25).isActive = true;
        addButton.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside);
        
        //addressLabel
        self.addSubview(address);
        //need x,y,width,height
        address.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true;
        address.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        address.rightAnchor.constraint(equalTo: addButton.leftAnchor, constant: -5).isActive = true;
        address.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true;
        
    }
    
    @objc func addButtonTapped(){
        let address = addresses[indexPath!.row];
        self.userAddress.address = address.value(forKey: "address") as? String;
        self.userAddress.addressID = address.value(forKey: "id") as? String;
        self.selectAddressPage?.reviewPage?.userAddress = self.userAddress;
        self.selectAddressPage?.reviewPage?.tableView.reloadData();
        self.selectAddressPage?.navigationController?.popViewController(animated: true);
    }
    
    func setAddress(addressString: String!){
        self.address.text = addressString;
    }
}
