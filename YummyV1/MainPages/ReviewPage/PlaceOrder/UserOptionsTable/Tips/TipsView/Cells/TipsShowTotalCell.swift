//
//  TipsShowTotalCell.swift
//  YummyV1
//
//  Created by Brandon In on 7/25/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class TipsShowTotalCell: UICollectionViewCell{
    
    lazy var tipMessageLabel: NormalUILabel = {
        let tipMessageLabel = NormalUILabel(textColor: UIColor.darkGray, font: .montserratRegular(fontSize: 12), textAlign: .left);
        tipMessageLabel.text = "Don't select a square for no tip";
        return tipMessageLabel;
    }()
    
    lazy var tipTotalLabel: NormalUILabel = {
        let tipTotalLabel = NormalUILabel(textColor: UIColor.black, font: UIFont.montserratRegular(fontSize: 14), textAlign: .right);
        return tipTotalLabel;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.white;
        addObservers();
        setupTipsMessageLabel();
        setupTipTotalLabel();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self);
    }
    
    
    fileprivate func addObservers(){
        let name = Notification.Name(rawValue: updateTipsValueNotification);
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateTipTotal(notification:)), name: name, object: nil);
    }
    
    fileprivate func setupTipsMessageLabel(){
        self.addSubview(tipMessageLabel);
        tipMessageLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true;
        tipMessageLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        tipMessageLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        tipMessageLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -100).isActive = true;

    }
    
    fileprivate func setupTipTotalLabel(){
        self.addSubview(tipTotalLabel);
        tipTotalLabel.leftAnchor.constraint(equalTo: self.tipMessageLabel.rightAnchor).isActive = true;
        tipTotalLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true;
        tipTotalLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        tipTotalLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;

        self.tipTotalLabel.text = "Tip: $0.00";
    }
    
    func setTipTotal(tipTotal: Double){
        let tipTotalString = String(format: "%.2f", tipTotal);
        self.tipTotalLabel.text = "Tip: $\(tipTotalString)";
    }
    
    @objc func updateTipTotal(notification: NSNotification){
        if let info = notification.userInfo{
            let tipTotal = info["tipTotal"] as! Double;
            self.setTipTotal(tipTotal: tipTotal);
        }
    }
    
    
}
