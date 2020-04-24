//
//  Genre.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 17/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation

//
// Mark:- this can be used for movie and tv both
struct GenreCollection : Decodable {
    var genres : [Genre]
}

class Genre : Decodable{
    var id: Int
    var name: String
}
