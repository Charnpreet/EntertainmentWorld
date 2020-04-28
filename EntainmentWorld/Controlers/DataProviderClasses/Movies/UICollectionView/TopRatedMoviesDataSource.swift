//
//  TopRatedMoviesDataSource.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 17/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation
import UIKit

class TopRatedMoviesDataSource :BaseDataProviderForMovieCollectionCell<MoviesDetails>  {

    
    
       
    //MARK:-
    override   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.COLLECTION_VIEW_CELL_IDENTIFIER, for: indexPath) as! CollectionViewCell
        
        cell.cellImage.image = UIImage() // this is done to make sure we gets blank view beofore updates new image
        cell.titleTextLabel.text = Constants.EMPTY_TEXT
        
        let pPath = moviesList[indexPath.row].poster_path
        guard let posterPath = pPath else {
            cell.titleTextLabel.text = moviesList[indexPath.row].title
            return cell
            
        }
        let urlString = "\(Connection.IMAGE_URL_BASE_PATH)\(posterPath)"
        
        guard let url = URL(string: urlString ) else {
            cell.titleTextLabel.text = moviesList[indexPath.row].title
            return cell
            
        }
        db.downloadImage(from: url, completionHandler: {(img) in
            cell.cellImage.image = img
        })
        return cell
       }
    
     //MARK:-
    override  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == moviesList.count - 1 {
           // collectionView.isScrollEnabled = false
            self.loadMoreContent.loadMoreTopRatedmoviesData(completionHandler: {(loaded) in
                if(loaded){
                    collectionView.reloadData()
                    collectionView.isScrollEnabled = true
                }
            })
        }
    }
}
