//
//  FiltersDataModel.swift
//  YummyV1
//
//  Created by Brandon In on 6/28/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//
import Foundation

class FiltersDataModel:NSObject{
    
    var searchFilterType: Int?
    var priceFilters: [Int]?
    
    init(searchFilterType: Int, priceFilters: [Int]){
        self.searchFilterType = searchFilterType;
        self.priceFilters = priceFilters;
    }
    
}
