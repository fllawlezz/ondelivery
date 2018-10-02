//
//  LoadingView.swift
//  YummyV1
//
//  Created by Brandon In on 9/3/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

let loadingViewShow = "LoadingViewShow";
let loadingViewDismiss = "LoadingViewDismiss";


class LoadingView: UIView{
    
    lazy var selectedDarkView: UIView = {
        let selectedDarkView = UIView();
        selectedDarkView.translatesAutoresizingMaskIntoConstraints = false;
        selectedDarkView.backgroundColor = UIColor.black;
        selectedDarkView.alpha = 1;
        return selectedDarkView;
    }()
    
    lazy var spinner: SpinningView = {
        let spinner = SpinningView();
        spinner.translatesAutoresizingMaskIntoConstraints = false;
        spinner.circleLayer.strokeColor = UIColor.white.cgColor;
        return spinner;
    }()
    
    var messageLabel: UILabel = {
        let messageLabel = UILabel();
        messageLabel.text = "Loading...";
        messageLabel.font = UIFont.montserratSemiBold(fontSize: 14);
        messageLabel.textColor = UIColor.white;
        messageLabel.textAlignment = .center;
        return messageLabel;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.translatesAutoresizingMaskIntoConstraints = false;
//        self.backgroundColor = .veryLightGray;
        self.alpha = 0;
        setupObservers();
        if let window = UIApplication.shared.keyWindow{
            window.addSubview(self);
            self.frame = window.frame;

            window.addSubview(self.selectedDarkView);
            self.selectedDarkView.backgroundColor = UIColor.black;
            self.selectedDarkView.frame = window.frame;
//            self.selectedDarkView.alpha = 0.7;
            self.selectedDarkView.alpha = 0;
            self.selectedDarkView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissLoadingPage)));

            window.addSubview(self.spinner);
            //            spinner.backgroundColor = UIColor.red;
            self.spinner.frame = CGRect(x: 0, y: 0, width: 50, height: 50);
            self.spinner.center.x = window.center.x;
            self.spinner.center.y = window.center.y;
            self.spinner.alpha = 0;
            //when collection view is clicked, then show collectionview

            window.addSubview(messageLabel);
            self.messageLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 40);
            self.messageLabel.center.x = window.center.x;
            self.messageLabel.center.y = window.center.y - 50;
            self.messageLabel.alpha = 0;
        }
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    fileprivate func setupObservers(){
        let loadingShow = Notification.Name(loadingViewShow);
        let loadingDismiss = Notification.Name(loadingViewDismiss);
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.showLoadingPage), name: loadingShow, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(self.dismissLoadingPage), name: loadingDismiss, object: nil);
    }
    
    fileprivate func setupSpinner(){
        
        spinner.backgroundColor = UIColor.red
        spinner.frame = CGRect(x: 0, y: 0, width: 50, height: 50);
        spinner.frame.origin = self.frame.origin;
    }
    
    @objc func showLoadingPage(){
        UIView.animate(withDuration: 0.3) {
//            if let window = UIApplication.shared.keyWindow{
//                window.addSubview(self);
//                self.frame = window.frame;
//
//                window.addSubview(self.selectedDarkView);
//                self.selectedDarkView.backgroundColor = UIColor.black;
//                self.selectedDarkView.frame = window.frame;
//                self.selectedDarkView.alpha = 0.7;
//                self.selectedDarkView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissLoadingPage)));
//
//                window.addSubview(self.spinner);
//                //            spinner.backgroundColor = UIColor.red;
//                self.spinner.frame = CGRect(x: 0, y: 0, width: 50, height: 50);
//                self.spinner.center.x = window.center.x;
//                self.spinner.center.y = window.center.y;
//                //when collection view is clicked, then show collectionview
//
//                window.addSubview(self.messageLabel);
//                self.messageLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 40);
//                self.messageLabel.center.x = window.center.x;
//                self.messageLabel.center.y = window.center.y - 50;
//            }
            self.alpha = 1;
            self.selectedDarkView.alpha = 0.7;
            self.spinner.alpha = 1;
            self.messageLabel.alpha = 1;
        }
    }
    
    func showDarkView(){
        UIView.animate(withDuration: 0.3) {
            self.alpha = 1;
            self.selectedDarkView.alpha = 0.7;
        }
    }
    
    func dismissDarkView(){
        UIView.animate(withDuration: 0.3) {
            self.alpha = 0;
            self.selectedDarkView.alpha = 0;
        }
    }
    
    @objc func dismissLoadingPage(){
        UIView.animate(withDuration: 0.3) {
            self.alpha = 0;
            self.selectedDarkView.alpha = 0;
            self.spinner.alpha = 0;
            self.messageLabel.alpha = 0;
        }
        
    }
}
