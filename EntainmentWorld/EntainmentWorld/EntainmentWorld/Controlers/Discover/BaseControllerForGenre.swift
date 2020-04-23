//
//  DiscoverViewController.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 17/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit

class BaseControllerForGenre<T>: UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    let db = DBConnection()
    var collection: UICollectionView!
    var genreList: [T] = []
    var textlabel: UILabel?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    func setupCollectionView(){
        let frame = CGRect(x:0 , y:1 , width: Constants.IOS_SCREEN_WIDTH , height: Constants.IOS_SCREEN_HEIGHT)
        collection =  UICollection.getUICollections(HScrolling: false, frame: frame, layout: UICollectionViewFlowLayout())
        collection.register(CollectionViewCell.self, forCellWithReuseIdentifier: Constants.COLLECTION_VIEW_CELL_IDENTIFIER)
        collection.register(HeaderForCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constants.COLLECTION_VIEW_HEADER_IDENTIFIER)
        view.addSubview(collection)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  genreList.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/3.2, height: collectionView.frame.width/2.3)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.COLLECTION_VIEW_CELL_IDENTIFIER, for: indexPath) as! CollectionViewCell
        //cell.titleTextLabel.text = genreList[indexPath.row].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constants.COLLECTION_VIEW_HEADER_IDENTIFIER, for: indexPath)
        textlabel = UILabel(frame: CGRect(x: 0, y: 0, width: header.frame.width-10, height: header.frame.height/2))
//        textlabel?.text = "Movie Genre" //"Browse  By Genre"
        textlabel?.textAlignment = .center
        textlabel?.textColor = .white
        textlabel?.center = header.center
        header.addSubview(textlabel ?? UILabel())
        return header
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: Constants.IOS_SCREEN_WIDTH, height: 60)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //
        // this will be over riden in child classes
        // need to leave it blank or it wont work in child classes
    }
    
}
