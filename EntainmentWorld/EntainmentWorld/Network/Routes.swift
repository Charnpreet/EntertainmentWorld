//
//  Routes.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 11/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//
import Foundation
class Routes  {
    // Mark:- Movies Routes
    static let NOW_PLAYING_MOVIES_ROUTE = "movie/now_playing?api_key="
    static let LATEST_MOVIES_ROUTE = "movie/latest?api_key="
    static let POPULAR_MOVIES_ROUTE = "movie/popular?api_key="
    static let TOP_RATED_MOVIES_ROUTE = "movie/top_rated?api_key="
    static let UPCOMING_MOVIES_ROUTE = "movie/upcoming?api_key="
    
    //Mark:- TV Shows Routes
    static let POPULAR_TV_SHOWS = "tv/popular?api_key="
    static let TOP_RATED_TV_SHOWS = "tv/top_rated?api_key="
    static let SHOWS_ON_AIR = "tv/on_the_air?api_key="
    static let SHOWS_ON_AIR_TODAY = "tv/airing_today?api_key="
    
    // Mark:- Search Movie Routes
    static let SEARCH_MOVIES = "search/movie?api_key="
    static let SEARCH_QUERY = "&query="
    
    // Mark: - Movie Genre Routes
    static let MOVIE_GENRE = "genre/movie/list?api_key="
    
}
