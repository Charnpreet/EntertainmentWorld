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
        
        self.db.loadContentWithGenreId(pageNO: 1, route: Routes.DISCOVER_SHOWS_BY_GENRE_ID, genreId: genreId, completionHandler: { (shows: TVShowsResponse )in
            self.genreList = shows.results
            self.collection.reloadData()
        })
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        LoadSegus(item: genreList[indexPath.row])
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.COLLECTION_VIEW_CELL_IDENTIFIER, for: indexPath) as! CollectionViewCell
        let urlString = "\(Connection.IMAGE_URL_BASE_PATH)\(genreList[indexPath.row].poster_path ?? "")"
        guard let url = URL(string: urlString ) else { return cell }
        db.downloadImage(from: url, completionHandler: {(img) in
            cell.cellImage.image = img
        })
        return cell
    }
}
extension TVShowsListByGenre  : DoSegus {
    func LoadSegus(item : TVShows) {
        let detailVC = UIStoryboard(name: "TVShowsDetails", bundle: nil).instantiateViewController(withIdentifier: "ItemDetails") as! ItemDetailViewControllerForTable
        detailVC.item = item
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
