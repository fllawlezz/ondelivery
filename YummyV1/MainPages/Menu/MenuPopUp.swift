//
//  MenuPopUp.swift
//  YummyV1
//
//  Created by Brandon In on 3/28/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

//MARK: PopUp menu
class MenuPopUp: UIView, UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    var menuPage: MenuPage?;
    
    //DATA Variables
    var totalPrice: Double?
    
    //MARK: Variables
    var collectionView: UICollectionView!;
    var noItems: UILabel!;
    var botBarReference: MenuBottomBar!;
    var menuReference: UICollectionView!;
    
    var numberOfItems = 0;//set numberOfItems to equal menuItemArray.count
    let reuseIdentifier = "one";
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        setup();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
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
    
    private func setup(){
        self.addSubview(cartTitle);
        //need x,y,width,height constraints
        cartTitle.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true;//x
        cartTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true;//y
        cartTitle.widthAnchor.constraint(equalToConstant: 100).isActive = true;//width
        cartTitle.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        
        self.addSubview(noItemsTitle);
        //need x,y,width,height
        noItemsTitle.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        noItemsTitle.topAnchor.constraint(equalTo: self.cartTitle.bottomAnchor).isActive = true;
        noItemsTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        noItemsTitle.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        
        let layout = UICollectionViewFlowLayout();
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout);
        collectionView.translatesAutoresizingMaskIntoConstraints = false;
        collectionView.register(PopUpMenuCell.self, forCellWithReuseIdentifier: reuseIdentifier);
        collectionView.delegate = self;
        collectionView.dataSource = self;
        self.addSubview(collectionView);
        collectionView.backgroundColor = UIColor.white;
        //need x,y,width,height constraints
        collectionView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;//x
        collectionView.topAnchor.constraint(equalTo: self.cartTitle.bottomAnchor, constant: 5).isActive = true;//y
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;//height
        collectionView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;//width
        
        if(menuPage?.menuItemArray.count == 0){
            collectionView.isHidden = true;
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PopUpMenuCell;
        cell.menuPopup = self;
        if(indexPath.item == menuPage!.menuItemArray.count-1){
            cell.border.isHidden = true;
        }else{
            cell.border.isHidden = false;
        }
        
        //set up the names
        let menuItem = menuPage!.menuItemArray[indexPath.item];//get the first menuItem
        cell.setName(name: menuItem.name);
        cell.setQuantity(quantity: menuItem.quantity);
        return cell;
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuPage!.menuItemArray.count;
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
