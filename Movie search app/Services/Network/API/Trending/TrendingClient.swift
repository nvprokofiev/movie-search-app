//
//  TrendingClient.swift
//  NewFaceTV
//
//  Created by Nikolai Prokofev on 2019-12-10.
//  Copyright © 2019 Nikolai Prokofev. All rights reserved.
//

import Foundation

class TrendingClient: BaseAPIClient {

    func getTrending(_ trending: Trending, completion: @escaping (Result<TrendingMovieResult?, APIError>) -> Void) {
        fetch(with: trending.request, decode: { json -> TrendingMovieResult? in
            guard let movieResult = json as? TrendingMovieResult else { return  nil }
            return movieResult
        }, completion: completion)
    }
}
