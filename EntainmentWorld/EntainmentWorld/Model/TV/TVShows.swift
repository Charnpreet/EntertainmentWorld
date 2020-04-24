//
//  TVShows.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 13/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation
class TVShows : Decodable {
    var original_name: String?
    var id: Int
    var name: String?
    var popularity: Double?
    var vote_count: Int?
    var vote_average: Float?
    var first_air_date: String?
    var poster_path: String?
    var genre_ids: [Int]?
    var original_language: String?
    var backdrop_path: String?
    var overview: String?
}
