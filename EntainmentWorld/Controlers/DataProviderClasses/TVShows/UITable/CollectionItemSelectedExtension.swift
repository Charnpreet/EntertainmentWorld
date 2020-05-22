//
//  ItemSelectedCollection.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 1/5/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation
import UIKit


extension DataSourceProviderForTable : CollectionViewSelectedProtocol {
    
    func collectionViewSelected(item : TVShows) {
        self.screenSegus.LoadSegus(item: item)
    }
    
}
