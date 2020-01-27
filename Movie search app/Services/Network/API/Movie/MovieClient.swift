//
//  MovieClient.swift
//  NewFaceTV
//
//  Created by Nikolai Prokofev on 2019-12-10.
//  Copyright © 2019 Nikolai Prokofev. All rights reserved.
//

import Foundation

class MovieClient: BaseAPIClient {

    func getMovieDetails(id: Int, completion: @escaping (Result<Movie, APIError>) -> Void) {
        let request = MovieAPI.details(id: id).request
        fetch(with: request, decode: { json -> Movie? in
            guard let movie = json as? Movie else { return nil }
            return movie
        }, completion: completion)
    }

    func getMovieVideos(id: Int, completion: @escaping (Result<VideoResult?, APIError>) -> Void) {
        let request = MovieAPI.videos(id: id).request
        fetch(with: request, decode: { json -> VideoResult? in
            guard let videoResult = json as? VideoResult else { return nil }
            return videoResult
        }, completion: completion)
    }

}
