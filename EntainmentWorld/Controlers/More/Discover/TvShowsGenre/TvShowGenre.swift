//
//  TvShowGenre.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 21/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation
import  UIKit
class TVShowsGenreIdList: BaseVCForGenreCategoryList<GenreCateogryCell, Genre>{
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = BackGroundColor.getBackgrndClr()
        loadGenreList()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nvigationLabel.text = "TV Shows"
    }
    func loadGenreList(){
        db.LoadGenre(route: Routes.MOVIE_GENRE, completionHandler: {(movieGenre : GenreCollection) in
            self.itemList.removeAll()
            self.itemList = movieGenre.genres
            self.collection.reloadData()
        })
    }
    func LoadSegus(genreId : Int, genreCatName: String){
      let vc = UIStoryboard(name: Constants.TV_SHOWS_GENRE_IDENTIFIER, bundle: nil).instantiateViewController(withIdentifier: Constants.TV_SHOWS_GENRE_IDENTIFIER) as! TVShowsListByGenre
        vc.genreId = genreId
        vc.genreCatgoryName = genreCatName
        navigationController?.pushViewController(vc, animated: true)
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        LoadSegus(genreId: itemList[indexPath.row].id, genreCatName: itemList[indexPath.row].name)
    }
}
