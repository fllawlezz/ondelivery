//
//  CustomTabBarController.swift
//  YummyV1
//
//  Created by Brandon In on 11/16/17.
//  Copyright © 2017 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController, UITabBarControllerDelegate{
    var mainPage: HomePage!
    var recomendedMainPage: RecomendedMainPage!;
    var profilePage: ProfilePage!;
    var orderPage: OrderPage!;
    
    var userID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.isTranslucent = false;
        self.delegate = self;
        
        mainPage = HomePage();
        let navigationController = UINavigationController(rootViewController: mainPage);
        navigationController.title = "Home";
        navigationController.tabBarItem.image = UIImage(named: "home");
        navigationController.navigationBar.topItem?.title = "OnDelivery";
        navigationController.navigationBar.isTranslucent = false;
        navigationController.navigationBar.tintColor = UIColor.white;
        navigationController.navigationBar.barTintColor = UIColor.black;
        let leftBackButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil);
        navigationController.navigationBar.topItem?.backBarButtonItem = leftBackButton;
        navigationController.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white, NSAttributedStringKey.font : UIFont(name: "Montserrat-Bold", size: 20) ?? UIFont.boldSystemFont(ofSize: 20)];
        
        recomendedMainPage = RecomendedMainPage();
        let navigationController1 = UINavigationController(rootViewController: recomendedMainPage);
        navigationController1.title = "Recomended";
        navigationController1.tabBarItem.image = UIImage(named: "thumbsUp");
        navigationController1.navigationBar.topItem?.title = "Recomended";
        navigationController1.navigationBar.isTranslucent = false;
        navigationController1.navigationBar.backgroundColor = UIColor.black;
        navigationController1.navigationBar.barTintColor = UIColor.black;
        navigationController1.navigationBar.tintColor = UIColor.white;
        navigationController1.navigationBar.topItem?.backBarButtonItem = leftBackButton;
        navigationController1.navigationBar.titleTextAttributes = [NSAttributedStringKey.font : UIFont(name: "Montserrat-Bold", size: 20) ?? UIFont.boldSystemFont(ofSize: 20), NSAttributedStringKey.foregroundColor : UIColor.white]
        
        let layout = UICollectionViewFlowLayout();
        layout.itemSize = CGSize(width: self.view.frame.width, height: 150);
        layout.minimumLineSpacing = 5;
        layout.minimumInteritemSpacing = 5;
        
        orderPage = OrderPage(collectionViewLayout: layout);
        let navigationController2 = UINavigationController(rootViewController: orderPage);
        navigationController2.title = "Orders";
        navigationController2.tabBarItem.image = UIImage(named: "history");
        navigationController2.navigationBar.topItem?.title = "Order History";
        navigationController2.navigationBar.topItem?.backBarButtonItem = leftBackButton;
        navigationController2.navigationBar.isTranslucent = false;
        navigationController2.navigationBar.backgroundColor = UIColor.black;
        navigationController2.navigationBar.barTintColor = UIColor.black;
        navigationController2.navigationBar.tintColor = UIColor.white;
        navigationController2.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white, NSAttributedStringKey.font : UIFont(name: "Montserrat-Bold", size: 20) ?? UIFont.boldSystemFont(ofSize: 20)];
        
        profilePage = ProfilePage();
        var navigationController3: UINavigationController!;
        navigationController3 = UINavigationController(rootViewController: profilePage);
        navigationController3.title = "Profile";
        navigationController3.tabBarItem.image = UIImage(named: "profile");
        navigationController3.navigationBar.topItem?.title = "Profile";
        navigationController3.navigationBar.isTranslucent = false;
        navigationController3.navigationBar.topItem?.backBarButtonItem = leftBackButton;
        navigationController3.navigationBar.backgroundColor = UIColor.black;
        navigationController3.navigationBar.barTintColor = UIColor.black;
        navigationController3.navigationBar.tintColor = UIColor.white;
        navigationController3.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white, NSAttributedStringKey.font : UIFont(name: "Montserrat-Bold", size: 20) ?? UIFont.boldSystemFont(ofSize: 20)];
        
        viewControllers = [navigationController, navigationController2, navigationController3];
        // Do any additional setup after loading the view.
    }
    
    func clear(){
        print("home");
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        if(item == self.viewControllers![2]){
//            let profileCellView = ProfileLogin();
//            self.present(profileCellView, animated: true, completion: nil);
//        }
//    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if(viewController == self.viewControllers![2] || viewController == self.viewControllers![1]){
            if(user == nil){
                let profileLogin = ProfileLogin();
                profileLogin.customTabController = self;
                let navigationController = UINavigationController(rootViewController: profileLogin);
                navigationController.navigationBar.barTintColor = UIColor.black;
                navigationController.navigationBar.isTranslucent = false;
//                let profileCellView = ProfileLogin();
                self.present(navigationController, animated: true, completion: nil);
//                self.selectedIndex = 3;
//                print("profile view selected");
                return false;
            }
            print("profile page");
        }else if(viewController == self.viewControllers![0]){
            print("homePage");
        }
        
        return true;
    }

}
