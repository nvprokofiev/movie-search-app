//
//  TabBarItem.swift
//  Movie search app
//
//  Created by Nikolai Prokofev on 2020-01-26.
//  Copyright © 2020 Nikolai Prokofev. All rights reserved.
//

import Foundation
import UIKit

protocol TabBarItemable {
    var title: String? { get }
    var image: UIImage? { get }
    var selectedImage: UIImage? { get }
}

extension TabBarItemable {
    
    var item: UITabBarItem {
        return UITabBarItem(title: title, image: image, selectedImage: selectedImage)
    }
    
    var selectedImage: UIImage? {
        return nil
    }
}

extension TabBarItemable where Self: UIViewController {

    var title: String? {
        return self.title
    }
}
