//
//  DescriptionTableViewCell.swift
//  MoviesTestTask
//
//  Created by Anton Mazur on 23.12.2023.
//

import UIKit

final class DescriptionTableViewCell: UITableViewCell {
    static let cellIdentifier = "DescriptionTableViewCell"
    
    @IBOutlet private var movieDescriptionLabel: UILabel!
    
    func configure(with description: String) {
        movieDescriptionLabel.text = description
    }
}
