//
//  Mycollection.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 4/5/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation
import UIKit
//UIViewController
class Mycollection<U: BaseCollectionCell<T>, T:Hashable> : RootVCForCollectionView<U, T>  {
    var db = DBConnection()
    var navBarImg: UIImage!
    var itemIdsList :[Int] = []
    var selectedItemIndex: Int?
    var persistentManager: PersistentDataManager?
    override func viewDidLoad() {
        super.viewDidLoad()
      //  ClearNavigationBar()
       // self.view.backgroundColor = .black
        //self.extendedLayoutIncludesOpaqueBars = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func updatingList(count: Int){
        if(count != itemList.count){
            // there is change in item count
            guard let selectedItemIndex = selectedItemIndex else{return}
            itemList.remove(at: selectedItemIndex)
            self.collection.reloadData()
        }
    }
//    fileprivate func ClearNavigationBar(){
//        navBarImg = UIImage()
//        guard let navBarImg = navBarImg else {return}
//        // self.navigationController?.navigationBar.layer.shadowOpacity = 0.95
//        self.navigationController?.navigationBar.setBackgroundImage(navBarImg, for: .default)
//        self.navigationController?.navigationBar.shadowImage = navBarImg
//        self.navigationController?.navigationBar.isTranslucent = true
//        self.navigationController?.navigationBar.backgroundColor = .clear
//        self.navigationController?.navigationBar.topItem?.title = Constants.EMPTY_TEXT
//    }
}
    
