//
//  OrderReviewPage.swift
//  YummyV1
//
//  Created by Brandon In on 7/25/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class OrderReviewPage: UIViewController,OrderReviewCheckoutButtonDelegate{
    
    var totalSum: Double?{
        didSet{
            if(self.totalSum != nil){
                calculateTaxAndFees();
            }
        }
    }
    var deliveryCharge: Double?;
    var taxAndFees: Double?{
        didSet{
            if let taxAndFees = self.taxAndFees{
                self.reviewCollectionView.taxAndFees = taxAndFees;
            }
        }
    }
    
    var menuItemArray: [MainItem]?;
    var restaurant: Restaurant?;
    
    //collectionView
    var reviewCollectionView: ReviewCollectionView = {
        let layout = UICollectionViewFlowLayout();
        let reviewCollectionView = ReviewCollectionView(frame: .zero, collectionViewLayout: layout);
        return reviewCollectionView;
    }()
    
    //checkout
    lazy var checkoutButton: OrderReviewCheckoutButton = {
        let checkoutButton = OrderReviewCheckoutButton(backgroundColor: UIColor.appYellow, title: "Checkout", font: UIFont.montserratSemiBold(fontSize: 16), fontColor: UIColor.black);
        checkoutButton.delegate = self;
        return checkoutButton;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.white;
        setupNavBar();
        setupCheckoutButton();
        setupCollectionView();
        if(UIScreenHeight == 568 || UIScreenHeight == 667){
            createObservers();
        }
    }
    
    fileprivate func setupNavBar(){
        self.navigationItem.title = "Review Order";
    }
    
    fileprivate func setupCheckoutButton(){
        self.view.addSubview(checkoutButton);
        checkoutButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true;
        checkoutButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true;
        checkoutButton.heightAnchor.constraint(equalToConstant: 50).isActive = true;
        if #available(iOS 11.0, *) {
            checkoutButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        } else {
            // Fallback on earlier versions
            checkoutButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -10).isActive = true;
        };
        
    }
    
    fileprivate func setupCollectionView(){
        self.view.addSubview(reviewCollectionView);
        reviewCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        reviewCollectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        reviewCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true;
        reviewCollectionView.bottomAnchor.constraint(equalTo: self.checkoutButton.topAnchor, constant: -5).isActive = true;
        
//        print(self.menuItemArray!.count)
        reviewCollectionView.menuItemArray = self.menuItemArray;
        reviewCollectionView.deliveryCharge = self.deliveryCharge;
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self);
    }
    
}

extension OrderReviewPage{
    func handleToCheckout(){
        let placeOrderPage = PlaceOrderPage();
        placeOrderPage.restaurant = self.restaurant;
        placeOrderPage.menuItemArray = self.menuItemArray;
        placeOrderPage.deliveryCharge = self.deliveryCharge;
        placeOrderPage.taxAndFees = self.taxAndFees;
//        placeOrderPage.totalSum = self.totalSum! + self.deliveryCharge! + self.taxAndFees!;
        placeOrderPage.totalSum = self.totalSum;
        self.navigationController?.pushViewController(placeOrderPage, animated: true);

    }
    
    func createObservers(){
        let name = Notification.Name(rawValue: specialInstructionsKeyboardUp);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardUp), name: name, object: nil);
        
        let keyboardDownName = Notification.Name(rawValue: specialInstructionsKeyboardDown);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDown), name: keyboardDownName, object: nil);
    }
    
    @objc func keyboardUp(){
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y -= 200;
        }
    }
    
    @objc func keyboardDown(){
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y += 200;
        }
    }
    
    fileprivate func calculateTaxAndFees(){
        let taxFee = self.totalSum! * 0.0975;
        let companyFee = 3.99;
        let taxAndFees = taxFee+companyFee;
        self.taxAndFees = taxAndFees;
    }
}
