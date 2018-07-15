//
//  SubscriptionChargePage2.swift
//  YummyV1
/*
    Asks for user's credit card info to charge for desired amount. If not charged then etc.
 */

//
//  Created by Brandon In on 3/26/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit
import Stripe
import CoreData

class SubscriptionPage2: UIViewController, UITextFieldDelegate{
    var customTabBarController: CustomTabBarController?;
    var fromStartUp = false;
    //DATA VARIABLES
    
    var totalCharge: Double? = 22.00
    var subscriptionPlan: Int?
    var cardID: String?
    
    var restaurants: [Restaurant]?
    var advertisedRestaurants: [Restaurant]?
    
    let paymentField: STPPaymentCardTextField = {
        let paymentField = STPPaymentCardTextField();
        paymentField.backgroundColor = UIColor.veryLightGray;
        return paymentField;
    }()
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel();
        titleLabel.text = "Please enter your Card Info";
        titleLabel.textColor = UIColor.black;
        titleLabel.font = UIFont(name: "Montserrat-Regular", size: 18);
        titleLabel.textAlignment = .center;
        titleLabel.adjustsFontSizeToFitWidth = true;
        titleLabel.numberOfLines = 1;
        titleLabel.minimumScaleFactor = 0.1;
        return titleLabel;
    }()
    
    private lazy var totalLabel: UILabel = {
        let totalLabel = UILabel();
        totalLabel.translatesAutoresizingMaskIntoConstraints = false;
        let formatString = String(format: "%.2f", totalCharge!);
        totalLabel.text = "Total: $\(formatString)";
        totalLabel.textColor = UIColor.red;
        totalLabel.textAlignment = .center;
        totalLabel.font = UIFont(name: "Montserrat-Regular", size: 16);
        return totalLabel;
    }()
    
    let totalDescription: UILabel = {
        let totalDescription = UILabel();
        totalDescription.translatesAutoresizingMaskIntoConstraints = false;
        totalDescription.text = "Re-occuring charge for your subscription. Charges are made on the 1st of every month.";
        totalDescription.textColor = UIColor.black;
        totalDescription.textAlignment = .center;
        totalDescription.font = UIFont(name: "Montserrat-Regular", size: 14);
        totalDescription.adjustsFontSizeToFitWidth = true;
        totalDescription.numberOfLines = 2;
        totalDescription.minimumScaleFactor = 0.1;
        return totalDescription;
    }()
    
    let submitButton: UIButton = {
        let submitButton = UIButton(type: .system);
        submitButton.setTitle("Submit", for: .normal);
        submitButton.backgroundColor = UIColor.appYellow;
        submitButton.setTitleColor(UIColor.black, for: .normal);
        submitButton.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 16);
        return submitButton;
    }()
    
    let errorLabel: UILabel = {
        let errorLabel = UILabel();
        errorLabel.translatesAutoresizingMaskIntoConstraints = false;
        errorLabel.text = "Please enter all your info, including nickname";
        errorLabel.textColor = UIColor.red;
        errorLabel.textAlignment = .center;
        errorLabel.font = UIFont(name: "Montserrat-Regular", size: 10);
        errorLabel.adjustsFontSizeToFitWidth = true;
        errorLabel.numberOfLines = 1;
        errorLabel.minimumScaleFactor = 0.1;
        return errorLabel;
    }()
    
    let nickNameField: TextFieldPadded = {
        let nickNameField = TextFieldPadded();
        nickNameField.placeholder = "Nickname";
        nickNameField.font = UIFont(name: "Montserrat-Regular", size: 14);
        nickNameField.textColor = UIColor.black;
        nickNameField.layer.cornerRadius = 3;
        nickNameField.borderStyle = .roundedRect;
        nickNameField.backgroundColor = UIColor.veryLightGray;
        nickNameField.returnKeyType = .go;
        return nickNameField;
    }()
    
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView();
        spinner.activityIndicatorViewStyle = .whiteLarge;
        return spinner;
    }()
    
    var darkView: UIView!
    
    override func viewDidLoad() {
        errorLabel.isHidden = true;
        
        self.title = "Details"
        self.view.backgroundColor = UIColor.white;
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false;
        self.view.addSubview(titleLabel);
        titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50).isActive = true;
        titleLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 25).isActive = true;
        titleLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -25).isActive = true;
        titleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true;
        
        paymentField.translatesAutoresizingMaskIntoConstraints = false;
        self.view.addSubview(paymentField);
        paymentField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true;
        paymentField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 25).isActive = true;
        paymentField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -25).isActive = true;
        paymentField.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        
        nickNameField.delegate = self;
        nickNameField.translatesAutoresizingMaskIntoConstraints = false;
        self.view.addSubview(nickNameField);
        nickNameField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 25).isActive = true;
        nickNameField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -25).isActive = true;
        nickNameField.topAnchor.constraint(equalTo: self.paymentField.bottomAnchor, constant: 10).isActive = true;
        nickNameField.heightAnchor.constraint(equalToConstant: 30).isActive = true;
        
        totalLabel.translatesAutoresizingMaskIntoConstraints = false;
        self.view.addSubview(totalLabel);
        totalLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        totalLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true;
        totalLabel.topAnchor.constraint(equalTo: self.nickNameField.bottomAnchor, constant: 10).isActive = true;
        totalLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true;
        
        totalDescription.translatesAutoresizingMaskIntoConstraints = false;
        self.view.addSubview(totalDescription);
        totalDescription.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 25).isActive = true;
        totalDescription.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -25).isActive = true;
        totalDescription.topAnchor.constraint(equalTo: totalLabel.bottomAnchor, constant: 5).isActive = true;
        totalDescription.heightAnchor.constraint(equalToConstant: 30).isActive = true;
        
        errorLabel.translatesAutoresizingMaskIntoConstraints = false;
        self.view.addSubview(errorLabel);
        errorLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 25).isActive = true;
        errorLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -25).isActive = true;
        errorLabel.topAnchor.constraint(equalTo: self.totalDescription.bottomAnchor, constant: 10).isActive = true;
        errorLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        
        submitButton.translatesAutoresizingMaskIntoConstraints = false;
        self.view.addSubview(submitButton);
        submitButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true;
        submitButton.widthAnchor.constraint(equalToConstant: 150).isActive = true;
        submitButton.heightAnchor.constraint(equalToConstant: 40).isActive = true;
        submitButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 20).isActive = true;
        submitButton.addTarget(self, action: #selector(submitCharge), for: .touchUpInside);
        
        submitButton.layer.shadowColor = UIColor.black.cgColor;
        submitButton.layer.shadowOpacity = 0.25;
        submitButton.layer.shadowOffset = CGSize.zero;
        submitButton.layer.shadowRadius = 0.75;
        
        darkView = UIView();
        darkView.translatesAutoresizingMaskIntoConstraints = false;
        darkView.backgroundColor = UIColor.black;
        darkView.alpha = 0;
        self.view.addSubview(darkView);
        darkView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        darkView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        darkView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true;
        darkView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true;
        
        spinner.translatesAutoresizingMaskIntoConstraints = false;
        self.view.addSubview(spinner);
        spinner.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true;
        spinner.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true;
        spinner.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        spinner.widthAnchor.constraint(equalToConstant: 25).isActive = true;
        spinner.isHidden = true;
        
        
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField == paymentField){
            nickNameField.becomeFirstResponder();
        }else if(textField == nickNameField){
            submitCharge();
        }
        return true;
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nickNameField.resignFirstResponder();
        paymentField.resignFirstResponder();
    }
    
    @objc func submitCharge(){
        nickNameField.resignFirstResponder();
        paymentField.resignFirstResponder();
        UIView.animate(withDuration: 0.3) {
            self.darkView!.alpha = 0.7;
            self.spinner.startAnimating();
        }
        //check field is complete, add the number of orders, then go to home page
        if(paymentField.isValid && nickNameField.text != ""){
            //do everything
//            let cardParams = getCardParams();
            let cardParams = STPCardParams();
            cardParams.number = self.paymentField.cardNumber!;
            cardParams.expMonth = self.paymentField.expirationMonth;
            cardParams.expYear = self.paymentField.expirationYear;
            cardParams.cvc = self.paymentField.cvc;
            
            STPAPIClient.shared().createToken(withCard: cardParams) { (token: STPToken?, error: Error?) in
                guard let token = token, error == nil else {
                    // Present error to user...
                    print("There is an error with token creation");
                    return
                }
                self.prepareAndCharge(token: token, cardParams: cardParams);
            
            }
            
        }else{
            errorLabel.isHidden = false;
            UIView.animate(withDuration: 0.3) {
                self.darkView!.alpha = 0;
                self.spinner.stopAnimating();
            }
        }
    }
    
    func prepareAndCharge(token: STPToken, cardParams: STPCardParams){
        var subscriptionString: String!
        var freeOrdersWithSubscription: Int!;
        switch(subscriptionPlan!){
        case 0:
            subscriptionString = "Standard";
            freeOrdersWithSubscription = 5;
            break;
        case 1:
            subscriptionString = "Premium";
            freeOrdersWithSubscription = 10;
            break;
        case 2:
            subscriptionString = "Executive";
            freeOrdersWithSubscription = 15;
            break;
        default: break;
        }
        
        user!.subscriptionPlan = subscriptionString;
        user!.freeOrders = freeOrdersWithSubscription;
        saveDefaults(defaults: defaults!);
        
        let conn = Conn();
        let dateString = "\(cardParams.expMonth)/\(cardParams.expYear)"
        let postBody = "userID=\(user!.userID!)&stripeToken=\(token)&subPlan=\(subscriptionString!)&freeOrders=\(user!.freeOrders!)&email=\(user!.email!)&chargeAmount=\(totalCharge!)&NickName=\(self.nickNameField.text!)&Card=\(cardParams.number!)&Expiration=\(dateString)&CVC=\(cardParams.cvc!)&MainCard=N";
        print(postBody);
        conn.connect(fileName: "subscribe.php", postString: postBody) { (result) in
            self.cardID = result as String;
            
            DispatchQueue.main.async {
                let expirationString = "\(self.paymentField.expirationMonth)/\(self.paymentField.expirationYear)"
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext;
                let entity = NSEntityDescription.entity(forEntityName: "Card", in: context)!;
                let cardObject = NSManagedObject(entity: entity, insertInto: context);
                
                cardObject.setValue(self.paymentField.cardNumber!, forKey: "cardNum");
                cardObject.setValue(self.paymentField.cvc, forKey: "cvc");
                cardObject.setValue(expirationString, forKey: "expiration");
                cardObject.setValue(self.paymentField.cardParams.last4(), forKey: "last4");
                cardObject.setValue(self.cardID!, forKey: "cardID");
                cardObject.setValue(self.nickNameField.text, forKey: "nickName");
                cardObject.setValue("N", forKey: "mainCard");
                
                do{
                    try context.save();
                    cCards.append(cardObject);
                }catch{
                    fatalError();
                }
                if(self.fromStartUp){
                    let customTabBar = CustomTabBarController();
                    let mainPage = customTabBar.mainPage;
//                    let recommendedPage = customTabBar.recomendedMainPage;
                    
                    mainPage?.restaurants = self.restaurants;
                    mainPage?.advertisedRestaurants = self.advertisedRestaurants;
                    
//                    recommendedPage?.restaurants = self.restaurants;
//                    recommendedPage?.advertisedRestaurants = self.advertisedRestaurants;
                    
                    self.present(customTabBar, animated: true, completion: nil);

                }else{
                    self.customTabBarController?.selectedIndex = 2;
                    self.dismiss(animated: true, completion: nil);
                }
            }
        }
    }
    
}
