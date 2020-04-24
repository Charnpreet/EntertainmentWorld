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
      //  setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
      // setUp()
    }
    
    
    private func setUp(){
        let frame = CGRect(x: 0, y: 2, width: Constants.IOS_SCREEN_WIDTH-25, height: 40)
        searchbar = CustomSearchBar(frame: frame)
        searchbar.placeholder = "Search Here"
        if let textfield = searchbar.value(forKey: "searchField") as? UITextField {
            textfield.textColor = UIColor.white
            textfield.backgroundColor = UIColor.black
        }
        
        addSubview(searchbar)
    }
}
