//
//  TopRatedMoviesDataSource.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 17/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation
import UIKit

class TopRatedMoviesDataSource : NSObject, UICollectionViewDataSource,  UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var topRatedmovies :[MoviesDetails] = []
     let db = DBConnection()
    var  moreMovies :LoadMoreMovieDataProtocol!
    //MARK:-
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/3.5, height: collectionView.frame.width/2.3)
       }
    
    //MARK:-
       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return topRatedmovies.count
           
       }
       
    //MARK:-
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.COLLECTION_VIEW_CELL_IDENTIFIER, for: indexPath) as! CollectionViewCell
           let url = URL(string: "\(Connection.IMAGE_URL_BASE_PATH)\(topRatedmovies[indexPath.row].poster_path)")!
           db.downloadImage(from: url, completionHandler: {(img) in
               cell.cellImage.image = img
           })

        return cell
       }
    
    //MARK:-
       func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           print(topRatedmovies[indexPath.row].title as Any)
           //performSegue(withIdentifier: "itemDetail", sender: nil)
       }
    
     //MARK:-
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
           if indexPath.row == topRatedmovies.count - 1 {
            self.moreMovies.loadMoreTopRatedmoviesData(completionHandler:{
                collectionView.reloadData()
            })
           }
       }
}
