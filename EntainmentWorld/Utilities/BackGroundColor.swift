//
//  BackGroundColor.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 30/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit

class BackGroundColor {
    static var backgroundClr = UIColor.black
    static var textClr = UIColor.white
    
    static func getBackgrndClr()-> UIColor{
        return backgroundClr
    }
    // this must check if dark mode is on or off
    // should return colr according to that
    static func textColor ()-> UIColor{
        return textClr
    }
    
    static func updateBackgroundClor(darkmode on : Bool){
        if(on){
            backgroundClr = UIColor.black
            textClr = UIColor.white
        }else{
            backgroundClr = UIColor.white
            textClr = UIColor.black
        }
    }
}
