//
//  CircularAnimationView.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 9/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit

class CircularAnimationView: UIView {
    
    fileprivate var progresslayer = CAShapeLayer()
    fileprivate var trackLayer = CAShapeLayer()
    var progress: CAShapeLayer {
        get {
            return self.progresslayer
        }
    }
    
    var progressColor = UIColor.white {
        didSet{
            progresslayer.strokeColor = progressColor.cgColor
        }
    }
    var trackColor = UIColor.lightGray {
        didSet{
            trackLayer.strokeColor = trackColor.cgColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("here now" )
        createCircularPath()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createCircularPath()
    }
    private func createCircularPath() {
        let xLoc = frame.size.width/2
        let yLoc = frame.size.height/2
        self.backgroundColor = .clear
        self.layer.cornerRadius = self.frame.size.width/2
        let circlePath = UIBezierPath(arcCenter: CGPoint(x:xLoc , y: yLoc), radius: 70, startAngle: -CGFloat.pi/2, endAngle: CGFloat(1.5 * .pi), clockwise: true)
        trackLayer.path = circlePath.cgPath
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.strokeColor = trackColor.cgColor
        trackLayer.lineWidth = 10.0
        layer.addSublayer(trackLayer)
        progresslayer.path = circlePath.cgPath
        progresslayer.fillColor = UIColor.clear.cgColor
        progresslayer.strokeColor = progressColor.cgColor
        progresslayer.lineCap  = .square
        progresslayer.lineWidth = 10.0
        progresslayer.strokeEnd = 0.0
        layer.addSublayer(progresslayer)
    }
    public func LoadingBarAnimation(){
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = 2
        basicAnimation.fillMode = .both
        basicAnimation.isRemovedOnCompletion = false
        progresslayer.add(basicAnimation, forKey: "basic")
        
    }
}



