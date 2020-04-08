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
        }else{
            layout.scrollDirection = .vertical
        }
        
        layout.minimumLineSpacing = 15
        return UICollectionView(frame: frame, collectionViewLayout: layout)
    }
}
