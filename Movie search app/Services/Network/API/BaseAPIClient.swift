//
//  BaseAPIClient.swift
//  NewFaceTV
//
//  Created by Nikolai Prokofev on 2019-12-12.
//  Copyright © 2019 Nikolai Prokofev. All rights reserved.
//

import Foundation

class BaseAPIClient: APIClient {
    
    var session: URLSession
    
    init() {
        self.session = URLSession(configuration: .default)
    }
}
