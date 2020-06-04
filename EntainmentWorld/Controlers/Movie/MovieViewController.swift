//
//  MovieViewController.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 7/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit
class MovieViewController: BaseVCForTableView {
    var dataProvider : DataSourceProviderForMovieTable!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = BackGroundColor.getBackgrndClr()
        navigationController?.navigationBar.backgroundColor = BackGroundColor.getBackgrndClr() 
        DataProviders()
    }
    
    func DataProviders(){
        dataProvider = DataSourceProviderForMovieTable()
        guard let dataProvider = dataProvider else{return}
        dataProvider.screenSegus = self
        table.dataSource = dataProvider
        table.delegate  = dataProvider
        
    }
    override func setUptable(){
        super.setUptable()
        table.register(UItableCell.self, forCellReuseIdentifier: Constants.TABLE_VIEW_CELL_IDENTIFIER)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}


extension MovieViewController : DoSegusForMovies {
    func LoadSegus(item : MoviesDetails){
        let detailVC = UIStoryboard(name: Constants.MOVIE_DETAILS_STORYBOARD_IDENTIFIER, bundle: nil).instantiateViewController(withIdentifier: Constants.MOVIE_DETAILS_STORYBOARD_IDENTIFIER) as! MoviesDetailsController
        detailVC.item = item
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
