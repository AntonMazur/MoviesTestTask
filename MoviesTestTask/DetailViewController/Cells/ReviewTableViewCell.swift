//
//  ReviewTableViewCell.swift
//  MoviesTestTask
//
//  Created by Anton Mazur on 23.12.2023.
//

import UIKit

protocol ReviewTableViewCellDelegate: AnyObject {
    func didRequestToUpdateWatchList(with updatedMovieModel: MovieModel?)
}

final class ReviewTableViewCell: UITableViewCell {
    static let cellIdentifier = "ReviewTableViewCell"
    
    @IBOutlet private var movieImageView: UIImageView!
    @IBOutlet private var movieTitleLabel: UILabel!
    @IBOutlet private var movieRatingLabel: UILabel!
    @IBOutlet private var watchListButton: UIButton!
    
    var delegateVC: ReviewTableViewCellDelegate!
    private var detailMovieModel: MovieModel?
    
    @IBAction private func watchListButtonTapped() {
        detailMovieModel?.isInWatchList.toggle()
        let isInWatchList = detailMovieModel?.isInWatchList ?? false
        let watchListButtonTitle = isInWatchList ? "REMOVE FROM WATCHLIST" : "+ADD TO WATCHLIST"
        watchListButton.setText(watchListButtonTitle)
        delegateVC.didRequestToUpdateWatchList(with: detailMovieModel)
    }
    
    @IBAction private func watchTrailerButtonPressed() {
        guard let detailMovieModel, let url = URL(string: detailMovieModel.trailerLink), UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
    
    func configure(with movieModel: MovieModel, delegate: ReviewTableViewCellDelegate) {
        detailMovieModel = movieModel
        delegateVC = delegate
        
        movieImageView.image = movieModel.imagePreview
        movieTitleLabel.text = movieModel.title
        movieRatingLabel.text = movieModel.rating.description
        
        let watchListButtonTitle = movieModel.isInWatchList ? "REMOVE FROM WATCHLIST" : "+ADD TO WATCHLIST"
        watchListButton.setText(watchListButtonTitle)
    }
}
