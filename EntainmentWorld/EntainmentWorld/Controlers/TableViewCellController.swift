//
//  TableViewCellController.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 8/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit

class TableViewCellController: UITableViewCell {
    var collection: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
                setupCollectionView()
              self.collection.dataSource = self
              self.collection.delegate = self
    }
    func setupCollectionView(){
        let frame = CGRect(x:  10 , y: 10 , width: 390 , height: 200)
        collection =  UICollection.getUICollections(HScrolling: true, frame: frame, layout: UICollectionViewFlowLayout())
        collection.backgroundColor = .white
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(CollectionViewCellController.self, forCellWithReuseIdentifier: Constants.COLLECTION_VIEW_CELL_IDENTIFIER)
        contentView.addSubview(collection)
       }
}

extension TableViewCellController: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize(width: collectionView.frame.width/2.5, height: collectionView.frame.width/2)
       }
       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return 10 // this must return size of array data
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.COLLECTION_VIEW_CELL_IDENTIFIER, for: indexPath) as! CollectionViewCellController
        cell.cellImage.image = UIImage(named: "img1")
           return cell
       }
    
    
}
