//
//  ProfilePage.swift
//  YummyV1
//
//  Created by Brandon In on 11/21/17.
//  Copyright © 2017 Rendered Co.RaftPod. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ProfilePage: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var customTabBar: CustomTabBarController?
    
    private let reuseCell = "yes";
    private let imageNames = ["profile","phone","home","creditCard","document","orderPolicy","exclamation","specialOffer","logout"];
    var tableView: UITableView!;
    
    var userID: String?
    var firstName: String?
    var lastName: String?
    var email: String?
    var telephone: String?
    
    override func viewDidLoad() {
        setup();
        self.view.backgroundColor = UIColor.gray;
        self.tableView.register(ProfileCell.self, forCellReuseIdentifier: reuseCell)
    }
    
    func setup(){
        tableView = UITableView();
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor = UIColor.veryLightGray;
        tableView.translatesAutoresizingMaskIntoConstraints = false;
        tableView.isScrollEnabled = true;
        tableView.sectionFooterHeight = 20;
//        tableView.sectionHeaderHeight = 20;
        self.view.addSubview(tableView);
        //need x,y,width,and height
        tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true;
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if(indexPath.section == 0){
            switch(indexPath.item){
            case 0:
                toRename();
                break;
            case 1:
                toRename();
                break;
            case 2:
                toTelephone();
                break;
            case 3:
                toEmail();
                break;
            case 4:
                toAddress();
                break;
            case 5:
                toPayments();
                break;
            case 6:
                toPasswordPage1();
                break;
            default: break;
            }
        }else if(indexPath.section == 1){
            switch(indexPath.item){
            case 0:
                toTos();
                break;
            case 1:
                toPrivacy();
                break;
            case 2:
                toProblem();
                break;
            case 3:
                toSubscriptionPage();
                break;
            default: break;
            }
        }else if(indexPath.section == 2){
            self.logout();
        }
        
        tableView.deselectRow(at: indexPath, animated: true);
    }
    
    //MARK: toDifferent VCs
    private func toRename(){
        let rename = RenamePage();
        rename.hidesBottomBarWhenPushed = true;
        self.navigationController!.pushViewController(rename, animated: true);
    }
    private func toTelephone(){
        let phonePage = TelephonePage();
        phonePage.hidesBottomBarWhenPushed = true;
        self.navigationController!.pushViewController(phonePage, animated: true);
    }
    private func toEmail(){
        let email = EmailPage();
        email.hidesBottomBarWhenPushed = true;
        self.navigationController!.pushViewController(email, animated: true);
    }
    private func toAddress(){
        let addressPage = SelectAddress();
        addressPage.profilePage = self;
        addressPage.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(addressPage, animated: true);
    }
    private func toPayments(){
        let selectPayment = SelectPaymentPage();
        selectPayment.fromProfilePage = true;
        selectPayment.hidesBottomBarWhenPushed = true;
        self.navigationController!.pushViewController(selectPayment, animated: true);
    }
    private func toTos(){
        let termsOfService = TosPage();
        termsOfService.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(termsOfService, animated: true);
    }
    private func toPrivacy(){
        let privacy = PrivacyPage();
        privacy.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(privacy, animated: true);
    }
    private func toProblem(){
        let problem = ReportProblem();
        problem.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(problem, animated: true);
    }
    private func toPasswordPage1(){
        let page = ChangePasswordPage1();
        page.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(page, animated: true);
    }
    
    private func  toSubscriptionPage(){
        let subscriptionPage = ProfileSubscriptionPage();
        self.navigationController?.pushViewController(subscriptionPage, animated: true);
    }
    
    private func logout(){
        let alert = UIAlertController(title: "Logout?", message: "Are you sure you want to logout?", preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (re) in
            //remove defaults
            removeDefaults(defaults: defaults);
            self.userID = nil;
            //remove everything from core Data
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
                return;
            }
            
            let context = appDelegate.persistentContainer.viewContext;
            let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Address");
            let fetchOrders = NSFetchRequest<NSFetchRequestResult>(entityName: "Order");
            let fetchCards = NSFetchRequest<NSFetchRequestResult>(entityName: "Card");
            let request = NSBatchDeleteRequest(fetchRequest: fetch);
            let requestOrder = NSBatchDeleteRequest(fetchRequest: fetchOrders);
            let requestCards = NSBatchDeleteRequest(fetchRequest: fetchCards);
            
            do{
                try context.execute(request);
                try context.execute(requestOrder);
                try context.execute(requestCards);
                try context.save();
            }catch{
                print("Error");
            }
            
            if let orderPage = self.customTabBar?.orderPage{
                orderPage.pastOrders?.removeAll();
                orderPage.collectionView?.reloadData();
            }
            
            user = nil;
            removeDefaults(defaults: defaults);
            
//            addresses.removeAll();
//            cCards.removeAll();
            addresses.removeAll();
            orders.removeAll();
            cCards.removeAll();
            
            //goBack to startup page
            let profileLoginPage = ProfileLogin();
            profileLoginPage.customTabController = self.tabBarController! as? CustomTabBarController;
            let navigationController = UINavigationController(rootViewController: profileLoginPage);
            navigationController.navigationBar.barTintColor = UIColor.black;
            navigationController.navigationBar.isTranslucent = false;
            self.present(navigationController, animated: true, completion: nil);
        }))
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil));
        self.present(alert, animated: true, completion: nil);
    }
    
    //MARK: TableView Functions
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: reuseCell, for: indexPath) as! ProfileCell;
        
        if(indexPath.section == 0){
        
            switch(indexPath.item){
                
            case 0:
                cell.setTitle(string: "First Name: \(user!.firstName!)");
                cell.setImage(name: imageNames[0]);
                break;
            case 1: cell.setTitle(string: "Last Name: \(user!.lastName!)");
                cell.setImage(name: imageNames[0]);
                break;
            case 2: cell.setTitle(string: "Phone Number: \(user!.telephone!)");
                cell.setImage(name: imageNames[1]);
                break;
            case 3:
                cell.setTitle(string: "Email: \(user!.email!)");
                cell.setImage(name: "email");
                break;
            case 4: cell.setTitle(string: "Addresses");
                cell.setImage(name: imageNames[2]);
                break;
            case 5: cell.setTitle(string: "Credit Card");
                cell.setImage(name: imageNames[3]);
                break;
            case 6:
                cell.setTitle(string: "Password");
                cell.setImage(name: "password");
                break;
            default: cell.setTitle(string: "Payments");break;
                
            }
        }else if(indexPath.section == 1){
            switch(indexPath.item){
            case 0: cell.setTitle(string: "Terms and Conditions");
            cell.setImage(name: imageNames[4]);
            break;
            case 1: cell.setTitle(string: "Privacy Policy");
            cell.setImage(name: imageNames[4]);
            break;
            case 2: cell.setTitle(string: "Report a Problem");
            cell.setImage(name: imageNames[6]);
            break;
            case 3: cell.setTitle(string: "Subscription");
            cell.setImage(name: imageNames[7]);
            break;
            default: break;
            }
        }else{
            cell.setTitle(string: "Logout");
            cell.setImage(name: imageNames[8]);
        }
        return cell;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return 7;
        }else if(section == 1){
            return 4;
        }else{
            return 1;
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50;
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20;
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20;
    }
    
    //MARK: ProfileCell
    private class ProfileCell: UITableViewCell{
        
        var titleImage: UIImageView!;
        var title: UILabel!;
        
        override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier);
            self.backgroundColor = UIColor.white
            titleImage = UIImageView();
            //        titleImage.frame = CGRect(x: 10, y: 10, width: 20, height: 20);
            titleImage.translatesAutoresizingMaskIntoConstraints = false;
            titleImage.image = UIImage(named: "shrimpRice");
            self.addSubview(titleImage);
            //need x,y,width,and height
            titleImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true;
            titleImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
            titleImage.widthAnchor.constraint(equalToConstant: 20).isActive = true;
            titleImage.heightAnchor.constraint(equalToConstant: 20).isActive = true;
            
            title = UILabel();
            title.translatesAutoresizingMaskIntoConstraints = false;
            self.addSubview(title);
            title.text = "This is where the tile goes";
            title.font = UIFont(name: "Montserrat-Regular", size: 12);
            //need x,y,width,and height
            title.leftAnchor.constraint(equalTo: titleImage.rightAnchor, constant: 20).isActive = true;
            title.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
            title.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
            title.heightAnchor.constraint(equalToConstant: 30).isActive = true;
            
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError();
        }
        
        func setTitle(string: String!){
            self.title.text = string;
        }
        
        func setImage(name: String){
            self.titleImage.image = UIImage(named: name);
        }
    }


    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData();
    }
}


