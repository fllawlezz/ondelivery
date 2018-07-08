//
//  GlobalVariables.swift
//  YummyV1
//
//  Created by Brandon In on 7/6/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import Foundation
import CoreData

//MARK: Global Elements
var addresses = [NSManagedObject]();//address list to populate
var orders = [NSManagedObject]();//order list to populate page
var cCards = [NSManagedObject]();//cards list to populate cards

var userLongtiude: String!;
var userLatitude: String!;
var userCurrentCity: String!;

var urlData: Data!;

var user: User?
