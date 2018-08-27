//
//  CustomerCredentialsList.swift
//  YummyV1
//
//  Created by Brandon In on 8/22/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class CustomerCredentialsList: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CredentialsCellDelegate{
    
    let reuseCredentialsCell = "Credentials";
    let credentialTitles = ["Name","Telephone","Email"];
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout);
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.delegate = self;
        self.dataSource = self;
        self.register(CredentialsCell.self, forCellWithReuseIdentifier: reuseCredentialsCell);
        self.backgroundColor = UIColor.white;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseCredentialsCell, for: indexPath) as! CredentialsCell;
        cell.cellIndex = indexPath.item;
        cell.credentialsCellDelegate = self;
        cell.setupData(credentialsTitle: credentialTitles[indexPath.item] , credentialsPlaceHolder: credentialTitles[indexPath.item]);
        return cell;
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.size.width, height: 50);
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismissAll();
    }
}

extension CustomerCredentialsList{
    func emptyCheck() -> Bool{
        var count = 0;
        while(count<3){
            let cell = self.cellForItem(at: IndexPath(item: count, section: 0)) as! CredentialsCell;
            if(cell.credentialsTextField.text?.count == 0){
                return true;
            }
            count+=1;
        }
        return false;
    }
    
    func getCustomerName() -> String{
        let cell = self.cellForItem(at: IndexPath(item: 0, section: 0)) as! CredentialsCell;
        return cell.credentialsTextField.text!
    }
    
    func getCustomerTelephone() -> String{
        let cell = self.cellForItem(at: IndexPath(item: 1, section: 0)) as! CredentialsCell;
        return cell.credentialsTextField.text!
    }
    
    func getCustomerEmail() -> String{
        let cell = self.cellForItem(at: IndexPath(item: 2, section: 0)) as! CredentialsCell;
        return cell.credentialsTextField.text!
    }
    
    func dismissAll(){
        var count = 0;
        while(count<3){
            let cell = self.cellForItem(at: IndexPath(item: count, section: 0)) as! CredentialsCell;
            cell.credentialsTextField.resignFirstResponder();
            count+=1;
        }
    }
}

//protocl methods
extension CustomerCredentialsList{
    func handleNextField(cellIndex: Int) {
        if(cellIndex < 2){
            let nextCellIndex = IndexPath(item: cellIndex+1, section: 0);
            let cell = self.cellForItem(at: nextCellIndex) as! CredentialsCell;
            cell.credentialsTextField.becomeFirstResponder();
        }else{
            let nextCellIndex = IndexPath(item: cellIndex, section: 0);
            let cell = self.cellForItem(at: nextCellIndex) as! CredentialsCell;
            cell.credentialsTextField.resignFirstResponder();
        }
        
    }
}
