//
//  MoviesDetails.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 11/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation
class MoviesDetails : Decodable {
    var popularity: Double?
    var vote_count: Int?
    var video: Bool
    var poster_path: String
    var id: Int
    var adult: Bool
    var backdrop_path: String?
    var original_language: String?
    var original_title: String?
    var genre_ids: [Int]
    var title: String?
    var vote_average: Float
    var overview: String?
    var release_date: String?
}
