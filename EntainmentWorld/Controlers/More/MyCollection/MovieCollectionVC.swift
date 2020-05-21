//
//  MovieCollectionVC.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 20/5/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit

class MovieCell : BaseCollectionCell<MoviesDetails>{
    override var item: MoviesDetails!{
        didSet{
                let pPath = item.poster_path
                let tittle = item.title ?? ""
                let db = DBConnection()
                Shared.LoadPosterImages(cellImage : cellImage, pPath: pPath, text : tittle, db: db)
        }
    }
}
//
class MovieCollectionVC: Mycollection<MovieCell, MoviesDetails>{
    override func viewDidLoad() {
        super.viewDidLoad()
        getMovieId()
    }
    
    func getMovieId(){
        persistentManager = PersistentDataManager.shared
          guard let persistentManager = persistentManager else {return}
          let movies = persistentManager.Fetech(Movies.self)
          itemIdsList.removeAll()
          for movie in movies{
              itemIdsList.append(Int(movie.id))
          }
        loadFavMovieCollectionFromDB()
      }
    
    
      func loadFavMovieCollectionFromDB(){
            for id in itemIdsList {
                self.itemList.removeAll()
                db.loadItembyId(route: Routes.SEARCH_MOVIE_BY_ID, movieId: id, completionHandler: { (movie: MoviesDetails?, err)  in
                    guard let movie = movie else {
                        return}
                    self.itemList.append(movie)
                    self.collection.reloadData()
                })
            }

        }
    
   override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    selectedItemIndex = indexPath.row
    LoadMovieSegus(item: itemList[indexPath.row])
    }
    
    func LoadMovieSegus(item : MoviesDetails){
        let detailVC = UIStoryboard(name: Constants.MOVIE_DETAILS_STORYBOARD_IDENTIFIER, bundle: nil).instantiateViewController(withIdentifier: Constants.MOVIE_DETAILS_STORYBOARD_IDENTIFIER) as! MoviesDetailsController
        detailVC.item = item
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let persistentManager = persistentManager else{return}
        let count = persistentManager.TotalNoOfItems(Movies.self)
        updatingList(count: count)
    }
}
