//
//  LoadMoreMovieDataProtocol.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 17/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation

protocol LoadMoreMovieDataProtocol {
    
    func loadMoreTopRatedmoviesData(pageNO: Int, completionHandler:@escaping(Bool)->Void)
    func loadMoreNowPlayingMoviesData(pageNO: Int, completionHandler:@escaping(Bool)->Void)
    func loadMorePopularMoviesData(pageNO: Int,completionHandler:@escaping(Bool)->Void)
    func loadMoreUpComingMoviesData(pageNO: Int, completionHandler:@escaping(Bool)->Void)
    
}



protocol loadMoreTopRatedContent {
    func loadMoreTopRatedContentData(pageNO: Int, completionHandler:@escaping(Bool)->Void)
}

protocol loadMoreNowPlayingContent {
    func loadMoreNowPlayingContentData(pageNO: Int, completionHandler:@escaping(Bool)->Void)
}
protocol loadMorePopularContent {
   func loadMorePopularContentData(pageNO: Int,completionHandler:@escaping(Bool)->Void)
}

protocol loadMoreUpComingContent {
    func loadMoreUpComingContentData(pageNO: Int, completionHandler:@escaping(Bool)->Void)
}
