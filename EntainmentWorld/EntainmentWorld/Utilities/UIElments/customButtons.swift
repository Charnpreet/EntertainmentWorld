//
//  customButtons.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 7/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit

class customButtons {
    
        // will customized button with specified color and title
        // will also have rounded border from corners
    public static func getUIButton(title: String, bColor: UIColor)->UIButton{
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.backgroundColor = bColor
        setShadow(button: button)
        styleButton(button: button)
        return button
    }
    
    public static func styleForButtons(button:UIButton){
        setShadow(button: button)
        styleButton(button: button)
        }
    
    private static func setShadow(button: UIButton){
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 6.0)
        button.layer.shadowRadius = 8
        button.layer.shadowOpacity = 0.5
        button.clipsToBounds = true
        button.layer.masksToBounds = false
    }
    private static func styleButton(button: UIButton){
        button.layer.cornerRadius = 25
        button.layer.borderWidth = 0.0
        button.layer.borderColor = UIColor.darkGray.cgColor
         
    }
}
