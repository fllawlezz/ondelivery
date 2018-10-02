//
//  ErrorAlertController.swift
//  YummyV1
//
//  Created by Brandon In on 9/4/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

let errorCloseNotification = "ErrorCloseNotification";

class ErrorAlertController: UIViewController, ErrorViewDelegate{
    
    lazy var errorView: ErrorView = {
        let errorView = ErrorView();
        return errorView;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = .clear;
        setupErrorView();
    }
    
    fileprivate func setupErrorView(){
        self.view.addSubview(errorView);
//        errorView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 50).isActive = true;
//        errorView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -50).isActive = true;
        errorView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true;
        errorView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true;
        errorView.widthAnchor.constraint(equalToConstant: 270).isActive = true;
        errorView.heightAnchor.constraint(equalToConstant: 150).isActive = true;
        
        errorView.delegate = self;
    }
    
}
extension ErrorAlertController{
    @objc func selfDismiss(){
        print("dismiss try");
        
        let name = Notification.Name(rawValue: errorCloseNotification);
        NotificationCenter.default.post(name: name, object: nil);
        
        self.dismiss(animated: true, completion: nil);
    }
    
    func handleOkPressed() {
        selfDismiss();
    }
    
}
