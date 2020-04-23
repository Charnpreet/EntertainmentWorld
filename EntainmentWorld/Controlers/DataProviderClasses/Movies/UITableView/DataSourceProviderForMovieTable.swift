//
//  DataSourceProviderForMovieTable.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 17/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation
import UIKit
class DataSourceProviderForMovieTable : NSObject {
    // MARK: - variables
    var storedOffsets = [Int: CGFloat]()
    let db = DBConnection()
    var screenSegus : DoSegusForMovies!
    // MARK: - popular movies variables
    var currentPageForPopularMovies: Int = 1
    var totalPagesForPopularMovies: Int = 1
    var popularMoviesDataSource : PopularMoviesDataSource!
    
    // MARK: - Top Rated Movies variables
    var topRatedMoviesDataSource : TopRatedMoviesDataSource!
    var currentPageForTopRatedMovies: Int = 1
    var totaltPagesForTopRatedMovies:  Int = 1
    
    // MARK: - Upcoming Movies variable
    var upcomingMoviesDataSource : UpcomingMoviesDataSource!
    var currentPageForUpComingMovies : Int = 1
    var totalPagesForUpComingMovies : Int = 1
    
    // MARK: - NOW Playing Movies variables
    var currentPageForNowPlayingMovies: Int = 1
    var totalPagesForNowPlayingMovies: Int = 1
    var nowPlayingMoviesDataSource : NowPlayingMoviesDataSource!
    
    // MARK: - class own methods
    // this method is used when app first starts
    fileprivate func loadingDataFirstTime(tablecell: UItableCell, indexPath: IndexPath){
        
        loadTopratedMovies(pageNO: 1, completionHandler:{
            self.loadUpcomingMovies(pageNO: 1, completionHandler:{
                self.loadPopularMovies(pageNO: 1, completionHandler:{
                    self.NowPlayingMovies(pageNO: 1, completionHandler:{
                        self.initlizingCollectionViewWithDataSource(tablecell: tablecell, indexPath: indexPath)
                        tablecell.collectionViewOffset = self.storedOffsets[indexPath.row] ?? 0
                    })
                })
            })
        })
    }
    // MARK: - this method initilize the collection with data source
    // it uses sections to check which row to have which data source
    // as there is only one row in each section
    func initlizingCollectionViewWithDataSource(tablecell: UItableCell, indexPath: IndexPath){
        if(indexPath.section==0){
            tablecell.initializeCollectionViewWithDataSource(popularMoviesDataSource, delegate: popularMoviesDataSource, forRow: indexPath.row)
        }
        if(indexPath.section==1){
            tablecell.initializeCollectionViewWithDataSource(self.nowPlayingMoviesDataSource, delegate: self.nowPlayingMoviesDataSource, forRow: indexPath.row)
        }
        if(indexPath.section==2){
            tablecell.initializeCollectionViewWithDataSource(self.upcomingMoviesDataSource , delegate: self.upcomingMoviesDataSource , forRow: indexPath.row)
            
        }
        if(indexPath.section==3){
            tablecell.initializeCollectionViewWithDataSource(self.topRatedMoviesDataSource, delegate: self.topRatedMoviesDataSource, forRow: indexPath.row)
            
        }
        
        
    }
    
    // MARK: - these class own methods are used to load data from DB
    // loads popular movies
    func loadPopularMovies (pageNO: Int,  completionHandler:@escaping()->Void){
        db.loadContentFromDB(pageNO: pageNO, route:Routes.POPULAR_MOVIES_ROUTE  ,completionHandler: { (movies: MovieResponse) in
            for items in movies.results {
                self.popularMoviesDataSource.moviesList.append(items)
            }
            self.totalPagesForPopularMovies   = movies.total_pages
            completionHandler()
        })
        
    }
    
