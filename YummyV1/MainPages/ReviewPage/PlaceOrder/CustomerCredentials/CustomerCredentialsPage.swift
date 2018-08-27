//
//  CustomerCredentials.swift
//  YummyV1
//
//  Created by Brandon In on 8/22/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

protocol CustomerCredentialsPageDelegate{
    func handleSaveCustomerInfo(customerName: String, customerPhone: String, customerEmail: String);
}

class CustomerCredentialsPage: UIViewController{

    var customerCredentialsPageDelegate: CustomerCredentialsPageDelegate?
    
    var credentialsList: CustomerCredentialsList = {
        let layout = UICollectionViewFlowLayout();
        let credentialsList = CustomerCredentialsList(frame: .zero, collectionViewLayout: layout);
        return credentialsList;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.white;
        setupNavBar();
        setupCredentialsList();
    }
    
    fileprivate func setupNavBar(){
        self.navigationItem.title = "Your Info";
        
        let leftBarButton = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil);
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = leftBarButton;
        
        let rightBarButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSaveData));
        self.navigationItem.rightBarButtonItem = rightBarButton;
    }
    
    fileprivate func setupCredentialsList(){
        self.view.addSubview(credentialsList);
        credentialsList.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        credentialsList.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        credentialsList.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true;
        if #available(iOS 11.0, *) {
            credentialsList.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        } else {
            // Fallback on earlier versions
            credentialsList.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true;
        };
    }
    
}

extension CustomerCredentialsPage{
    @objc func handleSaveData(){
        if(credentialsList.emptyCheck()){
            //is empty
            //show error
            let alert = UIAlertController(title: "Oh No!", message: "Please fill out your info for your order!!", preferredStyle: .alert);
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil));
            self.present(alert, animated: true, completion: nil);
        }else{//not empty
            let customerName = self.credentialsList.getCustomerName();
            let customerPhone = self.credentialsList.getCustomerTelephone();
            let customerEmail = self.credentialsList.getCustomerEmail();
            
            customerCredentialsPageDelegate?.handleSaveCustomerInfo(customerName: customerName, customerPhone: customerPhone, customerEmail: customerEmail);
            self.navigationController?.popViewController(animated: true);
        }
    }
}
