//
//  PrivacyPage.swift
//  YummyV1
//
//  Created by Brandon In on 1/5/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import Foundation
import UIKit

class PrivacyPage: UIViewController{
    
    var privacyView: UIWebView!;
    
    override func viewDidLoad() {
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
        privacyView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10).isActive = true;
        privacyView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -10).isActive = true;
        
        let url = URL(string: "https://ondeliveryinc.com/privacy.html")!;
        privacyView.loadRequest(URLRequest(url: url));
    }
}
