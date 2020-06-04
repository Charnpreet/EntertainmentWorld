//
//  BaseDataProviderForMovieCollectionCell.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 20/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation
import UIKit
class BaseDataProviderForMovieCollectionCell : NSObject {
    typealias T = MoviesDetails
    var visiblePage: Int = 1
    var totalNoOfPages: Int = 1 
    var moviesList :[MoviesDetails] = []
    let db = DBConnection()
    var  loadMoreContent :LoadMoreMovieDataProtocol!
    var delegate :   MovieCollectionViewSelectedProtocol!

    
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
