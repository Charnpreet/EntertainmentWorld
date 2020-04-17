//
//  MovieTableCellExtension.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 15/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation
import UIKit
//extension MovieTableCell: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: collectionView.frame.width/3.5, height: collectionView.frame.width/2)
//    }
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return MoviesList.count
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.COLLECTION_VIEW_CELL_IDENTIFIER, for: indexPath) as! CollectionViewCell
//        let url = URL(string: "\(Connection.IMAGE_URL_BASE_PATH)\(MoviesList[indexPath.row].poster_path)")!
//        db.downloadImage(from: url, completionHandler: {(img) in
//            cell.cellImage.image = img
//        })
//        return cell
//    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print(MoviesList[indexPath.row].title as Any)
//        //performSegue(withIdentifier: "itemDetail", sender: nil)
//    }
//
//}
