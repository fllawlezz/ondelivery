//
//  TrackingPage.swift
//  YummyV1
//
//  Created by Brandon In on 12/8/17.
//  Copyright © 2017 Rendered Co.RaftPod. All rights reserved.
//

import Foundation
import UIKit

class TrackingPage: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    let identifier = "one";
    private var trackingBar: TrackingNavigationBar!;
    var phoneButton: UIButton!;
    
    override func viewDidLoad() {
        collectionView?.register(TrackingCell.self, forCellWithReuseIdentifier: identifier);
        self.collectionView?.backgroundColor = UIColor.white;
        setup();
        navigationItem.title = "Your Order"
    }
    
    func setup(){
        //insets
        let inset = UIEdgeInsets(top: 60, left: 0, bottom: 0, right: 0);
        //        let scrollInset = UI
        self.collectionView?.contentInset = inset;
        self.collectionView?.scrollIndicatorInsets = inset;
        
        trackingBar = TrackingNavigationBar(width: self.view.frame.size.width);
        trackingBar.translatesAutoresizingMaskIntoConstraints = false;
        trackingBar.backgroundColor = UIColor.blue;
        self.collectionView?.addSubview(trackingBar);
        //need x,y,width,and height constraints
        trackingBar.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        trackingBar.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true;
        trackingBar.widthAnchor.constraint(equalToConstant: self.view.frame.width/2).isActive = true;
        trackingBar.heightAnchor.constraint(equalToConstant: 40).isActive = true;
        
        phoneButton = UIButton(type: .system);
        phoneButton.translatesAutoresizingMaskIntoConstraints = false;
        phoneButton.setBackgroundImage(UIImage(named: "phone"), for: .normal);
        self.view.addSubview(phoneButton);
        //need x,y,width,and height constraints
        phoneButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true;
        phoneButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10).isActive = true;
        phoneButton.widthAnchor.constraint(equalToConstant: 20).isActive = true;
        phoneButton.heightAnchor.constraint(equalToConstant: 20).isActive = true;
        
        let bottomBorder = UIView();
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false;
        bottomBorder.backgroundColor = UIColor.lightGray;
        self.view.addSubview(bottomBorder);
        bottomBorder.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        bottomBorder.topAnchor.constraint(equalTo: self.trackingBar.bottomAnchor).isActive = true;
        bottomBorder.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true;
        bottomBorder.heightAnchor.constraint(equalToConstant: 0.5).isActive = true;
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView?.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! TrackingCell
        if(indexPath.item == 5){
            cell.bottomBorder.isHidden = true;
        }else{
            cell.bottomBorder.isHidden = false;
        }
        return cell;
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width, height: 60);
    }
    
    //MARK: TrackingCell
    private class TrackingCell:UICollectionViewCell{
        var bottomBorder: UIView!;
        
        override init(frame: CGRect) {
            super.init(frame: frame);
            setup();
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError();
        }
        
        private func setup(){
            bottomBorder = UIView();
            bottomBorder.backgroundColor = UIColor.lightGray;
            bottomBorder.translatesAutoresizingMaskIntoConstraints = false;
            self.addSubview(bottomBorder);
            //x,y,width,and height
            bottomBorder.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
            bottomBorder.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
            bottomBorder.widthAnchor.constraint(equalToConstant: (self.frame.width*6)/7).isActive = true;
            bottomBorder.heightAnchor.constraint(equalToConstant: 0.25).isActive = true;
        }
        
    }
    
}

//MARK: TrackignNavigationBar
private class TrackingNavigationBar: UIView, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    var collectionView: UICollectionView!;
    let identifier = "one";
    let titles = ["Status","Info"];
    var line: UIView!
    var leftLineAnchor: NSLayoutConstraint!;
    var width:CGFloat!;
    
    init(width: CGFloat){
        self.width = width;
        super.init(frame: CGRect.zero);
        setup();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    private func setup(){
        let layout = UICollectionViewFlowLayout();
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout);
        collectionView.translatesAutoresizingMaskIntoConstraints = false;
        collectionView.backgroundColor = UIColor.white;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.register(TrackingNavigationBarCell.self, forCellWithReuseIdentifier: identifier);
        self.addSubview(collectionView);
        //need x,y,width,height constraints;
        collectionView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        collectionView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true;
        collectionView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true;
        
        line = UIView();
        line.backgroundColor = UIColor.black;
        line.translatesAutoresizingMaskIntoConstraints = false;
        self.addSubview(line);
        //need x,y,width,height
        leftLineAnchor = line.leftAnchor.constraint(equalTo: self.leftAnchor);
        leftLineAnchor.isActive = true;
        line.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        line.widthAnchor.constraint(equalToConstant: self.width/4).isActive = true;
        line.heightAnchor.constraint(equalToConstant: 2).isActive = true;

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let newX = CGFloat(indexPath.item) * self.frame.width/2;
        self.leftLineAnchor.constant = newX;
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded();
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! TrackingNavigationBarCell;
        cell.setText(text: titles[indexPath.item]);
        return cell;
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.size.width/2, height: self.frame.size.height);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    //MARK: TrackingNavigationBarCell
    private class TrackingNavigationBarCell:UICollectionViewCell{
        
        var title:UILabel!;
        
        override init(frame: CGRect) {
            super.init(frame: frame);
            //                self.backgroundColor = UIColor.red;
            setup();
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError();
        }
        
        private func setup(){
            title = UILabel();
            title.translatesAutoresizingMaskIntoConstraints = false;
            title.textAlignment = .center;
            title.text = "This"
            title.font = UIFont(name: "Copperplate", size: 16);
            title.textColor = UIColor.black;
            self.addSubview(title);
            //need x,y,width,height
            //centered within the cell with the width and height filling the entire cell
            title.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true;
            title.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
            title.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true;
            title.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true;
        }
        
        func setText(text:String){
            self.title.text = text;
        }
    }//end of TrackingNaviagtionBarCell
}//end of TrackingNavigationBar




