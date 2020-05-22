//
//  CollectionViewExtension.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 1/5/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation
import UIKit


extension BaseDataProviderForMovieCollectionCell  :  UICollectionViewDataSource,  UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    //MARK:-
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/3.3, height: collectionView.frame.height)
    }
    
    //MARK:-
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesList.count
        
    }
    
    //MARK:-
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.COLLECTION_VIEW_CELL_IDENTIFIER, for: indexPath) as! CollectionViewCell
        cell.cellImage.image = UIImage()                    // this is done to make sure we gets blank view beofore updates new image
        cell.titleTextLabel.text = Constants.EMPTY_TEXT
        let pPath = moviesList[indexPath.row].poster_path
        let tittle = moviesList[indexPath.row].title ?? ""
        Shared.LoadPosterImagesForCollectionCell(cell : cell, pPath: pPath, text :tittle, db:db)
        
        return cell
    }
    
    //MARK:-
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let delegate = self.delegate else{return}
        delegate.collectionViewSelected(item: moviesList[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
}
