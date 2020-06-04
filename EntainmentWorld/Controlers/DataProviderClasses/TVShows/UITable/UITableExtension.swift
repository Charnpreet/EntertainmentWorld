//
//  UITableExtension.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 1/5/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation
import UIKit
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
            self.loadPopularShows(pageNO: popularShowsDataSource.currentPage, completionHandler:{(loaded) in
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
            
            
            self.loadTopratedShows(pageNO: topRatedShowsDataSource.currentPage, completionHandler:{(loaded) in
                
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
            
            
            self.loadOnAirShows(pageNO: onAirShowsDataSource.currentPage, completionHandler:{(loaded) in
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
            
            
            self.loadOnAirTodayShows(pageNO: onAirTodayShowsDataSource.currentPage, completionHandler:{(loaded) in
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
        // return the number of sections
        return Constants.TV_SHOW_CATEGORIES.count
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = BackGroundColor.getBackgrndClr()
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor =  BackGroundColor.textColor()
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
    }
}
