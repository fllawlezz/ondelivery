//
//  PrivacyView.swift
//  YummyV1
//
//  Created by Brandon In on 3/16/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import Foundation
import UIKit

class PrivacyView: UIViewController{
    
    var privacyView: UIWebView!;
    var topBar: UIView!;
    var backButton: UIButton!;
    override func viewDidLoad() {
        
        topBar = UIView();
        topBar.translatesAutoresizingMaskIntoConstraints = false;
        topBar.backgroundColor = UIColor.black;
        self.view.addSubview(topBar);
        topBar.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        topBar.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        topBar.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true;
        topBar.heightAnchor.constraint(equalToConstant: 60).isActive = true;
        
        backButton = UIButton(type: .system);
        backButton.translatesAutoresizingMaskIntoConstraints = false;
        backButton.setBackgroundImage(#imageLiteral(resourceName: "clear"), for: .normal);
        self.view.addSubview(backButton);
        backButton.leftAnchor.constraint(equalTo: self.topBar.leftAnchor, constant: 20).isActive = true;
        backButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 25).isActive = true;
        backButton.heightAnchor.constraint(equalToConstant: 20).isActive = true;
        backButton.widthAnchor.constraint(equalToConstant: 20).isActive = true;
        backButton.addTarget(self, action: #selector(clear), for: .touchUpInside);
        
        self.navigationItem.title = "Terms Of Service";
        let leftBarButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil);
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = leftBarButton;
        self.view.backgroundColor = UIColor.white;
        
        privacyView = UIWebView();
        privacyView.backgroundColor = UIColor.black;
        privacyView.translatesAutoresizingMaskIntoConstraints = false;
        self.view.addSubview(privacyView);
        privacyView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        privacyView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        privacyView.topAnchor.constraint(equalTo: self.topBar.bottomAnchor, constant: 10).isActive = true;
        privacyView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -10).isActive = true;
        
        let url = URL(string: "https://ondeliveryinc.com/privacy.html")!;
        privacyView.loadRequest(URLRequest(url: url));
    }
    
    @objc func clear(){
        self.dismiss(animated: true, completion: nil);
    }
}
