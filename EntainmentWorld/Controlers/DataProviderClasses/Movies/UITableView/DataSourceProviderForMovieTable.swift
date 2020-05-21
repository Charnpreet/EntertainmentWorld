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
    let activityIndicator = ActivityIndicator.getActivityIndicator()
    
    // MARK: - popular movies variables
    var popularMoviesDataSource : PopularMoviesDataSource!
    
    // MARK: - Top Rated Movies variables
    var topRatedMoviesDataSource : TopRatedMoviesDataSource!
    // MARK: - Upcoming Movies variable
    var upcomingMoviesDataSource : UpcomingMoviesDataSource!
    
    // MARK: - NOW Playing Movies variables
    var nowPlayingMoviesDataSource : NowPlayingMoviesDataSource!
    
    // MARK: - class own methods
    
    // MARK: - these class own methods are used to load data from DB
    // loads popular movies
    func loadPopularMovies (pageNO: Int,  completionHandler:@escaping(Bool)->Void){
        db.loadDataFromDB(pageNO: pageNO, route: Routes.POPULAR_MOVIES_ROUTE, completionHandler:{ (movies: MovieResponse?, err) in
            if let err = err {
                print(err)
                completionHandler(false)
            } else{
                guard let movies = movies else{return}
                self.popularMoviesDataSource.moviesList.append(contentsOf: movies.results.map({$0}))
                self.popularMoviesDataSource.totalPages = movies.total_pages
                completionHandler(true)
            }
        })
    }
    
    func loadTopratedMovies(pageNO: Int, completionHandler:@escaping(Bool)->Void){
        db.loadDataFromDB(pageNO: pageNO, route: Routes.TOP_RATED_MOVIES_ROUTE, completionHandler:{ (movies: MovieResponse?, err) in
            if let err = err {
                print(err)
                completionHandler(false)
            } else{
                guard let movies = movies else{return}
                self.topRatedMoviesDataSource.moviesList.append(contentsOf: movies.results.map({$0}))
                self.topRatedMoviesDataSource.totalPages = movies.total_pages
                completionHandler(true)
                
            }
        })
        
    }
    //
    func loadUpcomingMovies(pageNO: Int, completionHandler:@escaping(Bool)->Void){
        db.loadDataFromDB(pageNO: pageNO, route: Routes.UPCOMING_MOVIES_ROUTE, completionHandler:{ (movies: MovieResponse?, err) in
            if let err = err {
                print(err)
                completionHandler(false)
            } else{
                guard let movies = movies else{return}
                self.upcomingMoviesDataSource.moviesList.append(contentsOf: movies.results.map({$0}))
                self.upcomingMoviesDataSource.totalPages = movies.total_pages
                completionHandler(true)
                
            }
        })
        
    }
    //    //
    func NowPlayingMovies(pageNO: Int, completionHandler:@escaping(Bool)->Void){
        db.loadDataFromDB(pageNO: pageNO, route: Routes.NOW_PLAYING_MOVIES_ROUTE, completionHandler:{ (movies: MovieResponse?, err) in
            if let err = err {
                print(err)
                completionHandler(false)
            } else{
                guard let movies = movies else{return}
                self.nowPlayingMoviesDataSource.moviesList.append(contentsOf: movies.results.map({$0}))
                self.nowPlayingMoviesDataSource.totalPages = movies.total_pages
                completionHandler(true)
                
            }
        })
    }
}


