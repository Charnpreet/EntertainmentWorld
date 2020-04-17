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
        backgroundColor = .clear
        cellImage.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        cellImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        cellImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        cellImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        titleTextLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 40))
        titleTextLabel.center = contentView.center
        titleTextLabel.textAlignment = .center
        titleTextLabel.textColor = .white
        contentView.addSubview(titleTextLabel)
        
      }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
 
