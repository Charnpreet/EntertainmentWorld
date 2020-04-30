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
    var currentPageForPopularShows: Int = 1
    var totalPagesForPopularShows: Int = 1
    var popularShowsDataSource : PopularShowsDataSource!
    
    // MARK: - Top Rated shows variables
    var topRatedShowsDataSource : TOPRatedShowsDataSource!
    var currentPageForTopRatedShows: Int = 1
    var totaltPagesForTopRatedShows: Int = 1
    // MARK: - on Air shows variables
    var onAirShowsDataSource : OnAirShowsDataSource!
    var currentPageForOnAirShows : Int = 1
    var totalPagesForOnAirShows : Int = 1
    // MARK: - ON air Today shows variables
    var currentPageForOnAirTodayShows: Int = 1
    var totalPagesForOnAirTodayShows: Int = 1
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
                self.totalPagesForPopularShows = shows.total_pages
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
                self.totaltPagesForTopRatedShows = shows.total_pages
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
                
                self.totalPagesForOnAirShows = shows.total_pages
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
                self.totalPagesForOnAirTodayShows = shows.total_pages
                completionHandler(true)
            }
        })
    }
    
}

// MARK: - Extension for Uitableview Datasource and View Delegate
extension DataSourceProviderForTable : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.NO_OF_ROWS_IN_EACH_TABLE_SECTION
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tablecell = tableView.dequeueReusableCell(withIdentifier: Constants.TABLE_VIEW_CELL_IDENTIFIER, for: indexPath) as! UItableCell
        
        let cellBckgrdView = UIView()
        cellBckgrdView.backgroundColor = .clear
        tablecell.selectedBackgroundView = cellBckgrdView    // on click while hide custom color
        
        
        return tablecell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tablecell = cell as? UItableCell else { return}
        cell.addSubview(activityIndicator)
        activityIndicator.center = cell.center
        activityIndicator.startAnimating()
        
        if(indexPath.section==0){
            popularShowsDataSource      = PopularShowsDataSource()
            popularShowsDataSource.loadMoreContent = self
            popularShowsDataSource.delegate = self
            self.loadPopularShows(pageNO: 1, completionHandler:{(loaded) in
                if(loaded){
                    tablecell.initializeCollectionViewWithDataSource(self.popularShowsDataSource, delegate: self.popularShowsDataSource, forRow: indexPath.row)
                    tablecell.collectionViewOffset = self.storedOffsets[indexPath.row] ?? 0
                    
                }else{
                    self.activityIndicator.stopAnimating()
                    
                    print("unable to load erro")
                }
                
            })
        }
        if(indexPath.section==1){
            
            topRatedShowsDataSource     = TOPRatedShowsDataSource()
            topRatedShowsDataSource.loadMoreContent = self
            topRatedShowsDataSource.delegate = self
            
            
            self.loadTopratedShows(pageNO: 1, completionHandler:{(loaded) in
                
                if(loaded){
                    tablecell.initializeCollectionViewWithDataSource(self.topRatedShowsDataSource, delegate: self.topRatedShowsDataSource, forRow: indexPath.row)
                    tablecell.collectionViewOffset = self.storedOffsets[indexPath.row] ?? 0
                    self.activityIndicator.stopAnimating()
                    
                }else{
                    self.activityIndicator.stopAnimating()
                }
                
            })
        }
        if(indexPath.section==2){
            
            onAirShowsDataSource = OnAirShowsDataSource()
            onAirShowsDataSource.loadMoreContent = self
            onAirShowsDataSource.delegate = self
            
            
            self.loadOnAirShows(pageNO: 1, completionHandler:{(loaded) in
                if(loaded){
                    tablecell.initializeCollectionViewWithDataSource(self.onAirShowsDataSource , delegate: self.onAirShowsDataSource , forRow: indexPath.row)
                    tablecell.collectionViewOffset = self.storedOffsets[indexPath.row] ?? 0
                    self.activityIndicator.stopAnimating()
                    
                }else{
                    self.activityIndicator.stopAnimating()
                }
            })
        }
        if(indexPath.section==3){
            
            onAirTodayShowsDataSource   = ONAirTodayShowsDataSource()
            onAirTodayShowsDataSource.loadMoreContent = self
            onAirTodayShowsDataSource.delegate = self
            
            
            self.loadOnAirTodayShows(pageNO: 1, completionHandler:{(loaded) in
                if(loaded){
                    tablecell.initializeCollectionViewWithDataSource(self.onAirTodayShowsDataSource, delegate: self.onAirTodayShowsDataSource, forRow: indexPath.row)
                    tablecell.collectionViewOffset = self.storedOffsets[indexPath.row] ?? 0
                    self.activityIndicator.stopAnimating()
                }else{
                    self.activityIndicator.stopAnimating()
                }
                
            })
        }
    }
    
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TABLE_VIEW_CELL_IDENTIFIER, for: indexPath) as! UItableCell
        storedOffsets[indexPath.row] = cell.collectionViewOffset
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Constants.TV_SHOW_CATEGORIES[section]
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return Constants.TV_SHOW_CATEGORIES.count
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = BackGroundColor.getBackgrndClr()
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor =  BackGroundColor.textColor()
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
    }
}

// MARK: - Extension for implmenting protocol of loading more data


extension DataSourceProviderForTable : LoadMoreDataProtocol{
    
    func loadMoreOnAirTodayShowData(completionHandler: @escaping (Bool) -> Void) {
        currentPageForOnAirTodayShows += 1
        if(currentPageForOnAirTodayShows <= totalPagesForOnAirTodayShows){
            loadOnAirTodayShows(pageNO: currentPageForOnAirTodayShows, completionHandler:{ (result) in
                completionHandler(result)
            })
        }
    }
    
    func loadMorePopularShowData(completionHandler: @escaping (Bool) -> Void) {
        currentPageForPopularShows += 1
        if(currentPageForPopularShows <= totalPagesForPopularShows){
            loadPopularShows(pageNO: currentPageForPopularShows, completionHandler:{(result) in
                completionHandler(result)
            })
        }
    }
    
    func loadMoreTopRatedShowData(completionHandler: @escaping (Bool) -> Void) {
        currentPageForTopRatedShows += 1
        if(currentPageForTopRatedShows <= totaltPagesForTopRatedShows){
            loadTopratedShows(pageNO: currentPageForTopRatedShows, completionHandler:{ (result) in
                completionHandler(result)
            })
        }
        
    }
    
    func loadMoreOnAirShowData(completionHandler:@escaping(Bool)->Void) {
        currentPageForOnAirShows += 1
        if(currentPageForOnAirShows <= totalPagesForOnAirShows) {
            loadOnAirShows(pageNO: currentPageForOnAirShows, completionHandler:{ (result) in
             completionHandler(result)
            })
        }
        
    }
}

extension DataSourceProviderForTable : CollectionViewSelectedProtocol {
    
    func collectionViewSelected(item : TVShows) {
        self.screenSegus.LoadSegus(item: item)
    }
    
}
