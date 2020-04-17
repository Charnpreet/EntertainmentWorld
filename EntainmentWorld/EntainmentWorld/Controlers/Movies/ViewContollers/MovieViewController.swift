//
//  MovieViewController.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 7/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit
class MovieViewController: UIViewController {
    //var table : UITableView!
    var dataProvider : DataSourceProviderForMovieTable!
    var table : CustomTable!
    var safeArea: UILayoutGuide!
//    var topRatedmovies :[MoviesDetails] = []
//    var nowPlayingMovies: [MoviesDetails] = []
//    var popularMovies: [MoviesDetails] = []
//    var upComingMovies: [MoviesDetails] = []
   // let db = DBConnection()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        intialSetup()
        // self.table.sectionHeaderHeight = 70
    }
    
    // inital setup for Movies controller
    func intialSetup(){
        setUptable()
        dataProvider = DataSourceProviderForMovieTable()
        table.dataSource = dataProvider
        table.delegate  = dataProvider
        navigationBarSetUp()
      //  loadingData(pageNO: 1)
        
    }
    //setup table view
    func setUptable(){
        let frame = CGRect(x: 0, y: 0, width: Constants.IOS_SCREEN_WIDTH, height: Constants.IOS_SCREEN_HEIGHT)
              table = CustomTable(frame: frame, style: .plain)
        table.register(MovieTableCell.self, forCellReuseIdentifier: Constants.TABLE_VIEW_CELL_IDENTIFIER)
        view.addSubview(table)
        TableConstraints.addConstraintsToTable(view: view, table : table)
        self.table.rowHeight = Constants.IOS_SCREEN_HEIGHT/5
    }
    
    func navigationBarSetUp(){
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationController?.navigationBar.topItem?.title = "Movies"
    }
//    func loadingData(pageNO: Int){
//
//        db.loadMoviesFromDB(pageNO: pageNO, route: Routes.TOP_RATED_MOVIES_ROUTE,completionHandler: { (movies : MovieResponse) in
//            self.topRatedmovies = movies.results
//            self.table.reloadData()
//        })
//        db.loadMoviesFromDB(pageNO: pageNO, route:Routes.POPULAR_MOVIES_ROUTE  ,completionHandler: { (movies: MovieResponse) in
//            self.popularMovies = movies.results
//            self.table.reloadData()
//        })
//        db.loadMoviesFromDB(pageNO: pageNO, route:Routes.NOW_PLAYING_MOVIES_ROUTE ,completionHandler: {(movies: MovieResponceWithDates) in
//            self.nowPlayingMovies = movies.results
//            self.table.reloadData()
//        })
//        db.loadMoviesFromDB(pageNO: pageNO, route:Routes.UPCOMING_MOVIES_ROUTE ,completionHandler: {(movies: MovieResponceWithDates)  in
//            self.upComingMovies = movies.results
//            self.table.reloadData()
//        })
//    }
    
}


//
//override func viewWillDisappear(_ animated: Bool) {
//    navigationController?.navigationBar.isHidden = false
//}
//override func viewWillAppear(_ animated: Bool) {
//    navigationController?.navigationBar.isHidden = true
//}
