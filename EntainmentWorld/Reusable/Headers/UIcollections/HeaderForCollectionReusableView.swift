//
//  HeaderForCollectionReusableView.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 9/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit

class HeaderForCollectionReusableView: UICollectionReusableView {
    var searchbar : CustomSearchBar!
    override init(frame: CGRect) {
        super.init(frame:frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
    }
}
