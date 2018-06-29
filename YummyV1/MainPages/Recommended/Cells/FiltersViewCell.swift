//
//  FiltersViewCell.swift
//  YummyV1
//
//  Created by Brandon In on 4/4/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit


class FiltersViewCell: UICollectionViewCell{
    var filterButton: UIButton!;
    var tableView: UITableView!;
    let reuse = "one";
    var cellNum = 0;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.black;
        setup();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    private func setup(){
        filterButton = UIButton(type: .system);
        filterButton.translatesAutoresizingMaskIntoConstraints = false;
        filterButton.backgroundColor = UIColor.black;
        filterButton.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 18);
        filterButton.setTitleColor(UIColor.white, for: .normal);
        self.addSubview(filterButton);
        //need x,y,width,and height
        filterButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        filterButton.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        filterButton.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        filterButton.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true;
        self.bringSubview(toFront: filterButton);
        
    }
    
    func setNum(index: Int){
        self.cellNum = index;
    }
    
}
