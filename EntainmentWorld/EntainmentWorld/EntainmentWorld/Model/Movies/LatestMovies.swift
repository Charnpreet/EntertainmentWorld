//
//  LatestMovies.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 11/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation
struct LatestMoviesList: Decodable {
   var result : [LatestMovies]
}
class LatestMovies : Decodable {
    var adult: Bool
    var backdrop_path : String?
    var belongs_to_collection: String?
    var budget : Double
     var genres: [Int]
     var homepage: String
     var id: Int
     var imdb_id: Int?
     var original_language: String
     var original_title: String
     var overview: String
     var popularity: Int
     var poster_path: String
     var production_companies: [String]
     var production_countries: [String]
     var release_date : String
     var revenue: Int
     var runtime : Double
     var spoken_languages: [String]
     var status : String
     var tagline: String
     var title: String
     var video : Bool
     var vote_average: Int
     var vote_count: Int
}
