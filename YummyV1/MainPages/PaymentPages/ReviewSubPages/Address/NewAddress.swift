//
//  NewAddress.swift
//  YummyV1
//
//  Created by Brandon In on 12/25/17.
//  Copyright © 2017 Rendered Co.RaftPod. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class NewAddress: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
    
    var selectAddress: SelectAddress?
    var userID: String?
    
    //MARK: UI Elements
    var titleMessage: UILabel!;
    var addressField: TextFieldPadded!;
    var zipcodeField: TextFieldPadded!;
    var cityField: TextFieldPadded!;
    var stateField: TextFieldPadded!;
    var statePicker = UIPickerView();
    let stateList = StateList();
    var addButton: UIButton!;
    var errorLabel: UILabel!;
    var dispatchGroup = DispatchGroup();
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white;
        self.navigationItem.title = "New Address";
        let image = UIImage(named: "clear");
        let button = UIButton(type: .system);
        button.setBackgroundImage(image, for: .normal);
        button.addTarget(self, action: #selector(self.clear), for: .touchUpInside);
        button.frame = CGRect(x: 0, y: 0, width: 20, height: 20);
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button);
        setup();
        statePicker.delegate = self;
        statePicker.dataSource = self;
    }
    
    @objc private func clear(){
        self.navigationController?.popViewController(animated: true);
    }
    
    private func setup(){
        //titleMessage
        titleMessage = UILabel();
        titleMessage.translatesAutoresizingMaskIntoConstraints = false;
        titleMessage.text = "Enter Address: ";
        titleMessage.textColor = UIColor.black;
        titleMessage.font = UIFont(name: "Montserrat-SemiBold", size: 16);
        titleMessage.textAlignment = .center;
        self.view.addSubview(titleMessage);
        titleMessage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true;
        titleMessage.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10).isActive = true;
        titleMessage.widthAnchor.constraint(equalToConstant: self.view.frame.size.width/2).isActive = true;
        titleMessage.heightAnchor.constraint(equalToConstant: 30).isActive = true;
        
        //address field
        addressField = TextFieldPadded();
        addressField.translatesAutoresizingMaskIntoConstraints = false;
        addressField.placeholder = "333 3rd street...";
        addressField.font = UIFont(name: "Montserrat-Regular", size: 14);
        addressField.textColor = UIColor.black;
        addressField.borderStyle = .roundedRect
        addressField.autocorrectionType = .no;
        addressField.spellCheckingType = .no;
        addressField.returnKeyType = .next;
        addressField.delegate = self;
        addressField.backgroundColor = UIColor.veryLightGray;
        self.view.addSubview(addressField);
        //need x,y,width,height;
        addressField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true;
        addressField.topAnchor.constraint(equalTo: titleMessage.bottomAnchor, constant: 20).isActive = true;
        addressField.widthAnchor.constraint(equalToConstant: (self.view.frame.width/4)*3).isActive = true;
        addressField.heightAnchor.constraint(equalToConstant: 30).isActive = true;
        
        //zipcode field
        zipcodeField = TextFieldPadded();
        zipcodeField.delegate = self;
        zipcodeField.translatesAutoresizingMaskIntoConstraints = false;
        zipcodeField.placeholder = "Zipcode";
        zipcodeField.font = UIFont(name: "Montserrat-Regular", size: 14);
        zipcodeField.textColor = UIColor.black;
        zipcodeField.backgroundColor = UIColor.veryLightGray;
        zipcodeField.borderStyle = .roundedRect;
        zipcodeField.autocorrectionType = .no;
        zipcodeField.spellCheckingType = .no
        zipcodeField.keyboardType = .numberPad;
        self.view.addSubview(zipcodeField);
        //need x,y,width,height
        zipcodeField.leftAnchor.constraint(equalTo: addressField.leftAnchor).isActive = true;
        zipcodeField.topAnchor.constraint(equalTo: addressField.bottomAnchor, constant: 15).isActive = true;
        zipcodeField.widthAnchor.constraint(equalToConstant: 100).isActive = true;
        zipcodeField.heightAnchor.constraint(equalToConstant: 30).isActive = true;
        
        //city Field
        cityField = TextFieldPadded();
        cityField.delegate = self;
        cityField.translatesAutoresizingMaskIntoConstraints = false;
        cityField.placeholder = "City";
        cityField.font = UIFont(name: "Montserrat-Regular", size: 14);
        cityField.textColor = UIColor.black;
        cityField.backgroundColor = UIColor.veryLightGray;
        cityField.borderStyle = .roundedRect;
        cityField.autocorrectionType = .no;
        cityField.spellCheckingType = .no;
        cityField.returnKeyType = .next;
        self.view.addSubview(cityField);
        //need x,y,width,height
        cityField.rightAnchor.constraint(equalTo: self.addressField.rightAnchor).isActive = true;
        cityField.topAnchor.constraint(equalTo: self.addressField.bottomAnchor, constant: 15).isActive = true;
        cityField.leftAnchor.constraint(equalTo: self.zipcodeField.rightAnchor, constant: 10).isActive = true;
        cityField.heightAnchor.constraint(equalToConstant: 30).isActive = true;
        
        //stateField
        stateField = TextFieldPadded();
        stateField.delegate = self;
        stateField.translatesAutoresizingMaskIntoConstraints = false;
        stateField.placeholder = "State";
        stateField.textColor = UIColor.black;
        stateField.backgroundColor = UIColor.veryLightGray;
        stateField.borderStyle = .roundedRect;
        stateField.font = UIFont(name: "Montserrat-Regular", size: 14);
        stateField.textAlignment = .center;
        stateField.inputView = statePicker;
        self.view.addSubview(stateField);
        //need x,y,width,height
        stateField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true;
        stateField.topAnchor.constraint(equalTo: self.zipcodeField.bottomAnchor, constant: 15).isActive = true;
        stateField.widthAnchor.constraint(equalToConstant: 75).isActive = true;
        stateField.heightAnchor.constraint(equalToConstant: 30).isActive = true;
        
        //add button
        addButton = UIButton(type: .system);
        addButton.translatesAutoresizingMaskIntoConstraints = false;
        addButton.setTitle("Add", for: .normal);
        addButton.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 16);
        addButton.setTitleColor(UIColor.black, for: .normal);
        addButton.backgroundColor = UIColor.appYellow;
        addButton.layer.borderColor = UIColor.lightGray.cgColor;
        addButton.layer.borderWidth = 0.25;
        addButton.layer.cornerRadius = 5;
        self.view.addSubview(addButton);
        //need x,y,width,height
        addButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true;
        addButton.topAnchor.constraint(equalTo: self.stateField.bottomAnchor, constant: 20).isActive = true;
        addButton.widthAnchor.constraint(equalToConstant: 100).isActive = true;
        addButton.heightAnchor.constraint(equalToConstant: 40).isActive = true;
        addButton.addTarget(self, action: #selector(self.addAddress), for: .touchUpInside);
        
        //errorLabel
        errorLabel = UILabel();
        errorLabel.translatesAutoresizingMaskIntoConstraints = false;
        errorLabel.font = UIFont.italicSystemFont(ofSize: 10);
        errorLabel.textColor = UIColor.red;
        errorLabel.textAlignment = .center;
        errorLabel.text = "You already added that address";
        self.view.addSubview(errorLabel);
        errorLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true;
        errorLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true;
        errorLabel.topAnchor.constraint(equalTo: self.addButton.bottomAnchor, constant: 20).isActive = true;
        errorLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        errorLabel.isHidden = true;
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        addressField.resignFirstResponder();
        zipcodeField.resignFirstResponder();
        cityField.resignFirstResponder();
        stateField.resignFirstResponder();
    }
    
    @objc private func addAddress(){
        //upload to server
        var addressID: String!;
        if(addressField.text!.count > 0 && zipcodeField.text!.count > 0 && cityField.text!.count > 0 && stateField.text!.count > 0){
            if(userID != nil){
                let conn = Conn();
                let postString = "UserID=\(self.userID!)&address=\(self.addressField.text!)&city=\(self.cityField.text!)&zipcode=\(self.zipcodeField.text!)&state=\(self.stateField.text!)"
        //        dispatchGroup.enter();
                conn.connect(fileName: "AddAddress.php", postString: postString) { (re) in
                    let result = re as String
                    if(result == "failed"){
                        DispatchQueue.main.async {
                            self.errorLabel.isHidden = false;
        //                    self.dispatchGroup.leave();
                            return;
                        }
                    }else{
                        addressID = result;
                        DispatchQueue.main.async {
                            //save to core data
                            let appDelegate = UIApplication.shared.delegate as? AppDelegate;
                            let context = appDelegate?.persistentContainer.viewContext;
                            let entity = NSEntityDescription.entity(forEntityName: "Address", in: context!)!;
                            let address = NSManagedObject(entity: entity, insertInto: context);
                            address.setValue(self.addressField.text!, forKey: "address");
                            address.setValue(self.cityField.text!, forKey: "city");
                            address.setValue(self.zipcodeField.text!, forKey: "zipcode");
                            address.setValue(self.stateField.text!, forKey: "state");
                            address.setValue(addressID, forKey: "addressID");
                            
                            do{
                                try context?.save();
                                addresses.append(address);
                            }catch{
                                print("error");
                            }
                            
                            if(addresses.count > 1){
                                self.selectAddress?.addressList.reloadData();
                            }else{
//                                addresses.append(address);
                                self.selectAddress?.mainAddress.text = self.addressField.text!;
                                self.selectAddress?.addAddressButton.isHidden = false;
                            }
                            
                            //pop view controller
                            self.navigationController?.popViewController(animated: true);
                        }
                    }
                }
            }else{
                let appDelegate = UIApplication.shared.delegate as? AppDelegate;
                let context = appDelegate?.persistentContainer.viewContext;
                let entity = NSEntityDescription.entity(forEntityName: "Address", in: context!)!;
                let address = NSManagedObject(entity: entity, insertInto: context);
                address.setValue(self.addressField.text!, forKey: "address");
                address.setValue(self.cityField.text!, forKey: "city");
                address.setValue(self.zipcodeField.text!, forKey: "zipcode");
                address.setValue(self.stateField.text!, forKey: "state");
                address.setValue(addressID, forKey: "addressID");
    //
    //            do{
    //                try context?.save();
    //                addresses.append(address);
    //            }catch{
    //                print("error");
    //            }
                addresses.append(address);
                if(addresses.count > 1){
                    self.selectAddress?.addressList.reloadData();
                }else{
                    self.selectAddress?.mainAddress.text = addressField.text!;
                    self.selectAddress?.addAddressButton.isHidden = false;
                }
//                addresses.append(address);
                //pop view controller
                self.navigationController?.popViewController(animated: true);
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField == addressField){
            zipcodeField.becomeFirstResponder();
        }else if(textField == zipcodeField){
            cityField.becomeFirstResponder();
        }else if(textField == cityField){
            stateField.becomeFirstResponder();
        }
        return true;
    }
}

extension NewAddress{
    //columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    //rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 50;
    }
    
    //what the row returns
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return stateList.stateList[row];
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.stateField.text = stateList.stateList[row];
    }
}
