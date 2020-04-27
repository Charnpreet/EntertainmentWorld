//
//  LoadMoreMovieDataProtocol.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 17/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation

protocol LoadMoreMovieDataProtocol {
    
    func loadMoreTopRatedmoviesData(completionHandler:@escaping(Bool)->Void)
    func loadMoreNowPlayingMoviesData(completionHandler:@escaping(Bool)->Void)
    func loadMorePopularMoviesData(completionHandler:@escaping(Bool)->Void)
    func loadMoreUpComingMoviesData(completionHandler:@escaping(Bool)->Void)
    
}
