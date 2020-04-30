//
//  TableCellCollectionViewExtension.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 15/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation
import UIKit

// MARK: - On Air Today Shows DataSource
class ONAirTodayShowsDataSource : BaseDataProviderShowsCollectionCell{
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        super.collectionView(collectionView, willDisplay: cell, forItemAt: indexPath)
        if indexPath.row == shows.count - 1 {
            self.loadMoreContent.loadMoreOnAirTodayShowData(completionHandler: {(loaded) in
                if(loaded){
                  collectionView.reloadData()
                }
                
            })
        }
    }
}

