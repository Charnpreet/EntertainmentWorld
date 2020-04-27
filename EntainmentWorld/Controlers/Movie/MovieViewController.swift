//
//  MovieViewController.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 7/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit
class MovieViewController: BaseViewController {
    var dataProvider : DataSourceProviderForMovieTable!
    override func viewDidLoad() {
        super.viewDidLoad()
        DataProviders()
    }
    
        func DataProviders(){
            dataProvider = DataSourceProviderForMovieTable()
            guard let dataProvider = dataProvider else{return}
            dataProvider.screenSegus = self
            table.dataSource = dataProvider
            table.delegate  = dataProvider
          //  dataProvider.loadingData()
        
        }
    
    override func setUptable(){
        super.setUptable()
        table.register(UItableCell.self, forCellReuseIdentifier: Constants.TABLE_VIEW_CELL_IDENTIFIER)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // navigationController?.navigationBar.topItem?.title = "Movies"
    }
}

    

extension MovieViewController : DoSegusForMovies {
    func LoadSegus(item : MoviesDetails){
         let detailVC = UIStoryboard(name: "moviesDiscription", bundle: nil).instantiateViewController(withIdentifier: "moviesDiscription") as! MoviesDetailsController
        detailVC.item = item
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
