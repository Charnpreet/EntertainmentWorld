//
//  BaseVCForSearch&Genre.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 4/6/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit

class BaseVCForSearch_Genre<U: BaseCollectionCell<T>, T: Hashable>: RootVCForCollectionView<U, T> {
    var curentPage: Int = 1
    var totalPages: Int = 1
    var db = DBConnection()
    enum Section {
        case main
    }
    var dataSource: UICollectionViewDiffableDataSource<Section,T>!
     var currentSnapshot: NSDiffableDataSourceSnapshot<Section,T>!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDataSource()
        // Do any additional setup after loading the view.
    }
    
    func createSnapShot(from itemList: [T]){
        currentSnapshot =  NSDiffableDataSourceSnapshot<Section,T>()
        currentSnapshot.appendSections([.main])
        currentSnapshot.appendItems(itemList)
        guard let dataSource = dataSource else{return}
        dataSource.apply(currentSnapshot, animatingDifferences: true)
        //self.activityIndicator.stopAnimating()
    }
    
    func configureDataSource() {
          dataSource = UICollectionViewDiffableDataSource<Section, T>(collectionView: collection, cellProvider: {collection, indexPath, itemList in
              let cell = collection.dequeueReusableCell(withReuseIdentifier: Constants.COLLECTION_VIEW_CELL_IDENTIFIER, for: indexPath) as! U
              cell.cellImage.image = UIImage() // this is done to make sure we gets blank view beofore updates new image
              cell.titleTextLabel.text = Constants.EMPTY_TEXT
                cell.item = itemList
              return cell
          })
      }
}
