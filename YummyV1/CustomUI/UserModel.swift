//
//  UserModel.swift
//  YummyV1
//
//  Created by Brandon In on 6/26/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

class User{
    
    var firstName: String?
    var lastName: String?
    var userID: String?
    var email: String?
    var telephone: String?
    var subscriptionPlan: String?
    var freeOrders: Int?
    
    init(firstName: String, lastName: String, userID:String, email:String, telephone: String, subscriptionPlan: String, freeOrders: Int){
        self.firstName = firstName;
        self.lastName = lastName;
        self.userID = userID;
        self.email = email;
        self.telephone = telephone;
        self.subscriptionPlan = subscriptionPlan;
        self.freeOrders = freeOrders;
    }
    
}
