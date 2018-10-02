//
//  MenuNavBar.swift
//  YummyV1
//
//  Created by Brandon In on 3/28/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

protocol MenuNavBarDelegate{
    func handleChangedNavigationSection(section: Int);
}

let navBarMoveLineNotification = "NavBarMoveLine";

//MARK: MenuNavBar
class MenuNavBar: UIView, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    var menuPage: MenuPage?
    
    var menuNavBarDelegate: MenuNavBarDelegate?;
    
    let reuseIdentifier = "one";
    
    lazy var mainView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout();
        flowLayout.estimatedItemSize = CGSize(width: frame.width/3, height: 40);
        let mainView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout);
        mainView.register(MenuNavBarCell.self, forCellWithReuseIdentifier: reuseIdentifier);
        mainView.translatesAutoresizingMaskIntoConstraints = false;
        mainView.backgroundColor = UIColor.white;
        return mainView;
    }()
    
    var line: UIView = {
        let line = UIView();
        line.translatesAutoresizingMaskIntoConstraints = false;
        line.backgroundColor = UIColor.black;
        return line;
    }()
    var lineLeftAnchor: NSLayoutConstraint!;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.red
        setupObservers();
        setupCollectionView();
        setupBottomBorder();
        setupLine();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self);
    }
    
    fileprivate func setupObservers(){
        let name = Notification.Name(rawValue: navBarMoveLineNotification);
        NotificationCenter.default.addObserver(self, selector: #selector(self.moveLineNotification(notification:)), name: name, object: nil);
    }
    
    fileprivate func setupCollectionView(){
        mainView.dataSource = self;
        mainView.delegate = self;
        
        let inset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: -5);
        mainView.contentInset = inset;
        
        self.addSubview(mainView);
        mainView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        mainView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true;
        mainView.heightAnchor.constraint(equalToConstant: 40).isActive = true;
    }
    
    fileprivate func setupBottomBorder(){
        let bottomBorder = CALayer();
        let width = CGFloat(0.25);
        bottomBorder.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.width, height: self.frame.size.height);
        bottomBorder.borderWidth = width;
        self.layer.addSublayer(bottomBorder);
        self.layer.masksToBounds = true;
    }
    
    func setupLine(){
        
        //MARK: setUp line view
        self.addSubview(line);
        lineLeftAnchor = line.leftAnchor.constraint(equalTo: self.leftAnchor);
        lineLeftAnchor.isActive = true;
        line.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        line.heightAnchor.constraint(equalToConstant: 2).isActive = true;
        line.widthAnchor.constraint(equalToConstant: self.frame.size.width/3).isActive = true;
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        moveLine(item: indexPath.item);
        
        //reload the main collectionView
        if let delegate = self.menuNavBarDelegate{
            delegate.handleChangedNavigationSection(section: indexPath.item);
        }
    }
    
    func moveLine(item: Int){
        let newX = CGFloat(item) * self.frame.width/3;
        self.lineLeftAnchor.constant = newX;
        //if pageNum = 1;
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded();
        }
    }
    
    @objc func moveLineNotification(notification: NSNotification){
        let item = 1;
        let newX = CGFloat(item) * self.frame.width/3;
        self.lineLeftAnchor.constant = newX;
        //if pageNum = 1;
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded();
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = mainView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MenuNavBarCell
        if(indexPath.item == 0){
            cell.setImage(name: "document");
            cell.setText(name: "Sections");
        }else if(indexPath.item == 1){
            cell.setImage(name: "menu");
            cell.setText(name: "Full Menu");
        }else if(indexPath.item == 2){
            cell.setImage(name: "contact");
            cell.setText(name: "Info");
        }
        return cell;
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
}
