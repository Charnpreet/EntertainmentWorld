//
//  MoviesDetails.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 11/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation
class MoviesDetails : Decodable {
    var popularity:         Double?
    var vote_count:         Int?
    var video:              Bool
    var poster_path:        String?
    var id:                 Int
    var adult:              Bool
    var backdrop_path:      String?
    var original_language:  String?
    var original_title:     String?
    var genre_ids:          [Int]?
    var title:              String?
    var vote_average:       Float?
    var overview:           String?
    var release_date:       String?
    
    required public init(from jsonObject: AnyObject){
         popularity = jsonObject.object(forKey: "popularity") as? Double ?? nil
         vote_count = jsonObject.object(forKey: "vote_count") as? Int ?? nil
        video      = jsonObject.object(forKey: "video") as! Bool
         poster_path = jsonObject.object(forKey: "poster_path") as? String ?? nil
         id         = jsonObject.object(forKey: "id") as! Int
         adult      = jsonObject.object(forKey: "adult") as! Bool
        original_language = jsonObject.object(forKey: "original_language") as? String ?? nil
        backdrop_path = jsonObject.object(forKey: "backdrop_path") as? String ?? nil
        original_title = jsonObject.object(forKey: "original_title") as? String ?? nil
        genre_ids = jsonObject.object(forKey: "genre_ids") as? [Int] ?? nil
        title = jsonObject.object(forKey: "title") as? String ?? nil
        vote_average = jsonObject.object(forKey: "vote_average") as? Float ?? nil
        overview = jsonObject.object(forKey: " overview") as? String ?? nil
        release_date = jsonObject.object(forKey: "release_date") as? String ?? nil
    }
}