    func loadTopratedMovies(pageNO: Int, completionHandler:@escaping()->Void){
        db.loadContentFromDB(pageNO: pageNO, route: Routes.TOP_RATED_MOVIES_ROUTE,completionHandler: { (movies : MovieResponse) in
            for movie in movies.results {
                self.topRatedMoviesDataSource.moviesList.append(movie)
            }
            self.totaltPagesForTopRatedMovies = movies.total_pages
            completionHandler()
        })
        
    }
    //
    func loadUpcomingMovies(pageNO: Int, completionHandler:@escaping()->Void){
        db.loadContentFromDB(pageNO: pageNO, route:Routes.UPCOMING_MOVIES_ROUTE ,completionHandler: {(movies: MovieResponceWithDates)  in
            for movie in movies.results {
                self.upcomingMoviesDataSource.moviesList.append(movie)
            }
            self.totalPagesForUpComingMovies = movies.total_pages
            completionHandler()
        })
    }
    //    //       issues while loading other pages
    func NowPlayingMovies(pageNO: Int, completionHandler:@escaping()->Void){
        db.loadContentFromDB(pageNO: pageNO, route:Routes.NOW_PLAYING_MOVIES_ROUTE ,completionHandler: {(movies: MovieResponceWithDates) in
            for movie in movies.results {
                self.nowPlayingMoviesDataSource.moviesList.append(movie)
            }
            self.totalPagesForNowPlayingMovies = movies.total_pages
            completionHandler()
        })
        
    }
}


//Mark:-
extension DataSourceProviderForMovieTable : UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.NO_OF_ROWS_IN_EACH_TABLE_SECTION
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tablecell = tableView.dequeueReusableCell(withIdentifier: Constants.TABLE_VIEW_CELL_IDENTIFIER) as! UItableCell
        
        nowPlayingMoviesDataSource  = NowPlayingMoviesDataSource()
        nowPlayingMoviesDataSource.loadMoreContent = self
        nowPlayingMoviesDataSource.delegate = self
        upcomingMoviesDataSource    = UpcomingMoviesDataSource()
        upcomingMoviesDataSource.loadMoreContent = self
        upcomingMoviesDataSource.delegate = self
        popularMoviesDataSource     =  PopularMoviesDataSource()
        popularMoviesDataSource.loadMoreContent = self
        popularMoviesDataSource.delegate = self
        topRatedMoviesDataSource    = TopRatedMoviesDataSource()
        topRatedMoviesDataSource.loadMoreContent = self
        topRatedMoviesDataSource.delegate = self
        
        self.loadingDataFirstTime(tablecell: tablecell, indexPath: indexPath)
        return tablecell
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TABLE_VIEW_CELL_IDENTIFIER, for: indexPath) as! UItableCell
        storedOffsets[indexPath.row] = cell.collectionViewOffset
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Constants.MOVIE_CATEGORIES[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.MOVIE_CATEGORIES.count
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.black
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
    }
    
    
}

// MARK: - Extension for implmenting protocol of loading more data


extension DataSourceProviderForMovieTable :LoadMoreMovieDataProtocol{
    
    func loadMoreTopRatedmoviesData(completionHandler: @escaping () -> Void) {
        currentPageForTopRatedMovies += 1
        print(currentPageForTopRatedMovies)
        if(currentPageForTopRatedMovies <= totaltPagesForTopRatedMovies){
            loadTopratedMovies(pageNO: currentPageForTopRatedMovies, completionHandler: {
                completionHandler()
            })
        }
    }
    
    func loadMoreNowPlayingMoviesData(completionHandler: @escaping () -> Void) {
        currentPageForNowPlayingMovies += 1
        print(currentPageForNowPlayingMovies)
        if(currentPageForNowPlayingMovies <= totalPagesForNowPlayingMovies){
            loadUpcomingMovies(pageNO: currentPageForNowPlayingMovies , completionHandler:{
                completionHandler()
            })
        }
    }
    
    
    
    func loadMorePopularMoviesData(completionHandler: @escaping () -> Void) {
        currentPageForPopularMovies += 1
        //
        print(currentPageForPopularMovies)
        if(currentPageForPopularMovies  <= totalPagesForPopularMovies){
            loadPopularMovies(pageNO: currentPageForPopularMovies, completionHandler: {
                completionHandler()
            })
        }
    }
    func loadMoreUpComingMoviesData(completionHandler: @escaping () -> Void) {
        currentPageForUpComingMovies += 1
        //
        print(currentPageForUpComingMovies)
        if(currentPageForUpComingMovies  <= totalPagesForUpComingMovies){
            loadUpcomingMovies(pageNO: currentPageForUpComingMovies, completionHandler: {
                completionHandler()
            })
        }
    }
}


extension DataSourceProviderForMovieTable:  MovieCollectionViewSelectedProtocol {
    
    func collectionViewSelected(item : MoviesDetails) //_ collectionViewItem : Int
    {
        print("collection view selected")
        self.screenSegus.LoadSegus(item: item)
    }

}

