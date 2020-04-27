//
//  TableViewCellController.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 8/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit

class UItableCell: UITableViewCell {
    var collection : UICollectionView!  // collection view
     //
     var collectionViewDataSource : UICollectionViewDataSource!  // data source provider for collection view
     //
     var collectionViewDelegate : UICollectionViewDelegate!  // delegate provider for collection view
     
     // stores position of view on the screen
     var collectionViewOffset: CGFloat {
         set {
             collection.contentOffset.x = newValue
         }
         
         get {
             return collection.contentOffset.x
         }
     }

    
    // MARK:- class init methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        backgroundColor = .black
    }
    
    // MARK:- INITILIZES COLLECTION VIEW AND SETS ITS DATA SOURCE AND DELGATE PROVIDERS
     func initializeCollectionViewWithDataSource<D: UICollectionViewDataSource,E: UICollectionViewDelegate>(_ dataSource: D, delegate :E, forRow row: Int) {
        let frame = CGRect(x:  10 , y: 1 , width: Constants.IOS_SCREEN_WIDTH-25 , height: Constants.IOS_SCREEN_HEIGHT/5.1)
         self.collectionViewDataSource = dataSource
         self.collectionViewDelegate = delegate
         let flowLayout = UICollectionViewFlowLayout()
         flowLayout.scrollDirection = .horizontal
         let collectionView = UICollectionView(frame: frame, collectionViewLayout: flowLayout)
         collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: Constants.COLLECTION_VIEW_CELL_IDENTIFIER)
         collectionView.backgroundColor = UIColor.black
         collectionView.dataSource = self.collectionViewDataSource
         collectionView.delegate = self.collectionViewDelegate
         collectionView.tag = row
         self.addSubview(collectionView)
         self.collection = collectionView
          collectionView.reloadData()
     }
}

