//
//  TOPRatedShowsDataSource.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 17/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Top Rated Shows DataSource
class TOPRatedShowsDataSource : BaseDataProviderShowsCollectionCell{
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == shows.count - 1 {
            currentPage += 1
            if(currentPage <= totalPages){
                
                self.loadMoreContent.loadMoreTopRatedShowData(pageNO: currentPage, completionHandler: {(loaded) in
                    if(loaded){
                        collectionView.reloadData()
                    }
                })
            }
        }
    }
}

