//
//  RecommendedBottomView.swift
//  YummyV1
//
//  Created by Brandon In on 6/29/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import Foundation
import UIKit

class RecommendedBottomView: UICollectionReusableView{
    //ELEMENTS:
    var loadMoreLabel: UIButton!;
    var callBackBtn: (()->())?
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        setup();
    }
    
    private func setup(){
        loadMoreLabel = UIButton(type: .system);
        loadMoreLabel.translatesAutoresizingMaskIntoConstraints = false;
        loadMoreLabel.setTitle("Load More", for: .normal);
        loadMoreLabel.setTitleColor(UIColor.black, for: .normal);
        loadMoreLabel.titleLabel?.font = UIFont.italicSystemFont(ofSize: 16);
        loadMoreLabel.backgroundColor = UIColor.white;
        self.addSubview(loadMoreLabel);
        loadMoreLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true;
        loadMoreLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true;
        loadMoreLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        loadMoreLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        loadMoreLabel.addTarget(self, action: #selector(self.clickButton), for: .touchUpInside);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    @objc func clickButton(){
        callBackBtn?()
    }
}
