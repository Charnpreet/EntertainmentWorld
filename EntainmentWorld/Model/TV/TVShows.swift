//
//  TVShows.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 13/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation
import UIKit
class TVShows : Decodable{
    var original_name:      String?
    var id:                 Int
    var name:               String?
    var popularity:         Double?
    var vote_count:         Int?
    var vote_average:       Float?
    var first_air_date:     String?
    var poster_path:        String?
    var genre_ids:          [Int]?
    var original_language: String?
    var backdrop_path:      String?
    var overview:           String?
    
    required public init(from jsonObject: AnyObject){
        original_name = jsonObject.object(forKey: "original_name") as? String
        id  = jsonObject.object(forKey: "id") as! Int
        name    = jsonObject.object(forKey: "name") as? String
        popularity  = jsonObject.object(forKey: "popularity") as? Double
        vote_count  = jsonObject.object(forKey: "vote_count") as? Int
        vote_average    = jsonObject.object(forKey: "vote_average") as? Float
        first_air_date  = jsonObject.object(forKey: "first_air_date") as? String
        poster_path = jsonObject.object(forKey: "poster_path") as? String
        genre_ids   = jsonObject.object(forKey: "genre_ids") as? [Int]
        original_language   = jsonObject.object(forKey: "original_language") as? String
        backdrop_path = jsonObject.object(forKey: "backdrop_path") as? String
        overview = jsonObject.object(forKey: "overview") as? String
    }
}

extension TVShows : Equatable, Hashable {
    static func == (lhs: TVShows, rhs: TVShows) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
    public func hash(into hasher: inout Hasher) {
            hasher.combine(ObjectIdentifier(self).hashValue)
}

    
}
