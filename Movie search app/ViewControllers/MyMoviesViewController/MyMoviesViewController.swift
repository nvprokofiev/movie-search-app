//
//  MyMoviesViewController.swift
//  Movie search app
//
//  Created by Nikolai Prokofev on 2020-01-26.
//  Copyright © 2020 Nikolai Prokofev. All rights reserved.
//

import UIKit

class MyMoviesViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "My Movies"

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

extension MyMoviesViewController: TabBarItemable {
    
    var image: UIImage? {
        return UIImage(systemName: "folder")
    }
}
