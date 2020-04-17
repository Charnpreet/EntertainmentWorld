//
//  MovieTableControllerExtensions.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 15/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation
import  UIKit

//extension MovieViewController: UITableViewDataSource, UITableViewDelegate{
//    
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return Constants.NO_OF_ROWS_IN_EACH_TABLE_SECTION
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let tablecell = tableView.dequeueReusableCell(withIdentifier: Constants.TABLE_VIEW_CELL_IDENTIFIER) as! MovieTableCell
//        if(indexPath.section==0){
//            tablecell.movies = popularMovies
//            
//        }
//        else if(indexPath.section==1){
//            tablecell.movies = nowPlayingMovies
//        }
//        else if(indexPath.section==2){
//            tablecell.movies = upComingMovies
//        }
//        if(indexPath.section==3){
//            tablecell.movies = topRatedmovies
//        }
//        return tablecell
//    }
//    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return Constants.MOVIE_CATEGORIES[section]
//    }
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return Constants.MOVIE_CATEGORIES.count
//    }
//    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        view.tintColor = UIColor.black
//        let header = view as! UITableViewHeaderFooterView
//        header.textLabel?.textColor = UIColor.white
//        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
//    }
//}
