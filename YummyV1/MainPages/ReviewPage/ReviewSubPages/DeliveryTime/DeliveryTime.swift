//
//  DeliveryTime.swift
//  YummyV1
//
//  Created by Brandon In on 12/24/17.
//  Copyright © 2017 Rendered Co.RaftPod. All rights reserved.
//

import Foundation
import UIKit

class DeliveryTimePage: UIViewController, UITextFieldDelegate{
    
    var reviewPage: ReviewPage?
    
    var deliveryTime: String?
    var deliveryDescription: UILabel = {
        let deliveryDescription = UILabel();
        deliveryDescription.translatesAutoresizingMaskIntoConstraints = false;
        deliveryDescription.text = "What time do you want your delivery?";
        deliveryDescription.font = UIFont.montserratRegular(fontSize: 15);
        deliveryDescription.textColor = UIColor.black;
        deliveryDescription.textAlignment = .center;
        return deliveryDescription;
    }()
    var backgroundView: UIView = {
        let backgroundView = UIView();
        backgroundView.translatesAutoresizingMaskIntoConstraints = false;
        backgroundView.backgroundColor = UIColor.white;
        return backgroundView;
    }()
    var asapButton: UIButton = {
        let asapButton = UIButton(type: .system);
        asapButton.translatesAutoresizingMaskIntoConstraints = false;
        asapButton.titleLabel?.font = UIFont.montserratSemiBold(fontSize: 16)
        asapButton.setTitle("ASAP", for: .normal);
        asapButton.setTitleColor(UIColor.black, for: .normal);
        asapButton.layer.borderWidth = 0.25;
        asapButton.layer.cornerRadius = 5;
        return asapButton;
    }()
    var laterButton: UIButton = {
        let laterButton = UIButton(type: .system);
        laterButton.translatesAutoresizingMaskIntoConstraints = false;
        laterButton.titleLabel?.font = UIFont.montserratSemiBold(fontSize: 16);
        laterButton.setTitle("Later", for: .normal);
        laterButton.setTitleColor(UIColor.black, for: .normal);
        laterButton.layer.borderWidth = 0.25;
        laterButton.layer.borderColor = UIColor.black.cgColor;
        laterButton.layer.cornerRadius = 5;
        return laterButton;
    }()
    var timeField: TextFieldPadded = {
        let timeField = TextFieldPadded();
        timeField.translatesAutoresizingMaskIntoConstraints = false;
        timeField.textColor = UIColor.gray;
        timeField.backgroundColor = UIColor.veryLightGray;
        timeField.borderStyle = .roundedRect;
        timeField.textAlignment = .center;
        timeField.font = UIFont.montserratRegular(fontSize: 15);
        return timeField;
    }()
    var asapBool: Bool = true;
    var timePicker = UIDatePicker();
    var submitButton: UIButton = {
        let submitButton = UIButton(type: .system);
        submitButton.translatesAutoresizingMaskIntoConstraints = false;
        submitButton.backgroundColor = UIColor.appYellow;
        submitButton.setTitleColor(UIColor.black, for: .normal);
        submitButton.setTitle("Submit", for: .normal);
        submitButton.titleLabel?.font = UIFont.montserratSemiBold(fontSize: 18);
        return submitButton;
    }()
    
    override func viewDidLoad() {
        self.navigationItem.title = "Delivery Time";
        let leftBarButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil);
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = leftBarButton;
        
        self.view.backgroundColor = UIColor.white;
        
