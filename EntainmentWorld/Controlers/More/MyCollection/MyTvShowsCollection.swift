//
//  MyTvShowsCollection.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 20/5/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit


class TVShowCell : BaseCollectionCell<TVShows>{
    override var item: TVShows!{
        didSet{
            let pPath = item.poster_path
            let tittle = item.name ?? ""
            let db = DBConnection()
            Shared.LoadPosterImages(cellImage : cellImage, pPath: pPath, text : tittle, db: db)
        }
    }
}

class MyTvShowsCollection: Mycollection<TVShowCell, TVShows> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getTvShowIds()
    }
    
    
    func getTvShowIds(){
        persistentManager = PersistentDataManager.shared
        guard let persistentManager = persistentManager else {return}
        let tvShows = persistentManager.Fetech(TvShows.self)
        itemIdsList.removeAll()
        for tvShow in tvShows{
            itemIdsList.append(Int(tvShow.id))
        }
        loadFavTvShowseCollectionFromDB()
    }
    
    
    func loadFavTvShowseCollectionFromDB(){
        
        for id in itemIdsList {
            self.itemList.removeAll()
            db.loadItembyId(route: Routes.SEARCH_TV_SHOWS_BY_ID, movieId: id, completionHandler: { (shows: TVShows?, err)  in
                guard let shows = shows else {return}
                self.itemList.append(shows)
                self.collection.reloadData()
            })
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedItemIndex = indexPath.row
        LoadSegus(item: itemList[indexPath.row])
    }
    func LoadSegus(item : TVShows){
        let detailVC = UIStoryboard(name: Constants.SHOW_DETAILS_STORYBOARD_IDENTIFIER, bundle: nil).instantiateViewController(withIdentifier: Constants.SHOW_DETAILS_VIEW_CONTROLLER_IDENTIFIER) as! ItemDetailViewControllerForTable
        detailVC.item = item
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let persistentManager = persistentManager else{return}
        let count = persistentManager.TotalNoOfItems(TvShows.self)
        updatingList(count: count)
       }
}
