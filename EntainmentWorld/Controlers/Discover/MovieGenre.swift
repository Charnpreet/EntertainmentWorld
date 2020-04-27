//
//  MovieGenre.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 21/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation
import  UIKit
class  MovieGenre: BaseControllerForGenre<Genre> {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        self.collection.dataSource = self
        self.collection.delegate = self
        // Do any additional setup after loading the view.
        db.LoadGenre(route: Routes.MOVIE_GENRE, completionHandler: {(movieGenre : GenreCollection) in
            self.itemList.removeAll()
            self.itemList = movieGenre.genres
            self.collection.reloadData()
        })
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = ""
    }
//    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        let header =  super.collectionView(collectionView, viewForSupplementaryElementOfKind: kind, at: indexPath)
//        self.textlabel?.text = "Movie Genre"
//        return header
//    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        LoadSegus(genreId: itemList[indexPath.row].id )
    }
    
   override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.COLLECTION_VIEW_CELL_IDENTIFIER, for: indexPath) as! CollectionViewCell
           cell.titleTextLabel.text = itemList[indexPath.row].name
           return cell
       }
    
    
func LoadSegus(genreId : Int){
        let vc = UIStoryboard(name: "MoviesListByGenreID", bundle: nil).instantiateViewController(withIdentifier: "MoviesListByGenreID") as! MoviesListByGenreID
      vc.genreId = genreId
        navigationController?.pushViewController(vc, animated: true)
    }
}
