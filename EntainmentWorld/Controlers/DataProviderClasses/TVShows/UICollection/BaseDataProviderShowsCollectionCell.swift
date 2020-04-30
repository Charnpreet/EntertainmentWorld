//
//  BaseDataProviderCollectionCell.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 20/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation
import UIKit
class  BaseDataProviderShowsCollectionCell  : NSObject, UICollectionViewDataSource,  UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var delegate :CollectionViewSelectedProtocol!
    var shows: [TVShows] = []
      var loadMoreContent : LoadMoreDataProtocol!
      let db = DBConnection()
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          return shows.count
          
      }
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.COLLECTION_VIEW_CELL_IDENTIFIER, for: indexPath) as! CollectionViewCell
        cell.cellImage.image = UIImage()                    // this is done to make sure we gets blank view beofore updates new image
        cell.titleTextLabel.text = Constants.EMPTY_TEXT
        let pPath = shows[indexPath.row].poster_path
        let tittle = shows[indexPath.row].name ?? ""
        Shared.LoadPosterImagesForCollectionCell(cell : cell, pPath: pPath, text :tittle, db:db)
        
          return cell
      }
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          return CGSize(width: collectionView.frame.width/3.3, height: collectionView.frame.height) //collectionView.frame.width/2.3
      }
      
      func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let delegate = delegate else{return}
        delegate.collectionViewSelected(item: shows[indexPath.row])
        //self.
      }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    }

}
