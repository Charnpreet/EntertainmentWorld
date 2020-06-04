//
//  MyTvShowsCollection.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 20/5/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit
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
        self.itemList.removeAll()
        for id in itemIdsList {
            dc.enter()
            db.loadItembyId(route: Routes.SEARCH_TV_SHOWS_BY_ID, movieId: id, completionHandler: { (shows: TVShows?, err)  in
                guard let shows = shows else {return}
                self.itemList.append(shows)
                self.collection.reloadData()
                self.dc.leave()
                
            })
        }
        dc.notify(queue: .main, execute: {
            self.collection.reloadData()
        })
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
