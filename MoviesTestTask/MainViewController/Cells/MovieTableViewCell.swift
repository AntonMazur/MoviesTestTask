//
//  MovieTableViewCell.swift
//  MoviesTestTask
//
//  Created by Anton Mazur on 23.12.2023.
//

import UIKit

final class MovieTableViewCell: UITableViewCell {
    static let cellIdentifier = "MovieTableViewCell"
    
    @IBOutlet private var movieImageView: UIImageView!
    @IBOutlet private var movieNameLabel: UILabel!
    @IBOutlet private var movieDescriptionLabel: UILabel!
    @IBOutlet private var inWatchListLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movieImageView.image = nil
        movieNameLabel.text = nil
        movieDescriptionLabel.text = nil
    }
    
    func configure(with movieModel: MovieModel) {
        movieImageView.image = movieModel.imagePreview
        movieNameLabel.text = movieModel.title
        movieDescriptionLabel.text = movieModel.previewDescription
        inWatchListLabel.isHidden = !movieModel.isInWatchList
    }
    
}
