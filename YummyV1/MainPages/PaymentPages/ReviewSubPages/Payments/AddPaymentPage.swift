//
//  AddPaymentPage.swift
//  YummyV1
//
//  Created by Brandon In on 1/18/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import Foundation
import UIKit
import Stripe
import CoreData

class AddPaymentPage: UIViewController, STPPaymentCardTextFieldDelegate{
    //STPPaymentCardTextField
    var payment = STPPaymentCardTextField();
    var imageView = UIImageView();
    var addButton: UIBarButtonItem!;
    var errorMessage: UILabel!;
    var dispatch = DispatchGroup();
    
    var userID: String?
    
    override func viewDidLoad() {
        self.navigationItem.title = "Add Card";
        let backButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil);
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton;
        addButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(self.addCard));
        self.navigationItem.rightBarButtonItem = addButton;
        addButton.isEnabled = false;
        self.view.backgroundColor = UIColor.white;
        setup();
        
    }
    
    private func setup(){
        //imageView
        imageView.translatesAutoresizingMaskIntoConstraints = false;
        imageView.image = #imageLiteral(resourceName: "creditCardBig");
        self.view.addSubview(imageView);
        //need x,y,width,height
        imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true;
        imageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive = true;
        imageView.widthAnchor.constraint(equalToConstant: 200).isActive = true;
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true;
        
        //payment Field
        payment.translatesAutoresizingMaskIntoConstraints = false;
        payment.backgroundColor = UIColor.veryLightGray;
        payment.delegate = self;
        self.view.addSubview(payment);
        payment.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true;
        payment.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true;
        payment.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true;
        payment.heightAnchor.constraint(equalToConstant: 30).isActive = true;
     
        errorMessage = UILabel();
        errorMessage.translatesAutoresizingMaskIntoConstraints = false;
        errorMessage.text = "Finish Entering your details";
        errorMessage.textColor = UIColor.red;
        errorMessage.font = UIFont.italicSystemFont(ofSize: 10);
        errorMessage.textAlignment = .center;
        errorMessage.numberOfLines = 1;
        errorMessage.minimumScaleFactor = 0.1;
        errorMessage.adjustsFontSizeToFitWidth = true;
        self.view.addSubview(errorMessage);
        errorMessage.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true;
        errorMessage.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true;
        errorMessage.topAnchor.constraint(equalTo: self.payment.bottomAnchor, constant: 10).isActive = true;
        errorMessage.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        errorMessage.isHidden = true;
    }
    
    @objc private func addCard(){
        //gather up data, send card#,expiration,cvc to server
        //save the card to coreData with info
        //add to cards list and then reload data
        //a full field is of 22
        if(!payment.isValid){//is not valid
            errorMessage.isHidden = false;
        }else{
            if(self.userID != nil){
                let alert = UIAlertController(title: "NickName:", message: "Enter a nickname for this card", preferredStyle: .alert);
                alert.addTextField(configurationHandler: { (textField) in
                    let textField = alert.textFields![0];
                    textField.placeholder = "Enter nickname";
                })
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                    let textField = alert.textFields![0]
                    if(textField.text == ""){
                        textField.placeholder = "Please enter a nickname";
                    }else{
                        self.mainCard(nickName: textField.text!);
                    }
                }))
                self.present(alert, animated: true, completion: nil);
            }else{
                saveAndSend(main: "N", nickName: "New Card");
            }
            
        }
    }
    
    private func mainCard(nickName: String!){
        if(userID != nil){
            let stringy = nickName;
            let alert = UIAlertController(title: "Main Card?", message: "Make this your main card?", preferredStyle: .alert);
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
                self.saveAndSend(main: "Y", nickName: stringy);
            }))
            alert.addAction(UIAlertAction(title: "No", style: .default, handler: { (action) in
                self.saveAndSend(main: "N", nickName: stringy);
            }))
            self.present(alert, animated: true, completion: nil);
        }else{
            saveAndSend(main: "N", nickName: "New Card");
        }
    }
    
    private func saveAndSend(main: String! , nickName: String!){
        let card = payment.cardParams.number!;
        let expirationMonth = String(payment.cardParams.expMonth);
        let expirationYear = String(payment.cardParams.expYear);
        let cvc = payment.cardParams.cvc!;
        let last4 = payment.cardParams.last4();
        let expirationString = "\(expirationMonth)/\(expirationYear)";
        var cardID: String!;
        if(userID != nil){
            //send to server
            let conn = Conn();
            let postBody = "UserID=\(userID!)&NickName=\(nickName!)&Card=\(card)&Expiration=\(expirationString)&CVC=\(cvc)&MainCard=\(main!)";
            dispatch.enter();
            conn.connect(fileName: "AddCard.php", postString: postBody, completion: { (re) in
                //re is the cardID
                cardID = re as String;
                self.dispatch.leave();
            })
            
            dispatch.notify(queue: .main) {
                //send to server and save to core data
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext;
                let entity = NSEntityDescription.entity(forEntityName: "Card", in: context)!;
                let cardObject = NSManagedObject(entity: entity, insertInto: context);
                cardObject.setValue(card, forKey: "cardNum");
                cardObject.setValue(cvc, forKey: "cvc");
                cardObject.setValue(expirationString, forKey: "expiration");
                cardObject.setValue(last4!, forKey: "last4");
                cardObject.setValue(cardID, forKey: "cardID");
                cardObject.setValue(nickName, forKey: "nickName");
                cardObject.setValue(main!, forKey: "mainCard");
                
                do{
                    try context.save();
                    cCards.append(cardObject);
                }catch{
                    print("error");
                }
                
                self.navigationController?.popViewController(animated: true);
            }
        }else{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext;
            let entity = NSEntityDescription.entity(forEntityName: "Card", in: context)!;
            let cardObject = NSManagedObject(entity: entity, insertInto: context);
            cardObject.setValue(card, forKey: "cardNum");
            cardObject.setValue(cvc, forKey: "cvc");
            cardObject.setValue(expirationString, forKey: "expiration");
            cardObject.setValue(last4!, forKey: "last4");
            cardObject.setValue(cardID, forKey: "cardID");
            cardObject.setValue(nickName, forKey: "nickName");
            cardObject.setValue(main!, forKey: "mainCard");
            
//            do{
//                try context.save();
                cCards.append(cardObject);
//            }catch{
//                print("error");
//            }
            
            self.navigationController?.popViewController(animated: true);
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        payment.resignFirstResponder();
    }
    
    func paymentCardTextFieldDidChange(_ textField: STPPaymentCardTextField) {
        addButton.isEnabled = true;
    }
    
}


