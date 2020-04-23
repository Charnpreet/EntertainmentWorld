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
    
    // Mark:- Search
    static let SEARCH_QUERY = "&query="
        // Mark:- Search Movie Routes
    static let SEARCH_MOVIES = "search/movie?api_key="
        // Mark:- search TV Shows Routes
    static let SEARCH_SHOWS = "search/tv?api_key="
    
    
    //Browes By Genre
        // Mark: - Movie Genre Routes
    static let MOVIE_GENRE = "genre/movie/list?api_key="
    static let DISCOVER_MOVIES_BY_GENRE_ID = "discover/movie?api_key="
    static let MOVIE_GENRE_ID = "&with_genres="
     // Mark: - TV Shows Genre Routes
    static let TV_SHOWS_GENRE = "genre/tv/list?api_key="
    static let DISCOVER_SHOWS_BY_GENRE_ID = "discover/tv?api_key="
    
    
// Mark: - Video Route For Movies AND TV Shoes
   static let VIDEO_ROUTE = "/videos?api_key="
    // movie content type
     static let MOVIE_CONTENT_TYPE = "movie/"
    // tv show content type
    static let TV_SHOWS_CONTENT_TYPE = "tv/"
    
// Mark: - Youtube video Url Route
    
    static let YOUTUBE_VIDEO_URL = "https://www.youtube.com/watch?v="
}
