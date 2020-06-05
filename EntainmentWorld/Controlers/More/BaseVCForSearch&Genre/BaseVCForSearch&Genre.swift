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
    var activityIndicator: UIActivityIndicatorView?
    enum Section {
        case main
    }
    var dataSource: UICollectionViewDiffableDataSource<Section,T>!
     var currentSnapshot: NSDiffableDataSourceSnapshot<Section,T>!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = BackGroundColor.getBackgrndClr()
        self.extendedLayoutIncludesOpaqueBars = true
        configureDataSource()
        setupActivityIndicator()
        // Do any additional setup after loading the view.
    }
    func setupActivityIndicator(){
      activityIndicator = ActivityIndicator.getActivityIndicator()
        guard let activityIndicator = activityIndicator else{return}
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        activityIndicator.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        activityIndicator.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        activityIndicator.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    
    func createSnapShot(from itemList: [T]){
        currentSnapshot =  NSDiffableDataSourceSnapshot<Section,T>()
        currentSnapshot.appendSections([.main])
        currentSnapshot.appendItems(itemList)
        guard let dataSource = dataSource else{return}
        dataSource.apply(currentSnapshot, animatingDifferences: true)
        guard let activityIndicator = activityIndicator else{return}
        activityIndicator.stopAnimating()
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
