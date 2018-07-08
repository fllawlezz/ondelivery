//
//  GlobalFunctions.swift
//  YummyV1
//
//  Created by Brandon In on 1/22/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import Foundation
import CoreData
import UIKit

//MARK: Filters variables

class Conn{
    func connect(fileName: String, postString: String, completion: @escaping (NSString) -> ()){
//        var selfData: Data!;
        let url: URL = URL(string: "https://onDeliveryinc.com/\(fileName)")!;
        var request:URLRequest = URLRequest(url: url);
        request.httpMethod = "POST";
        request.httpBody = postString.data(using: String.Encoding.utf8);
        let task = URLSession.shared.dataTask(with: request){
            data,response,error in
            if data != nil{
                urlData = data;
                let re = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!;
                completion(re);
            }
        }
        task.resume();
//        return selfData;
    }
}

//MARK: Functions
func saveDefaults(defaults: UserDefaults!, firstName: String!, lastName: String!, email: String!, phoneNumber: String!, password: String!){
    defaults.set(firstName, forKey: "firstName");
    defaults.set(lastName, forKey: "lastName");
    defaults.set(password, forKey: "password");
    defaults.set(email, forKey: "email");
    defaults.set(phoneNumber, forKey: "telephone");
//    defaults.set(userID, forKey: "userID");
}

func saveSubscription(defaults: UserDefaults!, subscriptionPlan: String!, freeOrders: Int){
    defaults.set(subscriptionPlan, forKey: "subscriptionPlan");
    defaults.set(freeOrders, forKey: "freeOrders");
}

func removeDefaults(defaults: UserDefaults!){
    defaults.removeObject(forKey: "firstName");
    defaults.removeObject(forKey: "lastName");
    defaults.removeObject(forKey: "password");
    defaults.removeObject(forKey: "email");
    defaults.removeObject(forKey: "telephone");
    defaults.removeObject(forKey: "userID");
    defaults.removeObject(forKey: "subscriptionPlan");
    defaults.removeObject(forKey: "freeOrders");
}

//func populateDefaults(defaults: UserDefaults!, firstName: String, lastName: String, password: String, email: String, telephone: String, userID: String, subPlan: String, freeOrders: Int){
//    firstName = defaults.object(forKey: "firstName") as! String!;
//    lastName = defaults.object(forKey: "lastName") as! String!;
//    password = defaults.object(forKey: "password") as! String!;
//    email = defaults.object(forKey: "email") as! String!;
//    telephone = defaults.object(forKey: "telephone") as! String!;
//    userID = defaults.object(forKey: "userID") as! String!;
//    subPlan = defaults.object(forKey: "subscriptionPlan") as! String;
//    freeOrders = defaults.object(forKey: "freeOrders") as? Int;
//}
