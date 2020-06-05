//
//  MovieCell.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 23/5/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit
class MovieCell : BaseCollectionCell<MoviesDetails>{
    override var item: MoviesDetails!{
        didSet{
                let pPath = item.poster_path
                let tittle = item.title ?? ""
                let db = DBConnection()
                Shared.LoadPosterImages(textLabel: self.titleTextLabel, cellImage : cellImage, pPath: pPath, text : tittle, db: db)
        }
    }
}
//
