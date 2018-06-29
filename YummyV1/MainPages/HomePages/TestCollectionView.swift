//
//  TestCollectionView.swift
//  YummyV1
//
//  Created by Brandon In on 11/20/17.
//  Copyright © 2017 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class TestCollectionView: UICollectionViewController {
    
    private let picNames = ["chicken","pumpkinSoup","ramen","risotto","sushi"];
    private let restNames = ["Pasta Pomodoro","Mcdonalds","Chic-Fil-A","Wendy's","Bukeye Grill and Bar","Carl's Jr","Burger King","Taco Bell", "Chipotle","Popeye's Chicken"];
    private let restAddress = ["123 Ocean Street","445 Water Street","3482 27th Ave","224 Regeant Street","556 Earth St","387 King St","589 Del St","667 Devils Street","8 Apt 2 Mission St","444 Unlucky Street"];
    private let restDistance = [2,1,4,4.5,5,3,3,3.8,1.2,0.3];

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        self.navigationController?.isNavigationBarHidden = true;
        // Register cell classes
        self.collectionView!.register(MainPageListCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView?.keyboardDismissMode = .interactive;
        self.collectionView?.backgroundColor = UIColor.red;
        
//        self.collectionView?.register(<#T##cellClass: AnyClass?##AnyClass?#>, forCellWithReuseIdentifier: <#T##String#>)
        self.collectionView?.addSubview(inputContainer);
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let inputContainer: UIView = {
        let containerView = UIView();
        containerView.frame = CGRect(x: 0, y: 0, width: 300, height: 50);
        containerView.backgroundColor = UIColor.blue;
        
        let textField = UITextField();
        textField.placeholder = "Enter text";
        containerView.addSubview(textField);
        textField.frame = CGRect(x: 0, y: 0, width: 300, height: 50);
        containerView.addSubview(textField);
        
        return containerView;
    }()
    
    override var inputAccessoryView: UIView?{
        
        get{
            let containerView = UIView();
            containerView.frame = CGRect(x: 0, y: 0, width: 300, height: 50);
            containerView.backgroundColor = UIColor.blue;
            
            let textField = UITextField();
            textField.placeholder = "Enter text";
            containerView.addSubview(textField);
            textField.frame = CGRect(x: 0, y: 0, width: 300, height: 50);
            containerView.addSubview(textField);
            
            return containerView;
        }
        
//        get{
//            return inputContainer;
//        }
    }
    
//    override func becomeFirstResponder() -> Bool {
//        return true;
//    }
    
    override var canBecomeFirstResponder: Bool{
        get{
            return true;
        }
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 10
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MainPageListCell;
        cell.setImage(imageName: "shrimpRice");
        cell.setNameAndAddress(name: restNames[indexPath.item], address: restAddress[indexPath.item]);
        cell.setPrice(price: 3.99);
        cell.setDistance(dist: restDistance[indexPath.item]);
        // Configure the cell
        return cell
    }
    
    

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
