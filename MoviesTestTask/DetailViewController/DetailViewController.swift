//
//  DetailViewController.swift
//  MoviesTestTask
//
//  Created by Anton Mazur on 23.12.2023.
//

import UIKit

final class DetailViewController: UIViewController {
    private enum Sections: Int {
        case review = 0
        case description = 1
        case details = 2
    }
    
    @IBOutlet private var detailsTableView: UITableView!
    
    var viewModel: DetailVCViewModel!
    var delegate: ReviewTableViewCellDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        setupTableView()
    }
    
    private func setupTableView() {
        detailsTableView.delegate = self
        detailsTableView.dataSource = self
        detailsTableView.allowsSelection = false
        
        detailsTableView.register(.init(nibName: "ReviewTableViewCell", bundle: nil), forCellReuseIdentifier: ReviewTableViewCell.cellIdentifier)
        detailsTableView.register(.init(nibName: "DescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: DescriptionTableViewCell.cellIdentifier)
        detailsTableView.register(.init(nibName: "DetailsTableViewCell", bundle: nil), forCellReuseIdentifier: DetailsTableViewCell.cellIdentifier)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        
        let section = Sections(rawValue: indexPath.row)
        switch section {
        case .review:
            let reviewCell = tableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.cellIdentifier, for: indexPath) as? ReviewTableViewCell
            reviewCell?.configure(with: viewModel.movieModel, delegate: delegate)
            cell = reviewCell
        case .description:
            let descriptionCell = tableView.dequeueReusableCell(withIdentifier: DescriptionTableViewCell.cellIdentifier, for: indexPath) as? DescriptionTableViewCell
            descriptionCell?.configure(with: viewModel.movieModel.description)
            cell = descriptionCell
        case .details:
            let detailsCell = tableView.dequeueReusableCell(withIdentifier: DetailsTableViewCell.cellIdentifier, for: indexPath) as? DetailsTableViewCell
            detailsCell?.configure(with: viewModel.movieModel)
            cell = detailsCell
        default: break
        }
        
        guard let cell else { fatalError("Cell was not initialised, check implementation") }
        return cell
    }
    
}
