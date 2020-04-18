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
class PopularShowsDataSource : NSObject, UICollectionViewDataSource,  UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var popularShows: [TVShows] = []
    var loadMorePopularContent : LoadMoreDataProtocol!
    let db = DBConnection()
    var delegate :CollectionViewSelectedProtocol!
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return popularShows.count
        
    }
    //
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.COLLECTION_VIEW_CELL_IDENTIFIER, for: indexPath) as! CollectionViewCell
        
        let urlString = "\(Connection.IMAGE_URL_BASE_PATH)\(popularShows[indexPath.row].poster_path ?? "")"

        guard let url = URL(string: urlString) else { return cell }
        db.downloadImage(from: url, completionHandler: {(img) in
            cell.cellImage.image = img
        })
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.delegate.collectionViewSelected(item: popularShows[indexPath.row])
       }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/3.5, height: collectionView.frame.width/2.3)
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == popularShows.count - 1 {
            self.loadMorePopularContent.loadMorePopularShowData(completionHandler: {
                collectionView.reloadData()
            })
        }
    }
}