        setup();
        datePickerSetup();
    }
    
    private func setup(){
        setupDeliveryDescription();
        setupBackgroundView();
        setupAsapButton();
        
        //laterButton
        setupLaterButton();
        
        //timeFiedl
        setupTimeField();
        
        //submit button
        setupSubmitButton();
        
    }
    
    fileprivate func setupBackgroundView(){
        self.view.addSubview(backgroundView);
        //x,y,width,height
        backgroundView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true;
        backgroundView.topAnchor.constraint(equalTo: self.deliveryDescription.bottomAnchor, constant: 10).isActive = true;
        backgroundView.widthAnchor.constraint(equalToConstant: 220).isActive = true;
        backgroundView.heightAnchor.constraint(equalToConstant: 80).isActive = true;
    }
    
    fileprivate func setupDeliveryDescription(){
        self.view.addSubview(deliveryDescription);
        //need x,y,width,height
        deliveryDescription.leftAnchor.constraint(equalTo: self.view.leftAnchor,constant: 5).isActive = true;
        deliveryDescription.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -5).isActive = true;
        deliveryDescription.heightAnchor.constraint(equalToConstant: 30).isActive = true;
        deliveryDescription.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive = true;
    }
    
    fileprivate func setupAsapButton(){
        if(asapBool){
            asapButton.backgroundColor = UIColor.appYellowDark;
        }else{
            asapButton.backgroundColor = UIColor.appYellow;
        }
        self.backgroundView.addSubview(asapButton);
        //need x,y,width,height
        asapButton.leftAnchor.constraint(equalTo: backgroundView.leftAnchor, constant: 5).isActive = true;
        asapButton.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor).isActive = true;
        asapButton.widthAnchor.constraint(equalToConstant: 100).isActive = true;
        asapButton.heightAnchor.constraint(equalToConstant: 40).isActive = true;
        asapButton.addTarget(self, action: #selector(self.asapPressed), for: .touchUpInside);
    }
    
    fileprivate func setupLaterButton(){
        if(asapBool){
            laterButton.backgroundColor = UIColor.appYellow;
        }else{
            laterButton.backgroundColor = UIColor.appYellowDark;
        }
        
        self.backgroundView.addSubview(laterButton);
        //need x,y,width,height
        laterButton.rightAnchor.constraint(equalTo: backgroundView.rightAnchor, constant: -5).isActive = true;
        laterButton.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor).isActive = true;
        laterButton.widthAnchor.constraint(equalToConstant: 100).isActive = true;
        laterButton.heightAnchor.constraint(equalToConstant: 40).isActive = true;
        laterButton.addTarget(self, action: #selector(self.laterPressed), for: .touchUpInside);
    }
    
    fileprivate func setupTimeField(){
        timeField.delegate = self;
        timeField.inputView = timePicker;
        self.view.addSubview(timeField);
        timeField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true;
        timeField.topAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: 20).isActive = true;
        timeField.widthAnchor.constraint(equalToConstant: 200).isActive = true;
        timeField.heightAnchor.constraint(equalToConstant: 40).isActive = true;
        
        if(asapBool){
            timeField.isUserInteractionEnabled = false;
        }else{
            timeField.textColor = UIColor.black;
            timeField.text = self.deliveryTime;
            timeField.isUserInteractionEnabled = true;
            timeField.becomeFirstResponder();
        }

    }
    
    fileprivate func setupSubmitButton(){
        self.view.addSubview(submitButton);
        //need x,y,width,height
        submitButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        submitButton.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        submitButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true;
        submitButton.heightAnchor.constraint(equalToConstant: 80).isActive = true;
        submitButton.addTarget(self, action: #selector(self.submit), for: .touchUpInside);
    }
    
    private func datePickerSetup(){
        let time = Date();
        let timeFormatter = DateFormatter();
        timeFormatter.dateFormat = "hh:mm a";
        timeFormatter.amSymbol = "AM";
        timeFormatter.pmSymbol = "PM";
        timePicker.datePickerMode = UIDatePickerMode.time;
        let string = timeFormatter.string(from: time);
        timeField.text = string;
        self.deliveryTime = string;
        timePicker.addTarget(self, action: #selector(self.timeChanged), for: .valueChanged);
        
    }
    
    //MARK: Button Functions
    @objc func asapPressed(){//if asap bool is true, then the customer wants his/her food ASAP
        if(!asapBool){//if asap bool = true
            asapBool = true;
            self.asapButton.backgroundColor = UIColor.appYellowDark;
            self.laterButton.backgroundColor = UIColor.appYellow;
            timeField.isUserInteractionEnabled = false;
            timeField.textColor = UIColor.gray;
        }
    }
    
    @objc func laterPressed(){//if asap bool is false, then the customer wants his/her food at another time
        if(asapBool){
            asapBool = false;
            self.laterButton.backgroundColor = UIColor.appYellowDark;
            self.asapButton.backgroundColor = UIColor.appYellow;
            timeField.isUserInteractionEnabled = true;
            timeField.textColor = UIColor.black;
            timeField.becomeFirstResponder();
        }
    }
    
    @objc private func timeChanged(){
        let time = self.timePicker.date;
        let formatter = DateFormatter();
        formatter.dateFormat = "h:mm a";
        let string = formatter.string(from: time);
        self.timeField.text = string;
        self.deliveryTime = string;
    }
    
    @objc private func submit(){
        if(!asapBool){
            self.deliveryTime = self.timeField.text;
            self.reviewPage?.deliveryTime = self.deliveryTime;
            self.reviewPage?.tableView.handleReloadTable();
            self.navigationController?.popViewController(animated: true);
        }else{
            self.deliveryTime = "ASAP";
            self.reviewPage?.deliveryTime = self.deliveryTime;
            self.reviewPage?.tableView.handleReloadTable();
            self.navigationController?.popViewController(animated: true);
        }
    }
    
    //MARK: TouchesBegan
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.timeField.resignFirstResponder();
    }
}
