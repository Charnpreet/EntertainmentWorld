//
//  SearchViewController.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 7/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit
//SearchControllerDataProvider<T>
class SearchViewController<T>: UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    var searchTextField : UISearchTextField!
    let db = DBConnection()
    var collection: UICollectionView!
    var searchedItems :[T] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        self.collection.keyboardDismissMode = .onDrag
    }
    //header: HeaderForCollectionReusableView
    public func setUpSearchTextField() -> UISearchTextField{
                print()
        let frame = CGRect(x: Constants.IOS_SCREEN_WIDTH/8, y: 0, width: (Constants.IOS_SCREEN_WIDTH - Constants.IOS_SCREEN_WIDTH/5), height: 40)
      let  searchTextField = CustomSearchBar(frame: frame)
        searchTextField.placeholder = "Search Here"
        searchTextField.backgroundColor = .black
        searchTextField.textColor = .white
        searchTextField.addTarget(self, action: #selector(getSearchEditFIeldText(_:)), for: .editingDidEndOnExit);
        return searchTextField
    }
    @objc func updateList(_ sender: UISearchTextField){
        self.searchedItems.removeAll()
        self.collection.reloadData()
    }
    
    func setupCollectionView(){
        let frame = CGRect(x:  1 , y: 80 , width: Constants.IOS_SCREEN_WIDTH-1 , height: Constants.IOS_SCREEN_HEIGHT)
        collection =  UICollection.getUICollections(HScrolling: false, frame: frame, layout: UICollectionViewFlowLayout())
        collection.register(CollectionViewCell.self, forCellWithReuseIdentifier: Constants.COLLECTION_VIEW_CELL_IDENTIFIER)
        collection.register(HeaderForCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constants.COLLECTION_VIEW_HEADER_IDENTIFIER)
        view.addSubview(collection)
    }
    
    // method associated With UISeatchTextField
    //
    @objc func getSearchEditFIeldText(_ sender: UISearchTextField){

        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return searchedItems.count
     }


     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         return CGSize(width: collectionView.frame.width/3.5, height: collectionView.frame.width/2.3)
     }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.COLLECTION_VIEW_CELL_IDENTIFIER, for: indexPath) as! CollectionViewCell
         return cell
     }

     func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
         let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constants.COLLECTION_VIEW_HEADER_IDENTIFIER, for: indexPath)
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
