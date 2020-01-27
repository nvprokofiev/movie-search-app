//
//  Movie.swift
//  Movie search app
//
//  Created by Nikolai Prokofev on 2020-01-26.
//  Copyright © 2020 Nikolai Prokofev. All rights reserved.
//

import Foundation

struct Movie: Codable {
    
    let id: Int
    let title: String
    let tagline: String
    let genres: [Genre]
    let overview: String
    let popularity: Double?
    let releaseDate: String
    let voteAverage: Double?
    let backdropPath: String?
    let posterPath: String?
}
