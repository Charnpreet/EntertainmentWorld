//
//  TVShowsControllerExtension.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 15/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation
import UIKit


class DataSourceProviderForTable : NSObject{
    // MARK: - variables
    var storedOffsets = [Int: CGFloat]()
    let db = DBConnection()
    var screenSegus : DoSegus!
    let activityIndicator = ActivityIndicator.getActivityIndicator()
    // MARK: - popular shows variables
    var popularShowsDataSource : PopularShowsDataSource!
    
    // MARK: - Top Rated shows variables
    var topRatedShowsDataSource : TOPRatedShowsDataSource!
    // MARK: - on Air shows variables
    var onAirShowsDataSource : OnAirShowsDataSource!
    // MARK: - ON air Today shows variables
    var onAirTodayShowsDataSource : ONAirTodayShowsDataSource!
    
    // MARK: - class own methods
    // MARK: - these class own methods are used to load data from DB
    // loads popular shows
    func loadPopularShows (pageNO: Int,  completionHandler:@escaping(Bool)->Void){
        db.loadDataFromDB(pageNO: pageNO, route: Routes.POPULAR_TV_SHOWS, completionHandler:{ (shows: TVShowsResponse?, err) in
            if let err = err {
                print(err)
                completionHandler(false)
            } else{
                guard let shows = shows else{return}
                self.popularShowsDataSource.shows.append(contentsOf: shows.results.map({$0}))
                self.popularShowsDataSource.totalPages = shows.total_pages
                completionHandler(true)
            }
        })
    }
    
    func loadTopratedShows(pageNO: Int, completionHandler:@escaping(Bool)->Void){
        db.loadDataFromDB(pageNO: pageNO, route: Routes.TOP_RATED_TV_SHOWS, completionHandler:{ (shows: TVShowsResponse?, err) in
            if let err = err {
                print(err)
                completionHandler(false)
            } else{
                guard let shows = shows else{return}
                self.topRatedShowsDataSource.shows.append(contentsOf: shows.results.map({$0}))
                self.topRatedShowsDataSource.totalPages = shows.total_pages
                completionHandler(true)
            }
        })
    }
    
    func loadOnAirShows(pageNO: Int, completionHandler:@escaping(Bool)->Void){
        db.loadDataFromDB(pageNO: pageNO, route: Routes.SHOWS_ON_AIR, completionHandler:{ (shows: TVShowsResponse?, err) in
            if let err = err {
                print(err)
                completionHandler(false)
            } else{
                guard let shows = shows else{return}
                self.onAirShowsDataSource.shows.append(contentsOf: shows.results.map({$0}))
                
                self.onAirShowsDataSource.totalPages = shows.total_pages
                completionHandler(true)
            }
        })
    }
    //       issues while loading other pages
    func loadOnAirTodayShows(pageNO: Int, completionHandler:@escaping(Bool)->Void){
        db.loadDataFromDB(pageNO: pageNO, route: Routes.SHOWS_ON_AIR_TODAY, completionHandler:{ (shows: TVShowsResponse?, err) in
            if let err = err {
                print(err)
                completionHandler(false)
            } else{
                guard let shows = shows else{return}
                self.onAirTodayShowsDataSource.shows.append(contentsOf: shows.results.map({$0}))
                self.onAirTodayShowsDataSource.totalPages = shows.total_pages
                completionHandler(true)
            }
        })
    }
    
}
