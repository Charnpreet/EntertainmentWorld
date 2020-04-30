//
//  MoviesListByGenreID.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 21/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation
import UIKit
class MoviesListByGenreID : BaseControllerForGenreNSearch<MoviesDetails>{
    var genreId: Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = BackGroundColor.getBackgrndClr() 
        
        self.view.addSubview(activityIndicator)
        activityIndicator.center = self.view.center
        activityIndicator.startAnimating()
        self.collection.dataSource = self
        self.collection.delegate = self
        guard let genreId = genreId else{return}
         LoadConentWithGnreId(genreId: genreId)
    }
    
    
    func LoadConentWithGnreId(genreId: Int){
        self.db.loadContentWithGenreId(pageNO: 1, route: Routes.DISCOVER_MOVIES_BY_GENRE_ID, genreId: genreId, completionHandler: { (movies: MovieResponse )in
            self.itemList = movies.results
            self.activityIndicator.stopAnimating()
            self.collection.reloadData()
        })
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        LoadSegus(item: itemList[indexPath.row])
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  super.collectionView(collectionView, cellForItemAt: indexPath) as! CollectionViewCell
        let pPath = itemList[indexPath.row].poster_path
        let tittle = itemList[indexPath.row].title ?? ""
        Shared.LoadPosterImagesForCollectionCell(cell : cell, pPath: pPath, text :tittle, db:db)
        return cell
    }
}

extension MoviesListByGenreID : DoSegusForMovies {
    func LoadSegus(item : MoviesDetails){
        let detailVC = UIStoryboard(name: Constants.MOVIE_DETAILS_STORYBOARD_IDENTIFIER, bundle: nil).instantiateViewController(withIdentifier: Constants.MOVIE_DETAILS_STORYBOARD_IDENTIFIER) as! MoviesDetailsController
        detailVC.item = item
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
