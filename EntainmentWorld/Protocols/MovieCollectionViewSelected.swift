//
//  MovieCollectionViewSelected.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 20/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation

protocol MovieCollectionViewSelectedProtocol {
    
    func collectionViewSelected(item : MoviesDetails) //_ collectionViewItem : Int
    

}

protocol  DoSegusForMovies {
    func LoadSegus(item : MoviesDetails)
}

