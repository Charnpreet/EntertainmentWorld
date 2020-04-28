//
//  TVShowsGenreDiscover.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 21/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation
import UIKit
class TVShowsListByGenre : BaseControllerForGenre<TVShows>{
    var genreId: Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collection.dataSource = self
        self.collection.delegate = self
        
        guard let genreId = genreId else{return}
        self.db.loadContentWithGenreId(pageNO: 1, route: Routes.DISCOVER_SHOWS_BY_GENRE_ID, genreId: genreId, completionHandler: { (shows: TVShowsResponse )in
            self.itemList = shows.results
            self.collection.reloadData()
        })
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        LoadSegus(item: itemList[indexPath.row])
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.COLLECTION_VIEW_CELL_IDENTIFIER, for: indexPath) as! CollectionViewCell
        
        cell.cellImage.image = UIImage() // this is done to make sure we gets blank view beofore updates new image
        cell.titleTextLabel.text = Constants.EMPTY_TEXT
        
        guard let poster = itemList[indexPath.row].poster_path else {
            cell.titleTextLabel.text = itemList[indexPath.row].name
            return cell
        }
        
        let urlString = "\(Connection.IMAGE_URL_BASE_PATH)\(poster)"
        guard let url = URL(string: urlString ) else {
            cell.titleTextLabel.text = itemList[indexPath.row].name

            return cell }
        db.downloadImage(from: url, completionHandler: {(img) in
            cell.cellImage.image = img
        })
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
