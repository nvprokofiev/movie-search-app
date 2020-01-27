//
//  MovieViewController.swift
//  Movie search app
//
//  Created by Nikolai Prokofev on 2020-01-26.
//  Copyright © 2020 Nikolai Prokofev. All rights reserved.
//

import UIKit
import Kingfisher
import YouTubePlayer

class MovieViewController: UIViewController {
    
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var posterContainerView: UIView!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var raitingLabel: UILabel!
    @IBOutlet weak var raitingView: UIView!
    @IBOutlet weak var videoPlayer: YouTubePlayerView!
    
    var configuration: MovieConfiguration?
    private var movie: Movie?
    private var videos: [Video] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConfigurationValues()
        setupPosterImageView()
        setupViews()
        fetch()
    }
    
    private func fetch() {
        
        guard let configuration = configuration else { return }
        
        MovieClient().getMovieDetails(id: configuration.id) { [weak self] result in
            switch result {
            case .success(let movie):
                self?.setMovie(movie)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        MovieClient().getMovieVideos(id: configuration.id) { [weak self] result in
            switch result {
            case .success(let videoResult):
                guard let videos = videoResult?.results, let `self` = self else { return }
                self.videos = videos
                self.videoPlayer.loadVideoID(videos.randomElement()?.key ?? "")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func setConfigurationValues() {
        guard let configuration = configuration else { return }
        titleLabel.text = configuration.title
        posterImageView.image = configuration.posterImage
        if let raiting = configuration.raiting {
            raitingLabel.text = "\(raiting)"
        } else {
            raitingView.isHidden = true
        }
    }
    
    private func setupViews(){
        raitingView.layer.cornerRadius = raitingView.frame.width/2
        raitingView.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1).withAlphaComponent(0.85)
        raitingView.layer.shadowColor = UIColor.black.cgColor
        raitingView.layer.borderColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        raitingView.layer.borderWidth = 0.5
        raitingView.layer.shadowRadius = 5
        raitingView.layer.shadowOpacity = 0.4
        raitingView.layer.shadowOffset = CGSize(width: 0, height: 0)
        raitingView.layer.shadowPath = UIBezierPath(roundedRect: raitingView.bounds, cornerRadius: raitingView.frame.height / 2.0).cgPath
        
        raitingLabel.adjustsFontSizeToFitWidth = true
        
        videoPlayer.layer.cornerRadius = 18.0
        videoPlayer.backgroundColor = .systemBackground
        videoPlayer.clipsToBounds = true
    }
    
    private func setupPosterImageView() {
        
        posterContainerView.translatesAutoresizingMaskIntoConstraints = false
        posterContainerView.clipsToBounds = false
        posterContainerView.layer.shadowOpacity = 0.6
        posterContainerView.layer.shadowColor = UIColor.systemGray2.cgColor
        posterContainerView.layer.shadowOffset = CGSize.zero
        posterContainerView.layer.shadowPath = UIBezierPath(roundedRect: posterContainerView.bounds, cornerRadius: 20).cgPath
        posterContainerView.layer.shadowRadius = 8
        
        posterImageView.clipsToBounds = true
        posterImageView.layer.cornerRadius = 18
        posterImageView.backgroundColor = .label
        posterImageView.contentMode = .scaleAspectFill
    }
    
    private func setMovie(_ movie: Movie) {
        self.movie = movie
        backdropImageView.setBackgroundImage(with: URLMediaConfiguration(path: movie.backdropPath, size: .w500).getURL())
        overviewLabel.text = movie.overview
        taglineLabel.text = movie.tagline
    }
}
