//
//  PromoCodeCell.swift
//  YummyV1
//
//  Created by Brandon In on 9/21/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

let resignPromoCodeNotification = "ResignPromoCodeNotification";

class PromoCodeCell: UICollectionViewCell, UITextFieldDelegate{
    
    lazy var promoCodeTextField: TextFieldPadded = {
        let promoCodeTextField = TextFieldPadded();
        promoCodeTextField.translatesAutoresizingMaskIntoConstraints = false;
        promoCodeTextField.font = UIFont.systemFont(ofSize: 14);
        promoCodeTextField.placeholder = "Promo Code";
        promoCodeTextField.layer.borderWidth = 1;
        promoCodeTextField.textAlignment = .left;
        promoCodeTextField.layer.borderColor = UIColor.black.cgColor;
        promoCodeTextField.returnKeyType = .done;
        promoCodeTextField.spellCheckingType = .no;
        promoCodeTextField.autocorrectionType = .no;
        return promoCodeTextField;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        setupObservers();
        setupTextField();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self);
    }
    
    fileprivate func setupObservers(){
        let name = Notification.Name(rawValue: resignPromoCodeNotification);
        NotificationCenter.default.addObserver(self, selector: #selector(self.resignPromoCodeField), name: name, object: nil);
    }
    
    fileprivate func setupTextField(){
        self.addSubview(promoCodeTextField);
        promoCodeTextField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true;
        promoCodeTextField.topAnchor.constraint(equalTo: self.topAnchor).isActive = true;
        promoCodeTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true;
        promoCodeTextField.widthAnchor.constraint(equalToConstant: 125).isActive = true;
        
        promoCodeTextField.delegate = self;
    }
    
    @objc func resignPromoCodeField(){
        self.promoCodeTextField.resignFirstResponder();
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.promoCodeTextField.resignFirstResponder();
        return true;
    }
    
}
