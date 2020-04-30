//
//  TVShowsGenreDiscover.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 21/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//
import Foundation
import UIKit
class TVShowsListByGenre : BaseControllerForGenreNSearch<TVShows>{
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
        self.db.loadContentWithGenreId(pageNO: 1, route: Routes.DISCOVER_SHOWS_BY_GENRE_ID, genreId: genreId, completionHandler: { (shows: TVShowsResponse )in
            self.itemList = shows.results
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
        let tittle = itemList[indexPath.row].name ?? ""
        Shared.LoadPosterImagesForCollectionCell(cell : cell, pPath: pPath, text :tittle, db:db)
        return cell
    }
}
extension TVShowsListByGenre  : DoSegus {
    func LoadSegus(item : TVShows) {
        let detailVC = UIStoryboard(name: Constants.SHOW_DETAILS_STORYBOARD_IDENTIFIER, bundle: nil).instantiateViewController(withIdentifier: Constants.SHOW_DETAILS_VIEW_CONTROLLER_IDENTIFIER) as! ItemDetailViewControllerForTable
        detailVC.item = item
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
