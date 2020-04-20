//
//  MovieResponse.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 14/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation

struct MovieResponse: Decodable{
    var  results : [MoviesDetails]
      var page : Int
      var total_results: Int
      var total_pages: Int
}
