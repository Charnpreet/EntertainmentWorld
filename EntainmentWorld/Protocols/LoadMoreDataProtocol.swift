//
//  LoadMoreDataProtocol.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 17/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation

protocol LoadMoreDataProtocol {
    
    func loadMoreOnAirShowData(completionHandler:@escaping(Bool)->Void)
    func loadMoreOnAirTodayShowData(completionHandler:@escaping(Bool)->Void)
    func loadMorePopularShowData(completionHandler:@escaping(Bool)->Void)
    func loadMoreTopRatedShowData(completionHandler:@escaping(Bool)->Void)
    
}
