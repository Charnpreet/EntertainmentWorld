//
//  UISegmentedControll.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 4/5/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation
import  UIKit

class UISegement : UISegmentedControl {
    
    static func getSegmentedControll(frame: CGRect, items: [String], bgColr: UIColor, sitemTintClr: UIColor)-> UISegmentedControl{
        let sc = UISegmentedControl(frame: frame)
        for (index, item) in items.enumerated() {
            sc.insertSegment(withTitle: item, at: index, animated: true)
        }
              sc.selectedSegmentIndex = 0
              sc.layer.borderColor = UIColor.systemRed.cgColor
              sc.layer.borderWidth = 2
              sc.backgroundColor = bgColr
              sc.selectedSegmentTintColor = sitemTintClr
              sc.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for: .normal)
        return sc
    }
}
