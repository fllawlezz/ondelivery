//
//  SpinningView.swift
//  YummyV1
//
//  Created by Brandon In on 4/6/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit

class SpinningView: UIView{
    
    let circleLayer = CAShapeLayer();
    
    let strokeEndAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 2
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        let group = CAAnimationGroup()
        group.duration = 2.5
        group.repeatCount = MAXFLOAT
        group.animations = [animation]
        
        return group
    }()
    
    let strokeStartAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "strokeStart")
        animation.beginTime = 0.5
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 2
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        let group = CAAnimationGroup()
        group.duration = 2.5
        group.repeatCount = MAXFLOAT
        group.animations = [animation]
        
        return group
    }()
    
    let rotationAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0
        animation.toValue = Double.pi * 2
        animation.duration = 4
        animation.repeatCount = MAXFLOAT
        return animation
    }()
    
    var animating: Bool = true {
        didSet {
            updateAnimation()
        }
    }
    
    var lineWidth: CGFloat = 1.5 {
        didSet {
            circleLayer.lineWidth = lineWidth
            setNeedsLayout()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        setup();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError();
    }
    
    func setup(){
        circleLayer.lineWidth = lineWidth;
        circleLayer.fillColor = nil;
        circleLayer.strokeColor = UIColor.black.cgColor;
        layer.addSublayer(circleLayer);
        updateAnimation()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        
        let center = CGPoint(x: bounds.midX, y: bounds.midY);
        let radius = min(bounds.width, bounds.height) / 2 - circleLayer.lineWidth/2;
        let startAngle = CGFloat(Double.pi/2);
        let endAngle = startAngle + CGFloat(Double.pi*2);
        let path = UIBezierPath(arcCenter: CGPoint.zero, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true);
        circleLayer.position = center;
        circleLayer.path = path.cgPath;
    }
    
    func updateAnimation(){
        if animating {
//            print("animating");
            circleLayer.add(strokeEndAnimation, forKey: "strokeEnd")
            circleLayer.add(strokeStartAnimation, forKey: "strokeStart")
            circleLayer.add(rotationAnimation, forKey: "transform.rotation.z")
        }else {
            circleLayer.removeAnimation(forKey: "strokeEnd")
            circleLayer.removeAnimation(forKey: "strokeStart")
            circleLayer.removeAnimation(forKey: "transform.rotation.z")
        }
    }
}
