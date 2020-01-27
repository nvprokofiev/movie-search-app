//
//  PageHolder.swift
//  Movie search app
//
//  Created by Nikolai Prokofev on 2020-01-26.
//  Copyright © 2020 Nikolai Prokofev. All rights reserved.
//

import Foundation

struct PageHolder {
    
    var page = 1
    var totalPages: Int?
    
    mutating func nextPage()-> Bool {
        guard totalPages != nil else { return false }
        
        if totalPages != page {
            page += 1
            return true
        } else {
            return false
        }
    }
}
