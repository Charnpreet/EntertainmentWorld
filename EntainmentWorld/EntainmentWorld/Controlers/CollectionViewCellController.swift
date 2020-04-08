//
//  CollectionViewCellController.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 7/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit

class CollectionViewCellController: UICollectionViewCell {
    var cellImage: UIImageView = customUIImage.getCustomUIImage()
    override init(frame : CGRect) {
        super.init(frame : frame)
         contentView.addSubview(cellImage)
        cellImage.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        cellImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        cellImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        cellImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
      }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
 
