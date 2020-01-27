//
//  TrendingMovie.swift
//  Movie search app
//
//  Created by Nikolai Prokofev on 2020-01-26.
//  Copyright © 2020 Nikolai Prokofev. All rights reserved.
//

import Foundation

struct TrendingMovie: Codable {
    
    let id: Int
    let popularity: Double?
    let voteAverage: Double?
    let posterPath: String?
    var title: String
    
    enum CodingKeys: String, CodingKey {
        case id, popularity, voteAverage, posterPath, title
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        popularity = try container.decode(Double.self, forKey: .popularity)
        voteAverage = try container.decode(Double.self, forKey: .voteAverage)
        posterPath = try container.decode(String.self, forKey: .posterPath)
        
        let titlesContainer = try decoder.container(keyedBy: DynamicTitleKey.self)
        guard let titleKey = titlesContainer.allKeys.first else { throw DynamicTitleError.notFound }
        title = try titlesContainer.decode(String.self, forKey: titleKey)
    }
    
}

extension TrendingMovie {
    
    var posterURL: URL? {
        return URLMediaConfiguration(path: posterPath, size: .w185).getURL()
    }
}

struct DynamicTitleKey: CodingKey {
    var stringValue: String
    
    init?(stringValue: String) {
        let variants = ["title", "originalTitle", "originalName"]
        guard variants.contains(stringValue) else { return nil }
        self.stringValue = stringValue
    }
    
    var intValue: Int?
    
    init?(intValue: Int) { nil }
}

enum DynamicTitleError: Error {
    case notFound
}
