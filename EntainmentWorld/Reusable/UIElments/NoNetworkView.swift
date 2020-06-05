//
//  NoNetworkView.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 29/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation
import UIKit
class NoNetworkViews {
    static func getNoNetworkViews()-> UIView{
        let frame = CGRect(x: 0, y: 0, width: Constants.IOS_SCREEN_WIDTH, height: Constants.IOS_SCREEN_HEIGHT)
        let view  = UIView(frame: frame)
        view.backgroundColor = BackGroundColor.getBackgrndClr()
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 5
        //view.layer.borderColor = UIColor.gray.cgColor
        let textLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        textLabel.textAlignment = .center
        textLabel.textColor = BackGroundColor.textColor()
        view.isHidden = true
        textLabel.text = "No Network Connection Available "
        view.addSubview(textLabel)
        return view
    }
    
//    static func AnimateNoNetworkViews(viewNeedtedToBeAnimated: UIView, parentView: UIView, position: CGFloat){
//        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveLinear, animations: {
//            viewNeedtedToBeAnimated.center.y += position
//        }, completion:{ _ in
//            UIView.animate(withDuration: 0.6, delay: 1.0, options: .curveLinear, animations: {
//                viewNeedtedToBeAnimated.center.y -= position
//
//                parentView.layoutIfNeeded()
//            }, completion: {_ in viewNeedtedToBeAnimated.isHidden = true})
//
//        })
//    }
    static func AnimateNoNetworkViews(viewNeedtedToBeAnimated: UIView, parentView: UIView, position: CGFloat){
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveLinear, animations: {
            viewNeedtedToBeAnimated.center.y += position
        }, completion:nil)}

}
