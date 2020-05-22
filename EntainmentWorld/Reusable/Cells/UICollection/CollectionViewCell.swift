//
//  CollectionViewCellController.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 7/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    public var cellImage: UIImageView = customUIImage.getCustomUIImage()
    var titleTextLabel: UILabel!
    override init(frame : CGRect) {
        super.init(frame : frame)
         contentView.addSubview(cellImage)
        backgroundColor = BackGroundColor.getBackgrndClr()  //.black
        cellImage.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        cellImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        cellImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        cellImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        cellImage.backgroundColor = BackGroundColor.getBackgrndClr()
        titleTextLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 40)) //40
        titleTextLabel.center = contentView.center
        titleTextLabel.textAlignment = .center
        titleTextLabel.textColor = BackGroundColor.textColor()
        titleTextLabel.numberOfLines = 2
        contentView.addSubview(titleTextLabel)
        
      }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class BaseCollectionCell<U> : CollectionViewCell{
    var item: U!
}
 
