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
                self.totalPagesForPopularMovies   = movies.total_pages
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
                self.totaltPagesForTopRatedMovies = movies.total_pages
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
                self.totalPagesForUpComingMovies = movies.total_pages
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
                self.totalPagesForNowPlayingMovies = movies.total_pages
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
        
        if(indexPath.section==0){
            
            popularMoviesDataSource     =  PopularMoviesDataSource()
            popularMoviesDataSource.loadMoreContent = self
            popularMoviesDataSource.delegate = self
            print(popularMoviesDataSource.moviesList.count)
            loadPopularMovies(pageNO: 1, completionHandler:{(loaded) in
                cell.initializeCollectionViewWithDataSource(self.popularMoviesDataSource, delegate: self.popularMoviesDataSource, forRow: indexPath.row)
                cell.collectionViewOffset = self.storedOffsets[indexPath.row] ?? 0
            })
        }
        
        if(indexPath.section==1){
                  nowPlayingMoviesDataSource  = NowPlayingMoviesDataSource()
                  nowPlayingMoviesDataSource.loadMoreContent = self
                  nowPlayingMoviesDataSource.delegate = self
                  NowPlayingMovies(pageNO: 1, completionHandler:{(loaded) in
                      cell.initializeCollectionViewWithDataSource(self.nowPlayingMoviesDataSource, delegate: self.nowPlayingMoviesDataSource, forRow: indexPath.row)
                     cell.collectionViewOffset = self.storedOffsets[indexPath.row] ?? 0
                  })
                  
              }
              if(indexPath.section==2){
                  
                  upcomingMoviesDataSource    = UpcomingMoviesDataSource()
                  upcomingMoviesDataSource.loadMoreContent = self
                  upcomingMoviesDataSource.delegate = self
                  self.loadUpcomingMovies(pageNO: 1, completionHandler:{(loaded) in
                      cell.initializeCollectionViewWithDataSource(self.upcomingMoviesDataSource , delegate: self.upcomingMoviesDataSource , forRow: indexPath.row)
                      cell.collectionViewOffset = self.storedOffsets[indexPath.row] ?? 0
                  })
              }
              if(indexPath.section==3){
                  
                  topRatedMoviesDataSource    = TopRatedMoviesDataSource()
                  topRatedMoviesDataSource.loadMoreContent = self
                  topRatedMoviesDataSource.delegate = self
                  loadTopratedMovies(pageNO: 1, completionHandler:{(loaded) in
                      cell.initializeCollectionViewWithDataSource(self.topRatedMoviesDataSource, delegate: self.topRatedMoviesDataSource, forRow: indexPath.row)
                      cell.collectionViewOffset = self.storedOffsets[indexPath.row] ?? 0
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
        view.tintColor = UIColor.black
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
    }
}

// MARK: - Extension for implmenting protocol of loading more data


extension DataSourceProviderForMovieTable :LoadMoreMovieDataProtocol{
    func loadMoreTopRatedmoviesData(completionHandler: @escaping (Bool) -> Void) {
        currentPageForTopRatedMovies += 1
        if(currentPageForTopRatedMovies <= totaltPagesForTopRatedMovies){
            loadTopratedMovies(pageNO: currentPageForTopRatedMovies, completionHandler: {(loaded) in
                if(loaded){
                    completionHandler(true)
                    
                }else{
                    print("unable to load more top rated movies")
                    completionHandler(false)
                }
            })
        }else{
            print("no more pages to load")
            completionHandler(false)
        }
    }
    
    
    // not loadinf more than 1 page
    func loadMoreNowPlayingMoviesData(completionHandler: @escaping (Bool) -> Void) {
        currentPageForNowPlayingMovies += 1
        if(currentPageForNowPlayingMovies <= totalPagesForNowPlayingMovies){
            NowPlayingMovies(pageNO: currentPageForNowPlayingMovies , completionHandler:{(loaded) in
                if(loaded){
                    completionHandler(true)
                    
                }else{
                    print("unable to load more now playing movies")
                    completionHandler(false)
                }
            })
        }else{
            print("no more pages to load")
            completionHandler(false)
        }
    }
    
    
    // not loadinf more than 1 page
    func loadMorePopularMoviesData(completionHandler: @escaping (Bool) -> Void) {
        currentPageForPopularMovies += 1
        if(currentPageForPopularMovies  <= totalPagesForPopularMovies){
            loadPopularMovies(pageNO: currentPageForPopularMovies, completionHandler: {(loaded) in
                if(loaded){
                    completionHandler(true)
                    
                }else{
                    print("unable to load popular movies")
                    completionHandler(false)
                }
            })
        }else{
            print("no more pages to load")
            completionHandler(false)
        }
    }
    
    func loadMoreUpComingMoviesData(completionHandler: @escaping (Bool) -> Void) {
        currentPageForUpComingMovies += 1
        if(currentPageForUpComingMovies  <= totalPagesForUpComingMovies){
            loadUpcomingMovies(pageNO: currentPageForUpComingMovies, completionHandler:{(loaded) in
                if(loaded){
                    completionHandler(true)
                    
                }else{
                    print("unable to load more upcoming movies")
                    completionHandler(false)
                }
            })
        }else{
            print("no more pages to load")
            completionHandler(false)
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

