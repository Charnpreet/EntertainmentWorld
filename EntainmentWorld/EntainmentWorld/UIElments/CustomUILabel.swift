//
//  CustomUILabel.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 8/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit

class CustomUILabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame:frame)
        setupLabel()
    }
    required init?(coder: NSCoder) {
        super.init(coder:coder)
        setupLabel()
    }
    func setupLabel(){
        textAlignment = .left
        font = font.withSize(25)
       // setShadow()
        styleButton()
    }
    private func setShadow(){
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 6.0)
        layer.shadowRadius = 8
        layer.shadowOpacity = 0.5
        clipsToBounds = true
        layer.masksToBounds = false
      }
      private func styleButton(){
        layer.cornerRadius = 10
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.darkGray.cgColor
           
      }
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
