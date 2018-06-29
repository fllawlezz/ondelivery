//
//  TosPage.swift
//  YummyV1
//
//  Created by Brandon In on 1/5/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import Foundation
import UIKit

class TosPage: UIViewController{
    
    var termsView: UIWebView!;
    
    override func viewDidLoad() {
        self.navigationItem.title = "Terms Of Service";
        let leftBarButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil);
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = leftBarButton;
        self.view.backgroundColor = UIColor.white;
        
        termsView = UIWebView();
        termsView.backgroundColor = UIColor.black;
        termsView.translatesAutoresizingMaskIntoConstraints = false;
        self.view.addSubview(termsView);
        termsView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        termsView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        termsView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10).isActive = true;
        termsView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -10).isActive = true;
        
        let url = URL(string: "https://ondeliveryinc.com/terms.html")!;
        termsView.loadRequest(URLRequest(url: url));
    }
}
