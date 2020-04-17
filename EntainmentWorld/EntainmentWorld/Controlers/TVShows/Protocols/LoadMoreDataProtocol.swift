//
//  LoadMoreDataProtocol.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 17/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation

protocol LoadMoreDataProtocol {
    
    func loadMoreOnAirShowData(completionHandler:@escaping()->Void)
    func loadMoreOnAirTodayShowData(completionHandler:@escaping()->Void)
    func loadMorePopularShowData(completionHandler:@escaping()->Void)
    func loadMoreTopRatedShowData(completionHandler:@escaping()->Void)
    
}
