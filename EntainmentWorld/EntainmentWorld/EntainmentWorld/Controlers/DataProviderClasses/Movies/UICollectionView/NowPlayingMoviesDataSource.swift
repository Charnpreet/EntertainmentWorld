//
//  NowPlayingMoviesDataSource.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 17/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation
import UIKit
class NowPlayingMoviesDataSource :BaseDataProviderForMovieCollectionCell<MoviesDetails>  {
   
//MARK:-
override   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.COLLECTION_VIEW_CELL_IDENTIFIER, for: indexPath) as! CollectionViewCell
       let url = URL(string: "\(Connection.IMAGE_URL_BASE_PATH)\(moviesList [indexPath.row].poster_path)")!
       db.downloadImage(from: url, completionHandler: {(img) in
           cell.cellImage.image = img
       })

    return cell
   }
       
        //MARK:-
       func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
              if indexPath.row == moviesList.count - 1 {
                self.loadMoreContent.loadMoreNowPlayingMoviesData(completionHandler: {
                    collectionView.reloadData()
                })
              }
          }
}
