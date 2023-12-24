//
//  DetailsTableViewCell.swift
//  MoviesTestTask
//
//  Created by Anton Mazur on 23.12.2023.
//

import UIKit

final class DetailsTableViewCell: UITableViewCell {
    static let cellIdentifier = "DetailsTableViewCell"
    
    @IBOutlet private var genreLabel: UILabel!
    @IBOutlet private var releaseDateLabel: UILabel!
    
    func configure(with movieModel: MovieModel) {
        genreLabel.text = movieModel.genre
        releaseDateLabel.text = movieModel.releasedDate
    }
}
