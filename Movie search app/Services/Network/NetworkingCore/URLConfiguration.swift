//
//  URLConfiguration.swift
//  NewFaceTV
//
//  Created by Nikolai Prokofev on 2019-12-12.
//  Copyright © 2019 Nikolai Prokofev. All rights reserved.
//

import Foundation

struct URLMediaConfiguration {
    
    enum MediaSize: String {
        case w185
        case w500
    }
    
    let path: String?
    let size: MediaSize
    
    private var baseURL: String {
        return "https://image.tmdb.org/t/p"
    }
    
    func getURL()-> URL?{
        guard let path = path else { return nil }
        let fullPath = baseURL + "/" + size.rawValue + "/" + path
        return URL(string: fullPath)
    }
}
