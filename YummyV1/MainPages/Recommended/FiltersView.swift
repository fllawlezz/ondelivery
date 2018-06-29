//
//  FiltersView.swift
//  YummyV1
//
//  Created by Brandon In on 4/4/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class FiltersView:UIView,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    var recommendedPage: RecomendedMainPage?{
        didSet{
            
        }
    }
    
    var filtersList:UICollectionView!;
    var dropDownView: UIView!;
    var anchors = [NSLayoutConstraint]()
    var indentifier = "one";
    var reuse = "two";
    var menuDownOrUp = false;
    var darkView: UIView!;
    var mainView: UIView!;
    var picker: UIPickerView!;
    var pageDownOrUp = false;
    var mainCollectionView: UICollectionView!;
    
    //MARK: Slider for distancesetup
    var leftSliderLabel: UILabel!;
    var rightSliderLabel: UILabel!;
    var currentValue: UILabel!;
    var sliderTitle: UILabel!;
    var slider: UISlider!;
    
    //MARK: Slider for price
    var priceLeftSliderLabel: UILabel!;
    var priceRightSliderLabel: UILabel!;
    var priceCurrentValue: UILabel!;
    var priceSliderTitle: UILabel!;
    var priceSlider: UISlider!;
    
    //MARK: Slider for ratings
    var ratingsLeftSliderLabel: UILabel!;
    var ratingsRightSliderLabel: UILabel!;
    var ratingsCurrentValue: UILabel!;
    var ratingsSliderTitle: UILabel!;
    var ratingsSlider: UISlider!;
    
    //index
    var index: IndexPath!;
    
    init(darkView: UIView!, dropDownView: UIView!, anchors: NSLayoutConstraint!, mainView: UIView!, collectionView: UICollectionView!) {
        super.init(frame: .zero);
        self.darkView = darkView;
        self.dropDownView = dropDownView;
        self.anchors.append(anchors);
        self.mainView = mainView;
        self.mainCollectionView = collectionView;
        setup();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    private func setup(){
        let layout = UICollectionViewFlowLayout();
        filtersList = UICollectionView(frame: .zero, collectionViewLayout: layout);
        filtersList.backgroundColor = UIColor.black;
        filtersList.delegate = self;
        filtersList.dataSource = self;
        filtersList.translatesAutoresizingMaskIntoConstraints = false;
        filtersList.register(FiltersViewCell.self, forCellWithReuseIdentifier: indentifier);
        self.addSubview(filtersList);
        //need x,y,width,height constraints for UICollectioNView
        filtersList.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;//x
        filtersList.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;//y?
        filtersList.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        filtersList.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true;
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.setAnchor));
        darkView.addGestureRecognizer(gesture);
        darkView.isUserInteractionEnabled = true;
        
        self.bringSubview(toFront: filtersList);
        
        picker = UIPickerView();
        setupSliders();
        setupPriceSlider();
        setupRatingsSlider();
        
    }
    
    private func setupSliders(){
        
        sliderTitle = UILabel();
        sliderTitle.translatesAutoresizingMaskIntoConstraints = false;
        sliderTitle.text = "Distance";
        sliderTitle.font = UIFont(name: "OpenSans-Regular", size: 16);
        sliderTitle.textColor = UIColor.appYellow;
        sliderTitle.textAlignment = .center;
        self.dropDownView.addSubview(sliderTitle);
        sliderTitle.centerXAnchor.constraint(equalTo: self.dropDownView.centerXAnchor).isActive = true;
        let sliderTitleTopAnchor = sliderTitle.topAnchor.constraint(equalTo: self.dropDownView.topAnchor, constant: 00);
        sliderTitleTopAnchor.isActive = true;
        self.anchors.append(sliderTitleTopAnchor);
        sliderTitle.widthAnchor.constraint(equalToConstant: 200).isActive = true;
        sliderTitle.heightAnchor.constraint(equalToConstant: 30).isActive = true;
        
        currentValue = UILabel();
        currentValue.translatesAutoresizingMaskIntoConstraints = false;
        currentValue.text = "1 mile";
        currentValue.textAlignment = .center;
        currentValue.textColor = UIColor.white;
        currentValue.font = UIFont(name: "OpenSans-Regular", size: 16);
        self.dropDownView.addSubview(currentValue);
        currentValue.centerXAnchor.constraint(equalTo: self.dropDownView.centerXAnchor).isActive = true;
        currentValue.topAnchor.constraint(equalTo: self.sliderTitle.bottomAnchor, constant: 5).isActive = true;
        currentValue.widthAnchor.constraint(equalToConstant: 100).isActive = true;
        currentValue.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        
        leftSliderLabel = UILabel();
        leftSliderLabel.translatesAutoresizingMaskIntoConstraints = false;
        leftSliderLabel.text = "1";
        leftSliderLabel.font = UIFont(name: "OpenSans-Regular", size: 18);
        leftSliderLabel.textColor = UIColor.white;
        self.dropDownView.addSubview(leftSliderLabel);
        leftSliderLabel.leftAnchor.constraint(equalTo: self.dropDownView.leftAnchor, constant: 30).isActive = true;
        let leftSlider = leftSliderLabel.topAnchor.constraint(equalTo: self.currentValue.bottomAnchor, constant: -40);//constant 10
        leftSlider.isActive = true;
        anchors.append(leftSlider);
        leftSliderLabel.widthAnchor.constraint(equalToConstant: 30).isActive = true;
        leftSliderLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        
        rightSliderLabel = UILabel();
        rightSliderLabel.translatesAutoresizingMaskIntoConstraints = false;
        rightSliderLabel.text = "5";
        rightSliderLabel.font = UIFont(name: "OpenSans-Regular", size: 18);
        rightSliderLabel.textColor = UIColor.white;
        self.dropDownView.addSubview(rightSliderLabel);
        rightSliderLabel.rightAnchor.constraint(equalTo: self.dropDownView.rightAnchor, constant: -30).isActive = true;
        let rightSlider = rightSliderLabel.topAnchor.constraint(equalTo: currentValue.bottomAnchor, constant: 10)//constant 10
        rightSlider.isActive = true;
        anchors.append(rightSlider);
        rightSliderLabel.widthAnchor.constraint(equalToConstant: 30).isActive = true;
        rightSliderLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        
        slider = UISlider();
        slider.translatesAutoresizingMaskIntoConstraints = false;
        slider.value = 1;
        slider.maximumValue = 5;
        slider.minimumValue = 1;
        slider.transform = CGAffineTransform(scaleX: 0.8, y: 0.8);
        self.dropDownView.addSubview(slider);
        slider.leftAnchor.constraint(equalTo: self.leftSliderLabel.rightAnchor, constant: 5).isActive = true;
        slider.rightAnchor.constraint(equalTo: self.rightSliderLabel.leftAnchor, constant: -5).isActive = true;
        let sliderView = slider.centerYAnchor.constraint(equalTo: leftSliderLabel.centerYAnchor, constant: -70);//constant -50
        sliderView.isActive = true;
        anchors.append(sliderView);
        slider.heightAnchor.constraint(equalToConstant: 20).isActive = true;
        slider.addTarget(self, action: #selector(self.roundDistance), for: .valueChanged);
        
    }
    
    private func setupPriceSlider(){
        priceSliderTitle = UILabel();
        priceSliderTitle.translatesAutoresizingMaskIntoConstraints = false;
        priceSliderTitle.text = "Price";
        priceSliderTitle.font = UIFont(name: "OpenSans-Regular", size: 16);
        priceSliderTitle.textColor = UIColor.appYellow;
        priceSliderTitle.textAlignment = .center;
        self.dropDownView.addSubview(priceSliderTitle);
        priceSliderTitle.centerXAnchor.constraint(equalTo: self.dropDownView.centerXAnchor).isActive = true;
        let sliderTitleTopAnchor = priceSliderTitle.topAnchor.constraint(equalTo: self.slider.bottomAnchor, constant: 00);
        sliderTitleTopAnchor.isActive = true;
        self.anchors.append(sliderTitleTopAnchor);
        priceSliderTitle.widthAnchor.constraint(equalToConstant: 200).isActive = true;
        priceSliderTitle.heightAnchor.constraint(equalToConstant: 30).isActive = true;
        
        priceCurrentValue = UILabel();
        priceCurrentValue.translatesAutoresizingMaskIntoConstraints = false;
        priceCurrentValue.text = "$";
        priceCurrentValue.textAlignment = .center;
        priceCurrentValue.textColor = UIColor.white;
        priceCurrentValue.font = UIFont(name: "OpenSans-Regular", size: 16);
        self.dropDownView.addSubview(priceCurrentValue);
        priceCurrentValue.centerXAnchor.constraint(equalTo: self.dropDownView.centerXAnchor).isActive = true;
        priceCurrentValue.topAnchor.constraint(equalTo: self.priceSliderTitle.bottomAnchor, constant: 5).isActive = true;
        priceCurrentValue.widthAnchor.constraint(equalToConstant: 100).isActive = true;
        priceCurrentValue.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        
        priceLeftSliderLabel = UILabel();
        priceLeftSliderLabel.translatesAutoresizingMaskIntoConstraints = false;
        priceLeftSliderLabel.text = "1";
        priceLeftSliderLabel.font = UIFont(name: "OpenSans-Regular", size: 18);
        priceLeftSliderLabel.textColor = UIColor.white;
        self.dropDownView.addSubview(priceLeftSliderLabel);
        priceLeftSliderLabel.leftAnchor.constraint(equalTo: self.dropDownView.leftAnchor, constant: 30).isActive = true;
        let leftSlider = priceLeftSliderLabel.topAnchor.constraint(equalTo: self.priceCurrentValue.bottomAnchor, constant: 0);//constant 10
        leftSlider.isActive = true;
        anchors.append(leftSlider);
        priceLeftSliderLabel.widthAnchor.constraint(equalToConstant: 30).isActive = true;
        priceLeftSliderLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        
        priceRightSliderLabel = UILabel();
        priceRightSliderLabel.translatesAutoresizingMaskIntoConstraints = false;
        priceRightSliderLabel.text = "5";
        priceRightSliderLabel.font = UIFont(name: "OpenSans-Regular", size: 18);
        priceRightSliderLabel.textColor = UIColor.white;
        self.dropDownView.addSubview(priceRightSliderLabel);
        priceRightSliderLabel.rightAnchor.constraint(equalTo: self.dropDownView.rightAnchor, constant: -30).isActive = true;
        let rightSlider = priceRightSliderLabel.topAnchor.constraint(equalTo: priceCurrentValue.bottomAnchor, constant: 10)//constant 10
        rightSlider.isActive = true;
        anchors.append(rightSlider);
        priceRightSliderLabel.widthAnchor.constraint(equalToConstant: 30).isActive = true;
        priceRightSliderLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        
        priceSlider = UISlider();
        priceSlider.translatesAutoresizingMaskIntoConstraints = false;
        priceSlider.value = 1;
        priceSlider.maximumValue = 5;
        priceSlider.minimumValue = 1;
        priceSlider.transform = CGAffineTransform(scaleX: 0.8, y: 0.8);
        self.dropDownView.addSubview(priceSlider);
        priceSlider.leftAnchor.constraint(equalTo: self.priceLeftSliderLabel.rightAnchor, constant: 5).isActive = true;
        priceSlider.rightAnchor.constraint(equalTo: self.priceRightSliderLabel.leftAnchor, constant: -5).isActive = true;
        let sliderView = priceSlider.centerYAnchor.constraint(equalTo: priceLeftSliderLabel.centerYAnchor, constant: -100);//constant -50
        sliderView.isActive = true;
        anchors.append(sliderView);
        priceSlider.heightAnchor.constraint(equalToConstant: 20).isActive = true;
        priceSlider.addTarget(self, action: #selector(self.roundPrice), for: .valueChanged);
    }
    
    private func setupRatingsSlider(){
        ratingsSliderTitle = UILabel();
        ratingsSliderTitle.translatesAutoresizingMaskIntoConstraints = false;
        ratingsSliderTitle.text = "Ratings";
        ratingsSliderTitle.font = UIFont(name: "OpenSans-Regular", size: 16);
        ratingsSliderTitle.textColor = UIColor.appYellow;
        ratingsSliderTitle.textAlignment = .center;
        self.dropDownView.addSubview(ratingsSliderTitle);
        ratingsSliderTitle.centerXAnchor.constraint(equalTo: self.dropDownView.centerXAnchor).isActive = true;
        let sliderTitleTopAnchor = ratingsSliderTitle.topAnchor.constraint(equalTo: self.priceSlider.bottomAnchor, constant: 00);
        sliderTitleTopAnchor.isActive = true;
        self.anchors.append(sliderTitleTopAnchor);
        ratingsSliderTitle.widthAnchor.constraint(equalToConstant: 200).isActive = true;
        ratingsSliderTitle.heightAnchor.constraint(equalToConstant: 30).isActive = true;
        
        ratingsCurrentValue = UILabel();
        ratingsCurrentValue.translatesAutoresizingMaskIntoConstraints = false;
        ratingsCurrentValue.text = "1 Star";
        ratingsCurrentValue.textAlignment = .center;
        ratingsCurrentValue.textColor = UIColor.white;
        ratingsCurrentValue.font = UIFont(name: "OpenSans-Regular", size: 16);
        self.dropDownView.addSubview(ratingsCurrentValue);
        ratingsCurrentValue.centerXAnchor.constraint(equalTo: self.dropDownView.centerXAnchor).isActive = true;
        ratingsCurrentValue.topAnchor.constraint(equalTo: self.ratingsSliderTitle.bottomAnchor, constant: 5).isActive = true;
        ratingsCurrentValue.widthAnchor.constraint(equalToConstant: 100).isActive = true;
        ratingsCurrentValue.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        
        ratingsLeftSliderLabel = UILabel();
        ratingsLeftSliderLabel.translatesAutoresizingMaskIntoConstraints = false;
        ratingsLeftSliderLabel.text = "1";
        ratingsLeftSliderLabel.font = UIFont(name: "OpenSans-Regular", size: 18);
        ratingsLeftSliderLabel.textColor = UIColor.white;
        self.dropDownView.addSubview(ratingsLeftSliderLabel);
        ratingsLeftSliderLabel.leftAnchor.constraint(equalTo: self.dropDownView.leftAnchor, constant: 30).isActive = true;
        let leftSlider = ratingsLeftSliderLabel.topAnchor.constraint(equalTo: self.ratingsCurrentValue.bottomAnchor, constant: 0);//constant 10
        leftSlider.isActive = true;
        anchors.append(leftSlider);
        ratingsLeftSliderLabel.widthAnchor.constraint(equalToConstant: 30).isActive = true;
        ratingsLeftSliderLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        
        ratingsRightSliderLabel = UILabel();
        ratingsRightSliderLabel.translatesAutoresizingMaskIntoConstraints = false;
        ratingsRightSliderLabel.text = "5";
        ratingsRightSliderLabel.font = UIFont(name: "OpenSans-Regular", size: 18);
        ratingsRightSliderLabel.textColor = UIColor.white;
        self.dropDownView.addSubview(ratingsRightSliderLabel);
        ratingsRightSliderLabel.rightAnchor.constraint(equalTo: self.dropDownView.rightAnchor, constant: -30).isActive = true;
        let rightSlider = ratingsRightSliderLabel.topAnchor.constraint(equalTo: ratingsCurrentValue.bottomAnchor, constant: 10)//constant 10
        rightSlider.isActive = true;
        anchors.append(rightSlider);
        ratingsRightSliderLabel.widthAnchor.constraint(equalToConstant: 30).isActive = true;
        ratingsRightSliderLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        
        ratingsSlider = UISlider();
        ratingsSlider.translatesAutoresizingMaskIntoConstraints = false;
        ratingsSlider.value = 1;
        ratingsSlider.maximumValue = 5;
        ratingsSlider.minimumValue = 1;
        ratingsSlider.transform = CGAffineTransform(scaleX: 0.8, y: 0.8);
        self.dropDownView.addSubview(ratingsSlider);
        ratingsSlider.leftAnchor.constraint(equalTo: self.ratingsLeftSliderLabel.rightAnchor, constant: 5).isActive = true;
        ratingsSlider.rightAnchor.constraint(equalTo: self.ratingsRightSliderLabel.leftAnchor, constant: -5).isActive = true;
        let sliderView = ratingsSlider.centerYAnchor.constraint(equalTo: ratingsLeftSliderLabel.centerYAnchor, constant: -100);//constant -50
        sliderView.isActive = true;
        anchors.append(sliderView);
        ratingsSlider.heightAnchor.constraint(equalToConstant: 20).isActive = true;
        ratingsSlider.addTarget(self, action: #selector(self.roundRating), for: .valueChanged);
    }
    
    @objc private func roundDistance(){
        let sliderData = self.slider.value;
        let sliderInt = Int(sliderData);
        self.currentValue.text = "\(Float(sliderInt)) miles";
        slider.value = Float(sliderInt);
        let indexPath = IndexPath(row: 0, section: 0);
        let cell = filtersList.cellForItem(at: indexPath) as! FiltersViewCell;
        cell.filterButton.setTitle("\(sliderInt) miles", for: .normal);
        distanceSliderValue = "\(sliderInt)";
    }
    
    @objc private func roundPrice(){
        let sliderData = self.priceSlider.value;
        let sliderInt = Int(sliderData);
        priceSlider.value = Float(sliderInt);
        let indexPath = IndexPath(row: 1, section: 0);
        let cell = filtersList.cellForItem(at: indexPath) as! FiltersViewCell;
        switch(sliderInt){
        case 1: cell.filterButton.setTitle("$", for: .normal);
        self.priceCurrentValue.text = "$";
        priceSliderValue = "1";
        break;
        case 2: cell.filterButton.setTitle("$$", for: .normal);
        self.priceCurrentValue.text = "$$";
        priceSliderValue = "2";
        break;
        case 3: cell.filterButton.setTitle("$$$", for: .normal);
        self.priceCurrentValue.text = "$$$";
        priceSliderValue = "3";
        break;
        case 4: cell.filterButton.setTitle("$$$$", for: .normal);
        self.priceCurrentValue.text = "$$$$";
        priceSliderValue = "4";
        break;
        case 5: cell.filterButton.setTitle("$$$$$", for: .normal);
        self.priceCurrentValue.text = "$$$$$";
        priceSliderValue = "5";
        break;
        default: break;
        }
    }
    
    @objc private func roundRating(){
        let sliderData = self.ratingsSlider.value;
        let sliderInt = Int(sliderData);
        ratingsSlider.value = Float(sliderInt);
        let indexPath = IndexPath(row: 2, section: 0);
        let cell = filtersList.cellForItem(at: indexPath) as! FiltersViewCell;
        switch(sliderInt){
        case 1: cell.filterButton.setTitle("1 Star", for: .normal);
        self.ratingsCurrentValue.text = "1 Star";
        ratingsSliderValue = "1";
        break;
        case 2: cell.filterButton.setTitle("2 Stars", for: .normal);
        self.ratingsCurrentValue.text = "2 Stars";
        ratingsSliderValue = "2";
        break;
        case 3: cell.filterButton.setTitle("3 Stars", for: .normal);
        self.ratingsCurrentValue.text = "3 Stars";
        ratingsSliderValue = "3";
        break;
        case 4: cell.filterButton.setTitle("4 Stars", for: .normal);
        self.ratingsCurrentValue.text = "4 Stars";
        ratingsSliderValue = "4";
        break;
        case 5: cell.filterButton.setTitle("5 Stars", for: .normal);
        self.ratingsCurrentValue.text = "5 Stars";
        ratingsSliderValue = "5";
        break;
        default: break;
        }
    }
    
    
    @objc func setAnchor(){
        self.removeAllFromRestaurantArrays();
        UIView.animate(withDuration: 0.3) {
            self.darkView.alpha = 0;
            self.anchors[0].constant = 0; //dropDownView
            
            self.anchors[1].constant = 0;//sliderTitle
            self.anchors[2].constant = -40;//leftLabel
            self.anchors[3].constant = 0;//rightLabel
            self.anchors[4].constant = -70;//slider view
            //price
            self.anchors[5].constant = 0;
            self.anchors[6].constant = 0;
            self.anchors[7].constant = 0;
            self.anchors[8].constant = -100;
            
            //ratings
            self.anchors[9].constant = 0;
            self.anchors[10].constant = 0;
            self.anchors[11].constant = 0;
            self.anchors[12].constant = -100;
            self.mainView.layoutIfNeeded();
            self.pageDownOrUp = false;
        }
        //collect data from sliders and then send to slider
        //            print("collecting data");
        let distance = Int(slider.value);
        let price = Int(priceSlider.value);
        let rating = Int(ratingsSlider.value);
        
//        print("current:\(userCurrentCity)");
        let conn = Conn();
        let postBody = "Distance=\(distance)&Price=\(price)&Rating=\(rating)&Latitude=\(userLatitude!)&Longitude=\(userLongtiude!)&City=\(userCurrentCity!)";
        conn.connect(fileName: "FiltersSearch.php", postString: postBody) { (re) in
            
            if(urlData != nil){
                do{
                    let _ = try JSONSerialization.jsonObject(with: urlData!, options: .allowFragments) as! NSDictionary;
                    //                        print(json);
//                    let results = json["results"] as! NSArray;
//                    for item in results{
//                        self.recommendedPage?.restaurantTitles.append(item as! String);
//
//                    }
//
//                    let tele = json["telephone"] as! NSArray;
//                    for item in tele{
//                        self.recommendedPage?.restaurantTelephones.append(item as! String);
//
//                    }
//
//                    let close = json["close"] as! NSArray;
//                    for item in close{
//                        self.recommendedPage?.restaurantCloseHours.append(item as! String);
//
//                    }
//
//                    let open = json["open"] as! NSArray;
//                    for item in open{
//                        self.recommendedPage?.restaurantOpenHours.append(item as! String);
//
//                    }
//
//                    let results2 = json["restIDs"] as! NSArray;
//                    for item in results2{
//                        self.recommendedPage?.restaurantIDs.append(item as! String);
//
//                    }
//                    let results3 = json["restAddresses"] as! NSArray;
//                    for item in results3{
//                        self.recommendedPage?.restaurantAddresses.append(item as! String);
//
//                    }
//                    let results4 = json["urls"] as! NSArray;
//                    for item in results4{
//                        self.recommendedPage?.restaurantPicURLs.append(item as! String);
//
//                    }
//                    let results7 = json["distance"] as! NSArray;
//                    for item in results7{
//                        self.recommendedPage?.restaurantDistances.append(item as! Double);
//                    }
//
//                    for item in self.recommendedPage!.restaurantPicURLs{
//                        let url = URL(string: item);
//                        let data = try? Data(contentsOf: url!);
//                        let image = UIImage(data: data!);
//                        self.recommendedPage?.restaurantPics.append(image);
//                    }
                    
                    DispatchQueue.main.async {
                        self.mainCollectionView.reloadData();
                    }
                }catch{
                    print("erro");
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = filtersList.dequeueReusableCell(withReuseIdentifier: indentifier, for: indexPath) as! FiltersViewCell;
        cell.filterButton.addTarget(self, action: #selector(filtersDown), for: .touchUpInside);
        if(indexPath.item == 0){
            cell.filterButton.setTitle("1 mile", for: .normal);
            cell.setNum(index: 0);
        }else if(indexPath.item == 1){
            cell.filterButton.setTitle("$", for: .normal);
            cell.setNum(index: 1);
        }else{
            cell.filterButton.setTitle("5 stars", for: .normal);
            cell.setNum(index: 2);
        }
        return cell;
    }
    
    @objc private func filtersDown(){
        if(pageDownOrUp){
            setAnchor();
        }else{
            UIView.animate(withDuration: 0.3) {
                self.darkView.alpha = 0.7;
                self.anchors[0].constant = 400;//dropDownMenu
                //distance slider
                self.anchors[1].constant = 50;//sliderTitle
                self.anchors[2].constant = 10;//leftLabel
                self.anchors[3].constant = 10;//rightLabel
                self.anchors[4].constant = 0;//sliderView
                //price slider
                self.anchors[5].constant = 20;
                self.anchors[6].constant = 10;
                self.anchors[7].constant = 10;
                self.anchors[8].constant = 0;
                
                //ratings slider
                self.anchors[9].constant = 20;
                self.anchors[10].constant = 10;
                self.anchors[11].constant = 10;
                self.anchors[12].constant = 0;
                
                self.mainView.layoutIfNeeded()
            }
            pageDownOrUp = true;
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3;
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.size.width/3, height: self.frame.size.height);
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func removeAllFromRestaurantArrays(){
    }
    
}
