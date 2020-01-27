//
//  MovieCardCollectionViewCell.swift
//  Movie search app
//
//  Created by Nikolai Prokofev on 2020-01-26.
//  Copyright © 2020 Nikolai Prokofev. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

protocol MovieCardCellDelegate: class {
    func cellTapped(with movie: TrendingMovie, in card: MovieCard)
}

class MovieCardCollectionViewCell: UICollectionViewCell {

    weak var delegate: MovieCardCellDelegate?
    
    private lazy var card: MovieCard = {
        let card = MovieCard(frame: CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.size.width, height: bounds.size.height))
        return card
    }()
    
    var movie: TrendingMovie? {
        didSet {
            guard let movie = movie else { return }
            
            card.title = movie.title
            if let raiting = movie.voteAverage {
                card.raiting = String(describing: raiting)
            }
            setBackgroundImage(with: movie.posterURL)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(card)
    }
    
    func configure(with movie: TrendingMovie, delegate: MovieCardCellDelegate){
        self.delegate = delegate
        card.delegate = self
        self.movie = movie
    }
    
    func cancelLoading() {
        card.backgroundImageView.kf.cancelDownloadTask()
    }
    
    private func setBackgroundImage(with url: URL?){
        guard let url = url else { return }
        
        ImageCache.default.retrieveImage(forKey: url.absoluteString) { [weak self] result in
            guard let `self` = self else { return }

            switch result {
            case .success(let value):
                if let image = value.image {
                    self.card.image = image
                } else {
                    self.card.backgroundImageView.kf.indicatorType = .activity
                    self.card.backgroundImageView.kf
                        .setImage(with: url, options: [.transition(.fade(0.2))])
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
extension MovieCardCollectionViewCell: MovieCardDelegate {
    
    func cardTapped(_ card: MovieCard) {
        guard let movie = movie else { return }
        delegate?.cellTapped(with: movie, in: card)
    }
}
