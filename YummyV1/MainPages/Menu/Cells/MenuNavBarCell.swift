//
//  MenuNavBarCell.swift
//  YummyV1
//
//  Created by Brandon In on 3/28/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

//MARK: MenuNavBarCell
class MenuNavBarCell: UICollectionViewCell{
    
    var image:UIImageView!;
    var titleLabel: UILabel!;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.tintColor = UIColor.gray;
        setUp();
    }
    
    override var isHighlighted: Bool{
        didSet{
            if(isHighlighted){
                image.tintColor = UIColor.black;
            }else if(!isHighlighted){
                image.tintColor = UIColor(red: 91/255, green: 14/255, blue: 13/255, alpha: 1);
            }
        }
    }
    
    override var isSelected: Bool{
        didSet{
            if(isSelected){
                image.tintColor = UIColor.white;
            }else if(!isSelected){
                image.tintColor = UIColor(red: 91/255, green: 14/255, blue: 13/255, alpha: 1);
            }
        }
    }
    
    func setUp(){
        titleLabel = UILabel();
        titleLabel.translatesAutoresizingMaskIntoConstraints = false;
        titleLabel.text = "Nothing";
        titleLabel.textAlignment = .center;
        titleLabel.textColor = UIColor.black;
        titleLabel.minimumScaleFactor = 0.1;
        titleLabel.numberOfLines = 1;
        titleLabel.adjustsFontSizeToFitWidth = true;
        titleLabel.font = UIFont(name: "Montserrat-Regular", size: 12);
        self.addSubview(titleLabel);
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor,constant: 10).isActive = true;
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
        titleLabel.widthAnchor.constraint(equalToConstant: 70).isActive = true;
        titleLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        
        image = UIImageView();
        image.translatesAutoresizingMaskIntoConstraints = false;
        image.isUserInteractionEnabled = true;
        self.addSubview(image);
        image.rightAnchor.constraint(equalTo: self.titleLabel.leftAnchor, constant: -5).isActive = true;
        image.widthAnchor.constraint(equalToConstant: 25).isActive = true;
        image.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor).isActive = true;
        image.heightAnchor.constraint(equalToConstant: 25).isActive = true;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    func setImage(name: String){
        image.image = UIImage(named: name);
    }
    
    func setText(name: String){
        titleLabel.text = name;
    }
}
