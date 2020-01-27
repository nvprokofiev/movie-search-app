//
//  UIImageView+Extensions.swift
//  Movie search app
//
//  Created by Nikolai Prokofev on 2020-01-26.
//  Copyright © 2020 Nikolai Prokofev. All rights reserved.
//

import Foundation
import UIKit.UIImage
import Kingfisher

extension UIImageView {

    func setBackgroundImage(with url: URL?){
        guard let url = url else { return }
        
        ImageCache.default.retrieveImage(forKey: url.absoluteString) { [weak self] result in
            guard let `self` = self else { return }

            switch result {
            case .success(let value):
                if let image = value.image {
                    self.image = image
                } else {
                    self.kf.indicatorType = .activity
                    self.kf.setImage(with: url, options: [.transition(.fade(0.2))])
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
