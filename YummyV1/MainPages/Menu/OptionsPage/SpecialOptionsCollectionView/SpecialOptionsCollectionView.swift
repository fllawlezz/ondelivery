//
//  SpecialOptionsCollectionView.swift
//  YummyV1
//
//  Created by Brandon In on 9/17/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class SpecialOptionsCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    let reuseOne = "SpecialOptionsCell";
    let reuseTwo = "SpecialOptionsHeader";
    
    var numOfSections: Int!;
    var selectedIndexPaths = [IndexPath]();
    var specialOptions: [[SpecialOption]]!;
    var selectedOptions = [SpecialOption]();
    var sectionHeaders: [String]!
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout);
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.register(SpecialOptionsCell.self, forCellWithReuseIdentifier: reuseOne);
        self.register(SpecialOptionsHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: reuseTwo);
        self.dataSource = self;
        self.delegate = self;
        self.backgroundColor = UIColor.white;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numOfSections;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let optionArrayCount = self.specialOptions[section].count;
        return optionArrayCount;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: 40);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.frame.width, height: 50);
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: reuseTwo, for: indexPath) as! SpecialOptionsHeader;
        header.setTitle(title: sectionHeaders[indexPath.section]);
        return header;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseOne, for: indexPath) as! SpecialOptionsCell;
        let option = specialOptions[indexPath.section];
        let specialOption = option[indexPath.item];
        
        cell.setPrice(price: 0);
        
        cell.setTitle(title: specialOption.specialOptionName);
        if(specialOption.specialOptionPrice > 0){
            cell.setPrice(price: specialOption.specialOptionPrice);
        }
        
        cell.hideCheckmark();
        
        for selectedIndexPath in self.selectedIndexPaths{
            if(selectedIndexPath == indexPath){
                cell.unhideCheckmark();
            }
        }
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! SpecialOptionsCell
        //add the option to the menu
        hideAllCheckMarks(section: indexPath.section);
        //append selected option
        self.selectedIndexPaths.append(indexPath);
        cell.unhideCheckmark();
    }
    
    fileprivate func hideAllCheckMarks(section: Int){
        var count = 0;
        
        let numItemsInSection = specialOptions![section].count;
        while(count < numItemsInSection){
            let indexPath = IndexPath(item: count, section: section);
            if let cell = self.cellForItem(at: indexPath) as? SpecialOptionsCell{
                cell.hideCheckmark();
            }
            count += 1;
        }
        removeIndexPath(section: section);
    }
    
    func removeIndexPath(section: Int){
        var count = 0;
        while(count<self.selectedIndexPaths.count){
            let selectedIndex = self.selectedIndexPaths[count];
            if(selectedIndex.section == section){
                self.selectedIndexPaths.remove(at: count);
                return;
            }
            count+=1;
        }
    }
    
}
