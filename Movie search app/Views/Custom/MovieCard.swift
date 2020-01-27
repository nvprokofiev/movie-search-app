//
//  MovieCard.swift
//  Movie search app
//
//  Created by Nikolai Prokofev on 2020-01-26.
//  Copyright © 2020 Nikolai Prokofev. All rights reserved.
//

import Foundation
import UIKit

protocol MovieCardDelegate: class {
    func cardTapped(_ card: MovieCard)
}

struct MovieCardCellLayoutHelper {
    static func getCellHeight(width: CGFloat) -> CGFloat {
        return width / Constants.posterAspectRatio + Constants.titleLabelHeight
    }
}

class MovieCard: UIView {
    
    var title: String = String() {
        didSet {
            titleLabel.text = title
        }
    }
    
    var raiting: String = String() {
        didSet {
            raitingLabel.text = raiting
        }
    }
    
    var image: UIImage? {
        didSet {
            guard let image = image else { return }
            backgroundImageView.image = image
        }
    }
    
    private let titleLabel = UILabel()
    private let raitingView = UIView()
    private let raitingLabel = UILabel()
    private let imageViewContainer = UIView()
    private var tap = UITapGestureRecognizer()
    let backgroundImageView = UIImageView()
    
    weak var delegate: MovieCardDelegate?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSubviews()
    }
    
    private func initialize() {
        tap.cancelsTouchesInView = false
        addGestureRecognizer(tap)
        tap.delegate = self
        tap.cancelsTouchesInView = false
    }
    
    private func addSubviews() {
        imageViewContainer.addSubview(backgroundImageView)
        addSubview(imageViewContainer)
        addSubview(titleLabel)
        backgroundImageView.addSubview(raitingView)
        raitingView.addSubview(raitingLabel)
    }
    
    //MARK: - Setup Views
    private func setupView() {
        clipsToBounds = true
    }
    
    fileprivate func setupTitleLabel() {
        titleLabel.textColor = .label
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 14.0, weight: .medium)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.4
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 2
        titleLabel.baselineAdjustment = .none
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    fileprivate func setupBackgroundImageView() {
        imageViewContainer.translatesAutoresizingMaskIntoConstraints = false
        imageViewContainer.clipsToBounds = false
        imageViewContainer.layer.shadowOpacity = 0.6
        imageViewContainer.layer.shadowColor = UIColor.systemGray2.cgColor
        imageViewContainer.layer.shadowOffset = CGSize.zero
        imageViewContainer.layer.shadowPath = UIBezierPath(roundedRect: imageViewContainer.bounds, cornerRadius: 20).cgPath
        imageViewContainer.layer.shadowRadius = 8
        
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.isUserInteractionEnabled = true
        backgroundImageView.clipsToBounds = true
        backgroundImageView.layer.cornerRadius = 18
        backgroundImageView.backgroundColor = .label
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.frame.origin = bounds.origin
        backgroundImageView.frame.size = CGSize(width: bounds.width, height: bounds.height)
        backgroundImageView.image = image
    }
    
    fileprivate func setupRaitingView() {
        raitingView.layer.cornerRadius = raitingView.frame.width/2
        raitingView.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1).withAlphaComponent(0.85)
        raitingView.layer.shadowColor = UIColor.black.cgColor
        raitingView.layer.borderColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        raitingView.layer.borderWidth = 0.5
        raitingView.layer.shadowRadius = 5
        raitingView.layer.shadowOpacity = 0.4
        raitingView.layer.shadowOffset = CGSize(width: 0, height: 0)
        raitingView.layer.shadowPath = UIBezierPath(roundedRect: raitingView.bounds, cornerRadius: raitingView.frame.height / 2.0).cgPath
        raitingView.translatesAutoresizingMaskIntoConstraints = false
        
        raitingLabel.textColor = .white
        raitingLabel.textAlignment = .center
        raitingLabel.adjustsFontSizeToFitWidth = true
        raitingLabel.translatesAutoresizingMaskIntoConstraints = false
        raitingLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        raitingLabel.adjustsFontSizeToFitWidth = true
    }
    
    override open func draw(_ rect: CGRect) {
        super.draw(rect)
        
        setupView()
        setupTitleLabel()
        setupRaitingView()
        setupBackgroundImageView()
        layout()
    }
    
    private func layout() {
        
        NSLayoutConstraint.activate([
            imageViewContainer.topAnchor.constraint(equalTo: topAnchor, constant: Constants.imageViewInsets.top),
            imageViewContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.imageViewInsets.left),
            imageViewContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.imageViewInsets.right),
            imageViewContainer.heightAnchor.constraint(equalToConstant: bounds.width / Constants.posterAspectRatio)
        ])
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: imageViewContainer.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: imageViewContainer.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: imageViewContainer.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: imageViewContainer.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            raitingView.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor, constant: -Constants.spacing / 2),
            raitingView.topAnchor.constraint(equalTo: backgroundImageView.topAnchor, constant: Constants.spacing / 2),
            raitingView.widthAnchor.constraint(equalToConstant: Constants.raitingViewSize),
            raitingView.heightAnchor.constraint(equalTo: raitingView.widthAnchor),
        ])
        
        NSLayoutConstraint.activate([
            raitingLabel.centerYAnchor.constraint(equalTo: raitingView.centerYAnchor),
            raitingLabel.centerXAnchor.constraint(equalTo: raitingView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: Constants.spacing)
        ])
        
        raitingLabel.sizeToFit()
        titleLabel.sizeToFit()
    }
    
    //MARK: - Animations
    private func shrinkAnimated() {
        UIView.animate(withDuration: 0.1, animations: { self.imageViewContainer.transform = CGAffineTransform(scaleX: 0.9, y: 0.9) })
    }
    
    private func resetAnimated() {
        UIView.animate(withDuration: 0.1, animations: { self.imageViewContainer.transform = CGAffineTransform.identity })
    }
}

extension MovieCard: UIGestureRecognizerDelegate {
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        shrinkAnimated()
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        resetAnimated()
        delegate?.cardTapped(self)
    }
    
    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        resetAnimated()
    }
}

fileprivate struct Constants {
    
    static let posterAspectRatio: CGFloat = 2/3
    static let imageViewInsets: UIEdgeInsets = UIEdgeInsets(top: 12.0, left: 12.0, bottom: 12.0, right: 12.0)
    static let spacing: CGFloat = 8.0
    static let raitingViewSize: CGFloat = 28.0
    static let titleLabelHeight: CGFloat = 54.0
}
