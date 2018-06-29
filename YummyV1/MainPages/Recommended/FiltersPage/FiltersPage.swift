//
//  FiltersPage.swift
//  YummyV1
//
//  Created by Brandon In on 6/28/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class FiltersPage: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    var filtersData: FiltersDataModel!
    
    var applyButton: UIButton = {
        let applyButton = UIButton(type: .system);
        applyButton.translatesAutoresizingMaskIntoConstraints = false;
        applyButton.backgroundColor = UIColor.appYellow;
        applyButton.setTitle("Apply", for: .normal);
        applyButton.titleLabel?.font = UIFont.montserratSemiBold(fontSize: 16);
        applyButton.setTitleColor(UIColor.black, for: .normal);
        applyButton.layer.cornerRadius = 4;
        return applyButton;
    }()
    
    var searchTypeCollectionView: UICollectionView!
    
    //DATA Elements
    let reuseOne = "filtersCell";
    let reuseTwo = "filtersSectionTwo";
    let reuseHeaders = "filtersHeaders";
    let sectionTitles = ["Sort By:","Prices:"];
    let searchTypeTitles = ["Relevance","Price","Distance"];
    let searchTypeInts = [1,2,3];
    
    var selectedSearchType = 0;
    
    override func viewDidLoad() {
        setUpNavBar();
        setup();
    }
    
    fileprivate func setUpNavBar(){
        self.navigationItem.title = "Filters";
    }
    
    fileprivate func setup(){
        
        self.view.backgroundColor = UIColor.white;
        
        let layout = UICollectionViewFlowLayout();
        searchTypeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout);
        searchTypeCollectionView.translatesAutoresizingMaskIntoConstraints = false;
        searchTypeCollectionView.delegate = self;
        searchTypeCollectionView.dataSource = self;
        searchTypeCollectionView.register(FiltersCell.self, forCellWithReuseIdentifier: reuseOne);
        searchTypeCollectionView.register(FiltersSectionTwoCell.self, forCellWithReuseIdentifier: reuseTwo);
        searchTypeCollectionView.register(FiltersHeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: reuseHeaders);
        searchTypeCollectionView.backgroundColor = UIColor.white;
        self.view.addSubview(searchTypeCollectionView);
        searchTypeCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        searchTypeCollectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        searchTypeCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10).isActive = true;
//        searchTypeCollectionView.heightAnchor.constraint(equalToConstant: 120).isActive = true;
        searchTypeCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -50).isActive = true;
        
        self.view.addSubview(applyButton);
        applyButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true;
        applyButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true;
        applyButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -5).isActive = true;
        applyButton.heightAnchor.constraint(equalToConstant: 50).isActive = true;
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(indexPath.section == 0){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseOne, for: indexPath) as! FiltersCell;
            cell.setTitle(title: searchTypeTitles[indexPath.item], cellValue: searchTypeInts[indexPath.item]);
            if(indexPath.item == 2){
                cell.hideBottomBorder();
            }
            return cell;
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseTwo, for: indexPath) as! FiltersSectionTwoCell;
            cell.filtersPage = self;
            return cell;
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(indexPath.section == 0){
            //hide all other cells
            hideAllCheckmarks();
            
            let cell = collectionView.cellForItem(at: indexPath) as! FiltersCell;
            cell.unhideCheckmark();
            selectedSearchType = cell.cellValue!;
            
            //hide all other checkmarks
        }
    }
    
    func hideAllCheckmarks(){
        var count = 0;
        while(count < 3){
            let index = IndexPath(item: count, section: 0);
            let cell = searchTypeCollectionView.cellForItem(at: index) as! FiltersCell;
            cell.hideCheckmark();
            count += 1;
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(section == 0){
            return 3;
        }else{
            return 1;
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(indexPath.section == 0){
            return CGSize(width: self.view.frame.width, height: 50);
        }else{
            return CGSize(width: self.view.frame.width, height: 50);
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 60);
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: reuseHeaders, for: indexPath) as! FiltersHeaderCell;
        header.setTitle(title: sectionTitles[indexPath.section]);
        return header;
    }
    
}
