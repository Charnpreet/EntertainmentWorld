//
//  GenreCateogryCell.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 4/6/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation

class GenreCateogryCell : BaseCollectionCell<Genre>{
    var id : Int!
    override var item: Genre!{
           didSet{
            id = item.id
            let name = item.name
            self.titleTextLabel.text = name
           }
       }
}
