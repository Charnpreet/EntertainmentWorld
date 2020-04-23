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
    // MARK: - popular shows variables
  //  var popularShows: [TVShows] = []
    var currentPageForPopularShows: Int = 1
    var totalPagesForPopularShows: Int = 1
    var popularShowsDataSource : PopularShowsDataSource!
    
     // MARK: - Top Rated shows variables
    var topRatedShowsDataSource : TOPRatedShowsDataSource!
   // var TOPRatedShows: [TVShows] = []
    var currentPageForTopRatedShows: Int = 1
    var totaltPagesForTopRatedShows: Int = 1
    
     // MARK: - on Air shows variables
    var onAirShowsDataSource : OnAirShowsDataSource!
   // var OnAirShows: [TVShows] = []
    var currentPageForOnAirShows : Int = 1
    var totalPagesForOnAirShows : Int = 1
    
     // MARK: - ON air Today shows variables
  //  var ONAirTodayShows: [TVShows] = []
    var currentPageForOnAirTodayShows: Int = 1
    var totalPagesForOnAirTodayShows: Int = 1
    var onAirTodayShowsDataSource : ONAirTodayShowsDataSource!
    
    
    // MARK: - class own methods
    // this method is used when app first starts
    fileprivate func loadingDataFirstTime(tablecell: UItableCell, indexPath: IndexPath){
        loadPopularShows (pageNO: 1,  completionHandler: {
        })
        loadTopratedShows(pageNO: 1, completionHandler:{
            self.loadOnAirShows(pageNO: 1, completionHandler:{
                self.loadOnAirTodayShows(pageNO: 1, completionHandler:{
                    self.initlizingCollectionViewWithDataSource(tablecell: tablecell, indexPath: indexPath)
                    tablecell.collectionViewOffset = self.storedOffsets[indexPath.row] ?? 0
                })
            })
        })
    }
    
    // MARK: - this method initilize the collection with data source
    // it uses sections to check which row to have which data source
    // as there is only one row in each section
    func initlizingCollectionViewWithDataSource(tablecell: UItableCell, indexPath: IndexPath){
        if(indexPath.section==0){
            tablecell.initializeCollectionViewWithDataSource(self.popularShowsDataSource, delegate: self.popularShowsDataSource, forRow: indexPath.row)
        }
        if(indexPath.section==1){
            tablecell.initializeCollectionViewWithDataSource(self.topRatedShowsDataSource, delegate: self.topRatedShowsDataSource, forRow: indexPath.row)
            
        }
        if(indexPath.section==2){
            tablecell.initializeCollectionViewWithDataSource(self.onAirShowsDataSource , delegate: self.onAirShowsDataSource , forRow: indexPath.row)
            
        }
        if(indexPath.section==3){
            tablecell.initializeCollectionViewWithDataSource(self.onAirTodayShowsDataSource, delegate: self.onAirTodayShowsDataSource, forRow: indexPath.row)
        }
    }
    // MARK: - these class own methods are used to load data from DB
    // loads popular shows
    func loadPopularShows (pageNO: Int,  completionHandler:@escaping()->Void){
        db.loadContentFromDB(pageNO: pageNO, route: Routes.POPULAR_TV_SHOWS,completionHandler: { (shows : TVShowsResponse) in
            for items in shows.results {
               // self.popularShows.append(items)
                self.popularShowsDataSource.shows.append(items)
            }
            self.totalPagesForPopularShows = shows.total_pages
            completionHandler()
        })
    }
    
    func loadTopratedShows(pageNO: Int, completionHandler:@escaping()->Void){
        self.db.loadContentFromDB(pageNO: 1, route:Routes.TOP_RATED_TV_SHOWS  ,completionHandler: { (shows: TVShowsResponse) in
            for items in shows.results {
                 self.topRatedShowsDataSource.shows.append(items)
               // self.popularShowsDataSource.shows.append(items)
            }
            self.totaltPagesForTopRatedShows = shows.total_pages
            completionHandler()
        })
    }
    
    func loadOnAirShows(pageNO: Int, completionHandler:@escaping()->Void){
        self.db.loadContentFromDB(pageNO: 1, route:Routes.SHOWS_ON_AIR ,completionHandler: {(shows: TVShowsResponse) in
            for items in shows.results {
                self.onAirShowsDataSource.shows.append(items)
            }
            self.totalPagesForOnAirShows = shows.total_pages
            completionHandler()
        })
    }
    //       issues while loading other pages
    func loadOnAirTodayShows(pageNO: Int, completionHandler:@escaping()->Void){
        self.db.loadContentFromDB(pageNO: pageNO, route:Routes.SHOWS_ON_AIR_TODAY ,completionHandler: {(shows: TVShowsResponse)  in
            self.onAirTodayShowsDataSource.shows = shows.results
             self.totalPagesForOnAirTodayShows = shows.total_pages
            completionHandler()
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
        
        popularShowsDataSource      = PopularShowsDataSource()
        popularShowsDataSource.loadMoreContent = self
        popularShowsDataSource.delegate = self
        
        topRatedShowsDataSource     = TOPRatedShowsDataSource()
        topRatedShowsDataSource.loadMoreContent = self
        topRatedShowsDataSource.delegate = self
        
        onAirShowsDataSource        = OnAirShowsDataSource()
        onAirShowsDataSource.loadMoreContent = self
        onAirShowsDataSource.delegate = self
        onAirTodayShowsDataSource   = ONAirTodayShowsDataSource()
        onAirTodayShowsDataSource.loadMoreContent = self
        onAirTodayShowsDataSource.delegate = self
        self.loadingDataFirstTime(tablecell: tablecell, indexPath: indexPath)
        return tablecell
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
        view.tintColor = UIColor.black
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
    }
}

// MARK: - Extension for implmenting protocol of loading more data


extension DataSourceProviderForTable : LoadMoreDataProtocol{
    func loadMoreOnAirTodayShowData(completionHandler: @escaping () -> Void) {
        currentPageForOnAirTodayShows += 1
        if(currentPageForOnAirTodayShows <= totalPagesForOnAirTodayShows){
            loadOnAirTodayShows(pageNO: currentPageForOnAirTodayShows, completionHandler:{
                print("loading completed for On Air Today")
                completionHandler()
            })
        }
    }
    
    func loadMorePopularShowData(completionHandler: @escaping () -> Void) {
        currentPageForPopularShows += 1
        if(currentPageForPopularShows <= totalPagesForPopularShows){
            print("unable load popular show")
           completionHandler()
        }
    }
    
    func loadMoreTopRatedShowData(completionHandler: @escaping () -> Void) {
        currentPageForTopRatedShows += 1
        if(currentPageForTopRatedShows <= totaltPagesForTopRatedShows){
            loadTopratedShows(pageNO: currentPageForTopRatedShows, completionHandler:{
                       print("loading completed for Top Rated Shows")
                       completionHandler()
                   })
        }
    }
    
    func loadMoreOnAirShowData(completionHandler:@escaping()->Void) {
        currentPageForOnAirShows += 1
        if(currentPageForOnAirShows <= totalPagesForOnAirShows) {
            loadOnAirShows(pageNO: currentPageForOnAirShows, completionHandler:{
                      print("loading completed on air show")
                      completionHandler()
                  })
        }
        else{
        }
      
    }
}

extension DataSourceProviderForTable : CollectionViewSelectedProtocol {

    func collectionViewSelected(item : TVShows) {
        self.screenSegus.LoadSegus(item: item)
    }
    
}
