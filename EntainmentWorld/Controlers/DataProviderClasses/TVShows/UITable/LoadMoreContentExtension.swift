//
//  LoadMoreContentExtension.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 1/5/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation
import UIKit


// MARK: - Extension for implmenting protocol of loading more data


extension DataSourceProviderForTable : LoadMoreDataProtocol{
    
    func loadMoreOnAirTodayShowData(pageNO: Int,completionHandler: @escaping (Bool) -> Void) {
   
            loadOnAirTodayShows(pageNO: pageNO, completionHandler:{ (result) in
                completionHandler(result)
            })
    }
    
    func loadMorePopularShowData(pageNO : Int, completionHandler: @escaping (Bool) -> Void) {

            loadPopularShows(pageNO: pageNO, completionHandler:{(result) in
                completionHandler(result)
            })
    }
    
    func loadMoreTopRatedShowData(pageNO: Int, completionHandler: @escaping (Bool) -> Void) {
            loadTopratedShows(pageNO: pageNO, completionHandler:{ (result) in
                completionHandler(result)
            })
    }
    
    func loadMoreOnAirShowData(pageNO: Int,completionHandler:@escaping(Bool)->Void) {
        loadOnAirShows(pageNO:pageNO, completionHandler:{ (result) in
            completionHandler(result)
        })
    }
}
