//
//  CollectionViewSelectedItemProtocol.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 18/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation
import UIKit
protocol CollectionViewSelectedProtocol {
    
    func collectionViewSelected(item : TVShows) //_ collectionViewItem : Int
    

}

protocol  DoSegus {
    func LoadSegus(item : TVShows)
}
