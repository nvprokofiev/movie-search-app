//
//  Trending.swift
//  NewFaceTV
//
//  Created by Nikolai Prokofev on 2019-12-10.
//  Copyright © 2019 Nikolai Prokofev. All rights reserved.
//

import Foundation

enum Trending {
    
    case all(page: Int, timeWindow: TimeWindow)
    case movie(page: Int, timeWindow: TimeWindow)
    case tv(page: Int, timeWindow: TimeWindow)
    case person(page: Int, timeWindow: TimeWindow)
    
    enum TimeWindow {
        case day
        case week
    }
}

extension Trending: Endpoint {
    
    var endpointStringRepresentation: String {
        return "trending"
    }
    

    var path: String {
        switch self {
        case .all(_, let timeWindow):
                return "/\(endpointStringRepresentation)/all/\(timeWindow)"
            case .movie(_, let timeWindow):
                return "/\(endpointStringRepresentation)/movie/\(timeWindow)"
            case .tv(_, let timeWindow):
                return "/\(endpointStringRepresentation)/tv/\(timeWindow)"
            case .person(_, let timeWindow):
                return "/\(endpointStringRepresentation)/person/\(timeWindow)"
        }
    }
    
    var params: [String : Any]? {
        switch self {
        case .all(let page, _):
            return ["page": page]
        case .movie(let page, _):
            return ["page": page]
        case .tv(let page, _):
            return ["page": page]
        case .person(let page, _):
            return ["page": page]
        }
    }}
