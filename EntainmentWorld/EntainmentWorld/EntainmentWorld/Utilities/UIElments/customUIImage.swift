//
//  customUIImage.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 7/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit

class customUIImage: UIImage {
    
    
    static  func  getCustomUIImage()->UIImageView{
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 12
        iv.layer.borderWidth = 1.5
        iv.layer.borderColor = UIColor.red.cgColor
        return iv
    }
    
    static func getRoundedImageView(frame: CGRect)->UIImageView{
        let image = UIImageView(frame: frame)
        image.layer.borderWidth = 8
        image.layer.borderColor = UIColor.red.cgColor
        image.layer.masksToBounds = false
        image.layer.borderColor = UIColor.black.cgColor
        image.layer.cornerRadius = image.frame.height/2
        image.clipsToBounds = true
        return image
    }
}
