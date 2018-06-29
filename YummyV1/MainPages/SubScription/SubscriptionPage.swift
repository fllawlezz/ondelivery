//
//  SubscriptionCharge.swift
//  YummyV1
//
/*
 Description: Three different pages with three different subscription cycles: standard, premium, executive
 Each page has one picture with one button, and then a description right underneat the picture describing what and how much the subscription is going to cost.
 When you press a button, a alert window pops up with a description, "are you sure you want to subscribe?",
 yes: sent to another page to enter credit card details
 no: closes alert.
 */
//  Created by Brandon In on 3/18/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import Foundation
import UIKit

class SubscriptionPage: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource{
    var customTabBar: CustomTabBarController?
    
    var subPlan: String?
    var freeOrders: Int?
    
    var restaurants: [Restaurant]?
    var advertisedRestaurants: [Restaurant]?
    
    var fromStartUp = false;
    
    let reuseIdentifier = "one";
    var topView: UIView!;
    
    var collectionView: UICollectionView!;
    var pageInidcators: UIPageControl!;
    var standardView: UIView!;
    var premiumView: UIView!;
    var executiveView: UIView!;
    
    lazy var selectedDarkView: UIView = {
        let selectedDarkView = UIView();
        
        selectedDarkView.translatesAutoresizingMaskIntoConstraints = false;
        selectedDarkView.backgroundColor = UIColor.black;
        selectedDarkView.alpha = 0;
        return selectedDarkView;
    }()
    
    lazy var spinner: SpinningView = {
        let spinner = SpinningView();
        spinner.translatesAutoresizingMaskIntoConstraints = false;
        spinner.circleLayer.strokeColor = UIColor.white.cgColor;
        return spinner;
    }()
    
    lazy var message: UILabel = {
        let message = UILabel();
        message.translatesAutoresizingMaskIntoConstraints = false;
        message.text = "Loading...";
        message.font = UIFont(name: "Montserrat-Regular", size: 14);
        message.textAlignment = .center;
        message.textColor = UIColor.white;
        return message;
    }()
    
    //DATA ELEMENTS
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white;
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        self.navigationItem.title = "Subscription";
        navigationItem.hidesBackButton = true;
        
        let skipButton = UIBarButtonItem();
        skipButton.title = "Skip";
        skipButton.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont(name: "Montserrat-Regular", size: 14) ?? UIFont.systemFont(ofSize: 14)], for: .normal);
        skipButton.target = self;
        skipButton.action = #selector(skipAction);
        self.navigationItem.rightBarButtonItem = skipButton;
        
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil);
        self.navigationItem.backBarButtonItem = backButton;
        
//        setupTopNavBar();
        setupCollectionView();
    }
    
    func setupTopNavBar(){
        topView = UIView();
        topView.translatesAutoresizingMaskIntoConstraints = false;
        topView.backgroundColor = UIColor.black;
        self.view.addSubview(topView);
        topView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        topView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        topView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true;
        topView.heightAnchor.constraint(equalToConstant: 70).isActive = true;
    }
    
    func setupCollectionView(){
        let flowLayout = UICollectionViewFlowLayout();
        flowLayout.scrollDirection = .horizontal;
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout);
        collectionView.translatesAutoresizingMaskIntoConstraints = false;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.backgroundColor = UIColor.white;
        collectionView.isPagingEnabled = true;
        collectionView.alwaysBounceVertical = false;
        collectionView.register(SubscriptionChargePage.self, forCellWithReuseIdentifier: reuseIdentifier);
        self.view.addSubview(collectionView);
        collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        collectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true;
        collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true;
        
        pageInidcators = UIPageControl();
        pageInidcators.translatesAutoresizingMaskIntoConstraints = false;
        pageInidcators.numberOfPages = 3;
        pageInidcators.currentPage = 0;
        pageInidcators.pageIndicatorTintColor = UIColor.gray;
        pageInidcators.currentPageIndicatorTintColor = UIColor.black;
        self.view.addSubview(pageInidcators);
        pageInidcators.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true;
        pageInidcators.widthAnchor.constraint(equalToConstant: 100).isActive = true;
        pageInidcators.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -10).isActive = true;
        pageInidcators.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        
        self.view.addSubview(selectedDarkView);
        selectedDarkView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        selectedDarkView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        selectedDarkView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true;
        selectedDarkView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true;
        
        selectedDarkView.addSubview(spinner);
        spinner.centerXAnchor.constraint(equalTo: selectedDarkView.centerXAnchor).isActive = true;
        spinner.centerYAnchor.constraint(equalTo: selectedDarkView.centerYAnchor).isActive = true;
        spinner.widthAnchor.constraint(equalToConstant: 50).isActive = true;
        spinner.heightAnchor.constraint(equalToConstant: 50).isActive = true;
        
        selectedDarkView.addSubview(message);
        message.centerXAnchor.constraint(equalTo: selectedDarkView.centerXAnchor).isActive = true;
        message.bottomAnchor.constraint(equalTo: spinner.topAnchor, constant: -10).isActive = true;
        message.widthAnchor.constraint(equalToConstant: 150).isActive = true;
        message.heightAnchor.constraint(equalToConstant: 25).isActive = true;
    }
    
    func clickedSubscribe(charge: Double, subscriptionPlan: Int){
        //go to next viewController and set the charge
        let subscriptionPage2 = SubscriptionPage2();
        subscriptionPage2.totalCharge = charge;
        subscriptionPage2.subscriptionPlan = subscriptionPlan;
        subscriptionPage2.customTabBarController = self.customTabBar;
        subscriptionPage2.fromStartUp = self.fromStartUp;
        
        subscriptionPage2.restaurants = self.restaurants!;
        subscriptionPage2.advertisedRestaurants = self.advertisedRestaurants!;
        
        self.navigationController?.pushViewController(subscriptionPage2, animated: true);
    }
    
    @objc func skipAction(){
        self.spinner.updateAnimation();
        
        UIView.animate(withDuration: 0.3, animations: {
            self.selectedDarkView.alpha = 0.7;
        })
        
        subPlan = "NONE";
        freeOrders = 0;
        saveSubscription(defaults: defaults!, subscriptionPlan: subPlan!, freeOrders: freeOrders!);
        
        if(fromStartUp){
            let customTabBar = CustomTabBarController();
            let mainPage = customTabBar.mainPage;
            let recommendedPage = customTabBar.recomendedMainPage;
            
            mainPage?.restaurants = self.restaurants;
            mainPage?.advertisedRestaurants = self.advertisedRestaurants;
            
            recommendedPage?.restaurants = self.restaurants;
            recommendedPage?.advertisedRestaurants = self.advertisedRestaurants;
            
            self.present(customTabBar, animated: true, completion: nil);

        }else{
            self.customTabBar?.selectedIndex = 3;
            self.dismiss(animated: true, completion: nil);
        }
        //dismiss this navigationControlelr
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SubscriptionChargePage;
        cell.setupText(subscriptionPlan: indexPath.item);
        cell.buttonCallback = {
            //do in callback
            switch(cell.subscriptionPlan){
            case 0: self.clickedSubscribe(charge: cell.standardCharge, subscriptionPlan: 0);break;
            case 1: self.clickedSubscribe(charge: cell.premiumCharge, subscriptionPlan: 1);break;
            case 2: self.clickedSubscribe(charge: cell.executiveCharge, subscriptionPlan: 2);break;
            default: break;
            }
        }
        return cell;
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x;
        pageInidcators.currentPage = Int(x/self.view.frame.width);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: self.view.frame.height);
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3;
        
    }
}
