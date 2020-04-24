//
//  UpcomingMoviesList.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 11/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation

struct MovieResponceWithDates: Decodable{
    var  results : [MoviesDetails]
      var page : Int
      var total_results: Int
      var total_pages: Int
    var dates: [String:String]
}
