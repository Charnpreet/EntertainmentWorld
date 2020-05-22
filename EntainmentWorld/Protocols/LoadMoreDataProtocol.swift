//
//  LoadMoreDataProtocol.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 17/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation

protocol LoadMoreDataProtocol {
    
    func loadMoreOnAirShowData(pageNO: Int, completionHandler:@escaping(Bool)->Void)
    func loadMoreOnAirTodayShowData(pageNO: Int, completionHandler:@escaping(Bool)->Void)
    func loadMorePopularShowData(pageNO: Int, completionHandler:@escaping(Bool)->Void)
    func loadMoreTopRatedShowData(pageNO: Int, completionHandler:@escaping(Bool)->Void)
    
}
