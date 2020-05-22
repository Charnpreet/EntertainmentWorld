//
//  PopularMoviesDataSource.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 17/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation
import UIKit

class PopularMoviesDataSource : BaseDataProviderForMovieCollectionCell{
    //MARK:-
    override  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        super.collectionView(collectionView, willDisplay: cell, forItemAt: indexPath)
        if indexPath.row == moviesList.count - 1 {
            visiblePage += 1
             if(visiblePage  <= totalNoOfPages){
                self.loadMoreContent.loadMorePopularMoviesData(pageNO: visiblePage ,completionHandler:  {(loaded) in
                if(loaded){
                    collectionView.reloadData()
                }
            })
        }
        }
    }
    
}
