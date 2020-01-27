//
//  VideoResult.swift
//  Movie search app
//
//  Created by Nikolai Prokofev on 2020-01-26.
//  Copyright © 2020 Nikolai Prokofev. All rights reserved.
//

import Foundation

struct VideoResult: Decodable {
    let id: Int
    let results: [Video]
}
