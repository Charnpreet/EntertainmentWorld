//
//  BaseDataProviderCollectionCell.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 20/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation
import UIKit
class  BaseDataProviderShowsCollectionCell  : NSObject{
    var delegate :CollectionViewSelectedProtocol!
    var shows: [TVShows] = []
    var loadMoreContent : LoadMoreDataProtocol!
    let db = DBConnection()
    fileprivate var visiblePage: Int = 1
    fileprivate var totalNoOfPages: Int = 1
    var currentPage : Int{
        get{
            return visiblePage
        }
        set{
            visiblePage = newValue
        }
    }
    var totalPages : Int{
        get{
            return totalNoOfPages
        }
        set{
            totalNoOfPages = newValue
        }
    }
}
