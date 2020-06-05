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
    var noItemInYourCollection: UILabel?
    override func viewDidLoad() {
        super.viewDidLoad()
       self.view.backgroundColor = BackGroundColor.getBackgrndClr()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func UpDateNoItemInYourCollectionView(totalItems: Int){
        if(totalItems<1){
             self.displayAlert(textToDisplay: "NO Item In Your Collection")
            
        }
    }
    func updatingList(count: Int){
        if(count != itemList.count){
            // there is change in item count
            guard let selectedItemIndex = selectedItemIndex else{return}
            itemList.remove(at: selectedItemIndex)
            UpDateNoItemInYourCollectionView(totalItems: itemList.count)
            self.collection.reloadData()
        }
    }
}
    
