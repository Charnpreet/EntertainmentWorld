//
//  UICollection.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 7/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation
import UIKit
class UICollection{
    
    
    // returns UICollectionView
    public static func getUICollections(HScrolling:Bool, frame: CGRect, layout: UICollectionViewFlowLayout)->UICollectionView{
        if(HScrolling){
           layout.scrollDirection = .horizontal
             layout.minimumLineSpacing = 15
        }else{
            layout.scrollDirection = .vertical
             layout.minimumLineSpacing = 8
        }
        let collection = UICollectionView(frame: frame, collectionViewLayout: layout)
        collection.backgroundColor = BackGroundColor.getBackgrndClr()    //.black
       collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }
}
