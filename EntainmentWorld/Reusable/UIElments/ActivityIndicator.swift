//
//  ActivityIndicator.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 29/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation
import UIKit
class ActivityIndicator {
    
    
    static func getActivityIndicator ()-> UIActivityIndicatorView{
        
        let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
            activityIndicator.backgroundColor = BackGroundColor.getBackgrndClr() //.black
            activityIndicator.color = .systemRed
            activityIndicator.style = .large
        return activityIndicator
    }
}
