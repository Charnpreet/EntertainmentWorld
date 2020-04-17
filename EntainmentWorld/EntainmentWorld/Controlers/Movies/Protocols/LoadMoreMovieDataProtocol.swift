//
//  LoadMoreMovieDataProtocol.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 17/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation

protocol LoadMoreMovieDataProtocol {
    
    func loadMoreTopRatedmoviesData(completionHandler:@escaping()->Void)
    func loadMoreNowPlayingMoviesData(completionHandler:@escaping()->Void)
    func loadMorePopularMoviesData(completionHandler:@escaping()->Void)
    func loadMoreUpComingMoviesData(completionHandler:@escaping()->Void)
    
}
