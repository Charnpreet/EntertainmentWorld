//
//  TvShowGenre.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 21/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation
import  UIKit

class TVShowsGenreIdList: RootControllerWithUICollectionView<Genre> {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = BackGroundColor.getBackgrndClr() 
        self.collection.dataSource = self
        self.collection.delegate = self
        loadGenreList()
        
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
    
    func LoadSegus(genreId : Int){
        let vc = UIStoryboard(name: Constants.TV_SHOWS_GENRE_IDENTIFIER, bundle: nil).instantiateViewController(withIdentifier: Constants.TV_SHOWS_GENRE_IDENTIFIER) as! TVShowsListByGenre
        vc.genreId = genreId
          navigationController?.pushViewController(vc, animated: true)
      }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  super.collectionView(collectionView, cellForItemAt: indexPath) as! CollectionViewCell
        cell.titleTextLabel.text = itemList[indexPath.row].name
        return cell
    }
}
