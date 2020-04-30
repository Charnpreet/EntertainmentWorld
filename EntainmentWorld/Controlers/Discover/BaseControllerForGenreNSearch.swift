//
//  DiscoverViewController.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 17/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit

class BaseControllerForGenreNSearch<T> : UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    let db = DBConnection()
    let activityIndicator =  ActivityIndicator.getActivityIndicator()
    var collection: UICollectionView!
    var itemList: [T] = []
    var textlabel: UILabel?
    var noNetworkView: UIView!
    var nBarHeight: CGFloat?
    var tBarHeight: CGFloat?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = BackGroundColor.getBackgrndClr()
        setupCollectionView()
         noNetworkViewSetup()
            nBarHeight = self.navigationController?.navigationBar.frame.size.height
        let position = CGFloat((nBarHeight ?? 44)+50)
        let c = NetworkConnectivity.shared
        c.startMonitoring(completionHandler:{(loaded) in
            if(!loaded){
                self.noNetworkView.isHidden = false
                NoNetworkViews.AnimateNoNetworkViews(viewNeedtedToBeAnimated: self.noNetworkView, parentView: self.view, position: position)
            
            }else{
                self.collection.reloadData()
            }
        })

    }
    
    public func noNetworkViewSetup(){
        noNetworkView   = NoNetworkViews.getNoNetworkViews()
        self.view.addSubview(noNetworkView)
    }
    
    func setupCollectionView(){
        let frame = Frames.GENRE_BASE_CONTROLLER_FRAME_CG_REACT
        collection =  UICollection.getUICollections(HScrolling: false, frame: frame, layout: UICollectionViewFlowLayout())
        guard let collection = collection else{return}
        collection.register(CollectionViewCell.self, forCellWithReuseIdentifier: Constants.COLLECTION_VIEW_CELL_IDENTIFIER)
        collection.register(HeaderForCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constants.COLLECTION_VIEW_HEADER_IDENTIFIER)
        view.addSubview(collection)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  itemList.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/3.2, height: collectionView.frame.width/2.3)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.COLLECTION_VIEW_CELL_IDENTIFIER, for: indexPath) as! CollectionViewCell
        cell.cellImage.image = UIImage() // this is done to make sure we gets blank view beofore updates new image
        cell.titleTextLabel.text = Constants.EMPTY_TEXT
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
    
}
