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
    let dc = DispatchGroup()
    var navBarImg: UIImage!
    var itemIdsList :[Int] = []
    var selectedItemIndex: Int?
    var persistentManager: PersistentDataManager?
    override func viewDidLoad() {
        super.viewDidLoad()
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
}
    
