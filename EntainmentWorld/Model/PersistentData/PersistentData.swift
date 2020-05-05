//
//  TextFile.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 4/5/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation

//
// this will be used to write and read ids from textfile
// ids will be movie id , tv id or any other id
// text file is used to save fav collections ids
// it will let user save fav movies to their collections
struct PersistentData: Codable {
   var movies: [ MoviesIds] // will have id of movies
    var tvshows: [ TVShowsIds] // will have id of tv shows
}

struct MoviesIds: Codable{
    var  id : Int
}

struct  TVShowsIds: Codable{
    var  id : Int
}
