//
//  BaseVCForGenreCategoryList.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 4/6/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit
import Foundation
class BaseVCForGenreCategoryList<U: BaseCollectionCell<T>, T: Hashable>: RootVCForCollectionView<U, T>  {
    let db = DBConnection()
    let nvigationLabel = UILabel(frame: CGRect(x: 0, y: 0, width: Constants.IOS_SCREEN_WIDTH, height: 40))
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
        override func viewWillAppear(_ animated: Bool) {
               self.navigationController?.navigationBar.topItem?.title = Constants.EMPTY_TEXT
               nvigationLabel.textColor = .red
               nvigationLabel.textAlignment = .center
               self.navigationController?.navigationBar.addSubview(nvigationLabel)
           }
           
           override func viewWillDisappear(_ animated: Bool) {
               self.navigationController?.navigationBar.topItem?.title = Constants.EMPTY_TEXT
               nvigationLabel.removeFromSuperview()
           }
       override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell =  super.collectionView(collectionView, cellForItemAt: indexPath) as! CollectionViewCell
        return cell
           }
}
