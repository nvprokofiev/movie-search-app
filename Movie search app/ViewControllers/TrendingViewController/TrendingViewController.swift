//
//  TrendingViewController.swift
//  Movie search app
//
//  Created by Nikolai Prokofev on 2020-01-26.
//  Copyright © 2020 Nikolai Prokofev. All rights reserved.
//

import UIKit

class TrendingViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var movies = [TrendingMovie]()
    var pageHolder = PageHolder()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Popular Today"
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(MovieCardCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: MovieCardCollectionViewCell.self))
        fetch(page: pageHolder.page)
    }
    
    private func fetch(page: Int) {
        TrendingClient().getTrending(.all(page: page, timeWindow: .day)){ [weak self] result in
            switch result {
            case .success(let movieResult):
                
                guard let movieResult = movieResult, let `self` = self else { return }
                
                let movies = movieResult.results
                self.pageHolder.totalPages = movieResult.totalPages

                let sorted = movies.sorted {
                    guard let one = $0.popularity, let two = $1.popularity else {
                        return true
                    }
                    return one > two
                }
                self.movies.append(contentsOf: sorted)
                self.collectionView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension TrendingViewController: TabBarItemable {
    var image: UIImage? {
        return UIImage(systemName: "film")
    }
}

extension TrendingViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MovieCardCollectionViewCell.self), for: indexPath) as! MovieCardCollectionViewCell
        cell.configure(with: movies[indexPath.item], delegate: self)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MovieCardCollectionViewCell.self), for: indexPath) as! MovieCardCollectionViewCell
        cell.cancelLoading()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.item + 1 == collectionView.numberOfItems(inSection: indexPath.section) {
            if pageHolder.nextPage() {
                fetch(page: pageHolder.page)
            }
        }
    }
}


extension TrendingViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      let mainWidth = collectionView.frame.width
        let width = (mainWidth - Constants.edgeInsets.left - Constants.edgeInsets.right) / CGFloat(Constants.numberOfColumns)
        return CGSize(width: width, height: MovieCardCellLayoutHelper.getCellHeight(width: width))
    }
}

extension TrendingViewController: MovieCardCellDelegate {
    
    func cellTapped(with movie: TrendingMovie, in card: MovieCard) {
        let vc = MovieViewController()
        let configuration = MovieConfiguration(id: movie.id, title: movie.title, posterImage: card.image, raiting: movie.voteAverage)
        vc.configuration = configuration
        present(vc, animated: true)
    }
}

extension TrendingViewController {
    
    fileprivate struct Constants {
        static let spacing: CGFloat = 4
        static let edgeInsets: UIEdgeInsets = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        static let numberOfColumns: Int = 3
    }
}


