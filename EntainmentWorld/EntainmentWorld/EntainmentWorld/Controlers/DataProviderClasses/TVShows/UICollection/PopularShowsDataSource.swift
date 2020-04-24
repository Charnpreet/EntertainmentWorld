//
//  PopularShowsDataSource.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 17/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Popular Shows DataSource
class PopularShowsDataSource : BaseDataProviderShowsCollectionCell<TVShows>{
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.COLLECTION_VIEW_CELL_IDENTIFIER, for: indexPath) as! CollectionViewCell
        
        let urlString = "\(Connection.IMAGE_URL_BASE_PATH)\(shows[indexPath.row].poster_path ?? "")"
        
        guard let url = URL(string: urlString ) else { return cell }
        db.downloadImage(from: url, completionHandler: {(img) in
            cell.cellImage.image = img
        })
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == shows.count - 1 {
            self.loadMoreContent.loadMorePopularShowData(completionHandler: {
                collectionView.reloadData()
            })
        }
    }
}
