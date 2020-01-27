//
//  TabBarController.swift
//  Movie search app
//
//  Created by Nikolai Prokofev on 2020-01-26.
//  Copyright © 2020 Nikolai Prokofev. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTabs()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    private func setupTabs() {
        let trendingVC = TrendingViewController()
        let searchVC = SearchViewController()
        let myMoviesVC = MyMoviesViewController()

        trendingVC.tabBarItem = trendingVC.item
        searchVC.tabBarItem = searchVC.item
        myMoviesVC.tabBarItem = myMoviesVC.item

        viewControllers = [trendingVC, searchVC, myMoviesVC].map { UINavigationController(rootViewController: $0) }
    }
    

}
