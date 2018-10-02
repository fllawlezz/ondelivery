//
//  MenuPopUp.swift
//  YummyV1
//
//  Created by Brandon In on 3/28/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

protocol MenuPopUpDelegate{
    func updateItemArray();
}

//MARK: PopUp menu
class MenuPopUp: UIView, UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    let reuseIdentifier = "one";
    var menuPopUpDelegate: MenuPopUpDelegate?
    
    var itemArray: [MainItem]?
    
    //DATA Variables
    var totalPrice: Double?
    
    //MARK: Variables
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout();
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout);
        collectionView.translatesAutoresizingMaskIntoConstraints = false;
        collectionView.register(PopUpMenuCell.self, forCellWithReuseIdentifier: reuseIdentifier);
        return collectionView;
    }()
    
    lazy var cartTitle: UILabel = {
        let cartTitle = UILabel();
        cartTitle.translatesAutoresizingMaskIntoConstraints = false;
        cartTitle.text = "Your Cart";
        cartTitle.font = UIFont(name: "Montserrat-SemiBold", size: 14);
        cartTitle.textAlignment = .right
        return cartTitle;
    }()
    
    lazy var noItemsTitle: UILabel = {
        let noItemsTitle = UILabel();
        noItemsTitle.translatesAutoresizingMaskIntoConstraints = false;
        noItemsTitle.text = "You have no items, Add some :)";
        noItemsTitle.font = UIFont(name: "Montserrat-Regular", size: 20);
        noItemsTitle.textAlignment = .center;
        return noItemsTitle;
    }()
    
    var numberOfItems = 0;//set numberOfItems to equal menuItemArray.count
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        addObservers();
        setupCartTitle();
        setupCollectionView();
        setupNoItemsLabel();
        
        collectionView.isHidden = true;
        
        if let itemArray = self.itemArray{
            if (itemArray.count > 0){
                //set the amount of items, else leave alone
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self);
    }
    
    fileprivate func addObservers(){
        let name = Notification.Name(rawValue: addedMenuItemNotification);
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleAddItem(notification:)), name: name, object: nil);
        
        let removeName = Notification.Name(rawValue: removeMenuItemNotification);
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleRemoveItem(notification:)), name: removeName, object: nil);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupCollectionView(){
        collectionView.delegate = self;
        collectionView.dataSource = self;
        self.addSubview(collectionView);
        collectionView.backgroundColor = UIColor.white;
        //need x,y,width,height constraints
        collectionView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;//x
        collectionView.topAnchor.constraint(equalTo: self.cartTitle.bottomAnchor, constant: 5).isActive = true;//y
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;//height
        collectionView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;//width
    }
    
    fileprivate func setupCartTitle(){
        self.addSubview(cartTitle);
        //need x,y,width,height constraints
        cartTitle.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true;//x
        cartTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true;//y
        cartTitle.widthAnchor.constraint(equalToConstant: 100).isActive = true;//width
        cartTitle.heightAnchor.constraint(equalToConstant: 25).isActive = true;
    }
    
    fileprivate func setupNoItemsLabel(){
        self.addSubview(noItemsTitle);
        //need x,y,width,height
        noItemsTitle.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        noItemsTitle.topAnchor.constraint(equalTo: self.cartTitle.bottomAnchor).isActive = true;
        noItemsTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        noItemsTitle.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PopUpMenuCell;
        cell.menuPopup = self;
        if let itemArray = self.itemArray{
            if(indexPath.item == itemArray.count-1){
                cell.border.isHidden = true;
            }else{
                cell.border.isHidden = false;
            }
            
            if itemArray.count > 0{
                let menuItem = itemArray[indexPath.item];//get the first menuItem
                cell.setName(name: menuItem.name);
                cell.foodID = Int(menuItem.id)
                cell.hasOptions = menuItem.hasOptions;
                cell.setQuantity(quantity: menuItem.quantity);
                cell.setPrice(price: menuItem.itemPrice!);
            }
            
        }
        
        //set up the names

        return cell;
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 1;
        if itemArray != nil{
            return itemArray!.count
        }else{
            return 1;
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: 60);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
}

extension MenuPopUp{
    @objc func handleAddItem(notification: NSNotification){
        if let delegate = self.menuPopUpDelegate{
//            print("added to popUP MEnu");
            delegate.updateItemArray();
            self.collectionView.reloadData();
        }
    }
    
    @objc func handleRemoveItem(notification: NSNotification){
        if let delegate = self.menuPopUpDelegate{
            delegate.updateItemArray();
            self.collectionView.reloadData();
        }
    }
    
    func showCollectionView(){
        self.collectionView.isHidden = false;
        self.noItemsTitle.isHidden = true;
//        print(self.itemArray?.count);
        self.collectionView.reloadData();
    }
    
    func hideCollectionView(){
        self.collectionView.isHidden = true;
        self.noItemsTitle.isHidden = false;
    }
}