//Mark:-
extension DataSourceProviderForMovieTable : UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.NO_OF_ROWS_IN_EACH_TABLE_SECTION
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TABLE_VIEW_CELL_IDENTIFIER) as! UItableCell
        let cellBckgrdView = UIView()
        cellBckgrdView.backgroundColor = .clear
        cell.selectedBackgroundView = cellBckgrdView    // on click while hide custom color
        cell.addSubview(activityIndicator)
        activityIndicator.center = cell.center
        activityIndicator.startAnimating()
        if(indexPath.section==0){
            popularMoviesDataSource    =  PopularMoviesDataSource()
            popularMoviesDataSource.loadMoreContent = self
            popularMoviesDataSource.delegate = self
            loadPopularMovies(pageNO: popularMoviesDataSource.currentPage, completionHandler:{(loaded) in
                if(loaded){
                    cell.initializeCollectionViewWithDataSource(self.popularMoviesDataSource, delegate: self.popularMoviesDataSource, forRow: indexPath.row)
                    cell.collectionViewOffset = self.storedOffsets[indexPath.row] ?? 0
                    self.activityIndicator.stopAnimating()
                }else{
                    self.activityIndicator.stopAnimating()
                }
            })
        }
        
        if(indexPath.section==1){
            nowPlayingMoviesDataSource  = NowPlayingMoviesDataSource()
            nowPlayingMoviesDataSource.loadMoreContent = self
            nowPlayingMoviesDataSource.delegate = self
            NowPlayingMovies(pageNO: nowPlayingMoviesDataSource.currentPage, completionHandler:{(loaded) in
                if(loaded){
                    cell.initializeCollectionViewWithDataSource(self.nowPlayingMoviesDataSource, delegate: self.nowPlayingMoviesDataSource, forRow: indexPath.row)
                    cell.collectionViewOffset = self.storedOffsets[indexPath.row] ?? 0
                    self.activityIndicator.stopAnimating()
                }else{
                    self.activityIndicator.stopAnimating()
                }

            })

        }
        if(indexPath.section==2){

            upcomingMoviesDataSource = UpcomingMoviesDataSource()
            upcomingMoviesDataSource.loadMoreContent = self
            upcomingMoviesDataSource.delegate = self
            loadUpcomingMovies(pageNO: upcomingMoviesDataSource.currentPage, completionHandler:{(loaded) in
                if(loaded){
                    cell.initializeCollectionViewWithDataSource(self.upcomingMoviesDataSource , delegate: self.upcomingMoviesDataSource , forRow: indexPath.row)
                    cell.collectionViewOffset = self.storedOffsets[indexPath.row] ?? 0
                    self.activityIndicator.stopAnimating()
                }else{
                    self.activityIndicator.stopAnimating()
                }

            })

        }
        if(indexPath.section==3){

            topRatedMoviesDataSource    = TopRatedMoviesDataSource()
            topRatedMoviesDataSource.loadMoreContent = self
            topRatedMoviesDataSource.delegate = self
            loadTopratedMovies(pageNO: topRatedMoviesDataSource.currentPage, completionHandler:{(loaded) in
                if(loaded){
                    cell.initializeCollectionViewWithDataSource(self.topRatedMoviesDataSource, delegate: self.topRatedMoviesDataSource, forRow: indexPath.row)
                    cell.collectionViewOffset = self.storedOffsets[indexPath.row] ?? 0
                    self.activityIndicator.stopAnimating()
                }else{
                    self.activityIndicator.stopAnimating()
                }

            })

        }
        return cell
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
        view.tintColor = BackGroundColor.getBackgrndClr()
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = BackGroundColor.textColor()
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
    }
}

// MARK: - Extension for implmenting protocol of loading more data


extension DataSourceProviderForMovieTable :LoadMoreMovieDataProtocol{
    func loadMoreTopRatedmoviesData(pageNO: Int, completionHandler: @escaping (Bool) -> Void) {
        loadTopratedMovies(pageNO: pageNO, completionHandler: {(result) in
            completionHandler(result)
        })
    }
    
    
    // not loadinf more than 1 page
    func loadMoreNowPlayingMoviesData(pageNO: Int, completionHandler: @escaping (Bool) -> Void) {
        NowPlayingMovies(pageNO: pageNO , completionHandler:{(result) in
            completionHandler(result)
        })
        
    }
    
    // not loadinf more than 1 page
    func loadMorePopularMoviesData(pageNO: Int,completionHandler: @escaping (Bool) -> Void) {
        loadPopularMovies(pageNO: pageNO, completionHandler: {(result) in
            completionHandler(result)
        })
    }
    
    func loadMoreUpComingMoviesData(pageNO: Int,completionHandler: @escaping (Bool) -> Void) {
        loadUpcomingMovies(pageNO: pageNO, completionHandler:{(result) in
            completionHandler(result)
        })
    }
}
extension DataSourceProviderForMovieTable:  MovieCollectionViewSelectedProtocol {
    
    func collectionViewSelected(item : MoviesDetails) //_ collectionViewItem : Int
    {
        self.screenSegus.LoadSegus(item: item)
    }
    
}

