//
//  SideBar.swift
//  YummyV1
//
//  Created by Brandon In on 6/19/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class MenuSideBar: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    var menuPage: MenuPage?;
    
    lazy var backgroundView: UIView = {
        let backgroundView = UIView();
        backgroundView.translatesAutoresizingMaskIntoConstraints = false;
        backgroundView.backgroundColor = UIColor.gray;
        backgroundView.alpha = 0;
        return backgroundView;
    }()
    
    lazy var sideBarView: UIView = {
        let sideBarView = UIView();
        sideBarView.translatesAutoresizingMaskIntoConstraints = false;
        sideBarView.backgroundColor = UIColor.black;
        return sideBarView;
    }()
    
    lazy var sectionTitlesDescription: UILabel = {
        let sectionTitleDescription = UILabel();
        sectionTitleDescription.translatesAutoresizingMaskIntoConstraints = false;
        sectionTitleDescription.text = "Sections:";
        sectionTitleDescription.textAlignment = .center;
        sectionTitleDescription.font = UIFont.montserratSemiBold(fontSize: 16);
        sectionTitleDescription.textColor = UIColor.white;
        sectionTitleDescription.minimumScaleFactor = 0.1;
        sectionTitleDescription.adjustsFontSizeToFitWidth = true;
        sectionTitleDescription.numberOfLines = 1;
        return sectionTitleDescription;
    }()
    
    var sectionTitlesList: UICollectionView!
    
    //DATA Elements
    var sectionItems: [SectionItem]!
    var reuseOne = "SectionTitles";
    
    init(sectionItems: [SectionItem]){
        super.init(frame: .zero);
        self.sectionItems = sectionItems;
        setup();
    }
    
    private func setup(){
        self.backgroundColor = UIColor.red;
        self.addSubview(sideBarView);
        sideBarView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        sideBarView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        sideBarView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        sideBarView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        
        self.sideBarView.addSubview(sectionTitlesDescription);
        sectionTitlesDescription.leftAnchor.constraint(equalTo: self.sideBarView.leftAnchor).isActive = true;
        sectionTitlesDescription.rightAnchor.constraint(equalTo: self.sideBarView.rightAnchor).isActive = true;
        sectionTitlesDescription.topAnchor.constraint(equalTo: self.sideBarView.topAnchor, constant: 20).isActive = true;
        sectionTitlesDescription.heightAnchor.constraint(equalToConstant: 30).isActive = true;
        
        let layout = UICollectionViewFlowLayout();
        sectionTitlesList = UICollectionView(frame: .zero, collectionViewLayout: layout);
        sectionTitlesList.translatesAutoresizingMaskIntoConstraints = false;
        sectionTitlesList.register(SectionTitlesCell.self, forCellWithReuseIdentifier: reuseOne);
        sectionTitlesList.dataSource = self;
        sectionTitlesList.delegate = self;
//        sectionTitlesList.alwaysBounceVertical = false;
        sectionTitlesList.backgroundColor = UIColor.black;
        
        self.sideBarView.addSubview(sectionTitlesList);
        sectionTitlesList.leftAnchor.constraint(equalTo: self.sideBarView.leftAnchor).isActive = true;
        sectionTitlesList.rightAnchor.constraint(equalTo: self.sideBarView.rightAnchor).isActive = true;
        sectionTitlesList.topAnchor.constraint(equalTo: sectionTitlesDescription.bottomAnchor).isActive = true;
//        sectionTitlesList.heightAnchor.constraint(equalToConstant: 200).isActive = true;
        sectionTitlesList.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        
        print("sectionItems:\(sectionItems.count)")
        for title in sectionItems{
            print("titles:\(title.sectionTitle!)");
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseOne, for: indexPath) as! SectionTitlesCell;
        let sectionTitle = self.sectionItems[indexPath.item];
        cell.setSectionTitle(sectionTitle: sectionTitle.sectionTitle!);
        return cell;
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sectionItems.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: 50);
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = sectionItems[indexPath.item];
        let sectionNumber = section.sectionNumber!;
        //mainPage reload table with sectionTitles
        pageNum = 1;
        self.menuPage?.navBar.moveLine(item: 0);
        self.menuPage?.currentSection = sectionNumber-1;
        self.menuPage?.collectionView.reloadData();
        self.menuPage?.sideBarAnimate();
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
}
