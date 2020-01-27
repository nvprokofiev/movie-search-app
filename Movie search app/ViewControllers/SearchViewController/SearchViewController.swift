//
//  SearchViewController.swift
//  Movie search app
//
//  Created by Nikolai Prokofev on 2020-01-26.
//  Copyright © 2020 Nikolai Prokofev. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Search"

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SearchViewController: TabBarItemable {
    
    var image: UIImage? {
        return UIImage(systemName: "magnifyingglass")
    }
}
