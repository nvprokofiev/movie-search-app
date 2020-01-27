//
//  MovieAPI.swift
//  NewFaceTV
//
//  Created by Nikolai Prokofev on 2019-12-10.
//  Copyright © 2019 Nikolai Prokofev. All rights reserved.
//

import Foundation

enum MovieAPI {
    case details(id: Int)
    case videos(id: Int)
}

extension MovieAPI: Endpoint {
    
    var endpointStringRepresentation: String {
        return "movie"
    }
    
    var path: String {
        switch self {
        case .details(let id):
            return "/\(endpointStringRepresentation)/\(id)"
        case .videos(let id):
            return "/\(endpointStringRepresentation)/\(id)/videos"
        }
    }
}
