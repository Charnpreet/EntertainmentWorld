//
//  BaseDataProviderForMovieCollectionCell.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 20/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation
import UIKit
class BaseDataProviderForMovieCollectionCell<T> : NSObject, UICollectionViewDataSource,  UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var moviesList :[T] = []
     let db = DBConnection()
    var  loadMoreContent :LoadMoreMovieDataProtocol!
    var delegate : MovieCollectionViewSelectedProtocol!
    //MARK:-
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/3.3, height: collectionView.frame.height)  //collectionView.frame.width/2.3
       }
    
    //MARK:-
       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return moviesList.count
           
       }
       
    //MARK:-
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.COLLECTION_VIEW_CELL_IDENTIFIER, for: indexPath) as! CollectionViewCell
        
        return cell
       }
    
    //MARK:-
       func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let delegate = self.delegate else{return}
        print(indexPath)
         delegate.collectionViewSelected(item: moviesList[indexPath.row] as! MoviesDetails)
       }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
    
}

