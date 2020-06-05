//
//  RootVCForCollectionView.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 20/5/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit

class RootVCForCollectionView<U: BaseCollectionCell<T>, T: Hashable> : BaseVCForAll,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UICollectionViewDelegate  {
var collection: UICollectionView!
    var itemList: [T] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = BackGroundColor.getBackgrndClr()
        setupCollectionView()
        collection.dataSource = self
        collection.delegate = self
        // Do any additional setup after loading the view.
    }
    func setupCollectionView(){
        let frame = CGRect(x:0 , y:0 , width: Constants.IOS_SCREEN_WIDTH , height: Constants.IOS_SCREEN_HEIGHT)
        collection =  UICollection.getUICollections(HScrolling: false, frame: frame, layout: UICollectionViewFlowLayout())
        guard let collection = collection else{return}
        collection.register(U.self, forCellWithReuseIdentifier: Constants.COLLECTION_VIEW_CELL_IDENTIFIER)
        collection.register(HeaderForCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constants.COLLECTION_VIEW_HEADER_IDENTIFIER)
        view.addSubview(collection)
        let adjustForTabbarInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: self.tabBarController!.tabBar.frame.height, right: 0)
        self.collection.contentInset = adjustForTabbarInsets
        self.collection.scrollIndicatorInsets = adjustForTabbarInsets
    }

       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  itemList.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/3.2, height: collectionView.frame.width/2.3)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.COLLECTION_VIEW_CELL_IDENTIFIER, for: indexPath) as! U
        //cell.cellImage.image = UIImage() // this is done to make sure we gets blank view beofore updates new image
       // cell.titleTextLabel.text = Constants.EMPTY_TEXT
        cell.item = itemList[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: Constants.IOS_SCREEN_WIDTH, height: 0)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //
        // this will be over riden in child classes
        // need to leave it blank or it wont work in child classes
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //
              // this will be over riden in child classes
              // need to leave it blank or it wont work in child classes
    }
}
