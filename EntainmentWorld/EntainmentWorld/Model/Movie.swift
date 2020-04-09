//
//  Movie.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 9/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation

//
// this class is used load movie details from themoviedatabase
class Movie:Codable{
    var posterPath: String
    var adult: Bool
    var overview: String?
    var releaseDate: String?
    var genreIds = [Int]()
    var originalTitle: String?
    var originalLanguage: String?
    var title: String?
    var backdropPath: String?
    var popularity: Double?
    var voteCount: Int?
    var video: Bool?
    var voteAverage: Double?
    
    init(posterPath: String,adult: Bool,overview: String?,releaseDate: String?,genreIds:[Int],originalTitle: String?,originalLanguage: String?,title: String?,backdropPath: String?,popularity: Double?,voteCount: Int?,video: Bool?,voteAverage: Double?){
        self.posterPath = posterPath
        self.adult = adult
        self.overview = overview
        self.releaseDate = releaseDate
        self.genreIds = genreIds
        self.originalTitle = originalTitle
        self.originalLanguage = originalLanguage
        self.title = title
        self.backdropPath = backdropPath
        self.popularity = popularity
        self.voteCount = voteCount
        self.video = video
        self.voteAverage = voteAverage
    }
}
