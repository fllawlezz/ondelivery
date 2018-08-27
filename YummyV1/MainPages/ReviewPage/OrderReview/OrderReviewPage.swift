//
//  OrderReviewPage.swift
//  YummyV1
//
//  Created by Brandon In on 7/25/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit


class OrderReviewPage: UIViewController,OrderReviewCheckoutButtonDelegate{
    
    //collectionView
    var reviewCollectionView: ReviewCollectionView = {
        let layout = UICollectionViewFlowLayout();
        let reviewCollectionView = ReviewCollectionView(frame: .zero, collectionViewLayout: layout);
        return reviewCollectionView;
    }()
    //special Instructions (textField)
    
    //checkout
    lazy var checkoutButton: OrderReviewCheckoutButton = {
        let checkoutButton = OrderReviewCheckoutButton(backgroundColor: UIColor.appYellow, title: "Checkout", font: UIFont.montserratSemiBold(fontSize: 16), fontColor: UIColor.black);
        checkoutButton.delegate = self;
        return checkoutButton;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.white;
        
        setupCheckoutButton();
        setupCollectionView();
        if(UIScreenHeight == 568 || UIScreenHeight == 667){
            createObservers();
        }
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
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self);
    }
    
}

extension OrderReviewPage{
    func handleToCheckout(){
        let placeOrderPage = PlaceOrderPage();
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
            self.view.frame.origin.y -= 150;
        }
    }
    
    @objc func keyboardDown(){
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y += 150;
        }
    }
}
