//
//  TVShowCell.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 23/5/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

 import UIKit

class TVShowCell : BaseCollectionCell<TVShows>{
    override var item: TVShows!{
        didSet{
            let pPath = item.poster_path
            let tittle = item.name ?? ""
            let db = DBConnection()
            Shared.LoadPosterImages(cellImage : cellImage, pPath: pPath, text : tittle, db: db)
        }
    }
}

