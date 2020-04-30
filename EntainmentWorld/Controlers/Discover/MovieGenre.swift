//
//  MovieGenre.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 21/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation
import  UIKit
class  MovieGenre: BaseControllerForGenreNSearch<Genre> {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = BackGroundColor.getBackgrndClr() 
        self.collection.dataSource = self
        self.collection.delegate = self
        loadGenreList()
        // Do any additional setup after loading the view.
    }
    
    func loadGenreList(){
        db.LoadGenre(route: Routes.MOVIE_GENRE, completionHandler: {(movieGenre : GenreCollection) in
            self.itemList.removeAll()
            self.itemList = movieGenre.genres
            self.collection.reloadData()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = Constants.EMPTY_TEXT
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = Constants.EMPTY_TEXT
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        LoadSegus(genreId: itemList[indexPath.row].id )
    }
    
   override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.COLLECTION_VIEW_CELL_IDENTIFIER, for: indexPath) as! CollectionViewCell
           cell.titleTextLabel.text = itemList[indexPath.row].name
           return cell
       }
    
    
func LoadSegus(genreId : Int){
    let vc = UIStoryboard(name: Constants.MOVIE_GENRE_IDENTIFIER, bundle: nil).instantiateViewController(withIdentifier: Constants.MOVIE_GENRE_IDENTIFIER) as! MoviesListByGenreID
      vc.genreId = genreId
        navigationController?.pushViewController(vc, animated: true)
    }
}
