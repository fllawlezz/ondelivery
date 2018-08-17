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
    }
    
    fileprivate func setupCheckoutButton(){
        self.view.addSubview(checkoutButton);
        checkoutButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true;
        checkoutButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true;
        checkoutButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -10).isActive = true;
        checkoutButton.heightAnchor.constraint(equalToConstant: 50).isActive = true;
        
    }
    
    fileprivate func setupCollectionView(){
        self.view.addSubview(reviewCollectionView);
        reviewCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        reviewCollectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        reviewCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true;
        reviewCollectionView.bottomAnchor.constraint(equalTo: self.checkoutButton.topAnchor, constant: -5).isActive = true;
    }
    
    
    
}

extension OrderReviewPage{
    func handleToCheckout(){
        let placeOrderPage = PlaceOrderPage();
        self.navigationController?.pushViewController(placeOrderPage, animated: true);

    }
}
