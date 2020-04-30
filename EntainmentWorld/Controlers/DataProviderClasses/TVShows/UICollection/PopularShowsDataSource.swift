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
class PopularShowsDataSource : BaseDataProviderShowsCollectionCell{
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == shows.count - 1 {
            self.loadMoreContent.loadMorePopularShowData(completionHandler: { (loaded) in
                if(loaded){
                  collectionView.reloadData()
                }
                
            })
        }
    }
}
